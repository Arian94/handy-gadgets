import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'utils/apis.dart';

class CurrencyTimeChart extends StatefulWidget {
  const CurrencyTimeChart({
    super.key,
    required this.toUnit,
    required this.fromUnit,
  });

  final String toUnit;
  final String fromUnit;

  @override
  State<CurrencyTimeChart> createState() => _CurrencyTimeChartState();
}

class _CurrencyTimeChartState extends State<CurrencyTimeChart> {
  Map<int, MapEntry<String, double>> ratesAsMap = {};

  final maxDataPoints = 30;

  // Helper function to get the maximum Y value for the chart's upper bound
  double get maxY {
    final values = ratesAsMap.values;
    if (values.isEmpty) {
      return 10.0;
    }
    return ratesAsMap.values
            .map((spot) => spot.value)
            .reduce((a, b) => a > b ? a : b) +
        1.0;
  }

  double get chartContentWidth => (maxDataPoints * 60.0) + 50.0; // 50px buffer

  @override
  void initState() {
    super.initState();
    fetchTimeSeries();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    fetchTimeSeries();
  }

  void fetchTimeSeries() async {
    if (widget.fromUnit.isEmpty || widget.toUnit.isEmpty) {
      return;
    }
    setState(() {
      ratesAsMap = {};
    });
    final result = await CurrencyApi.fetchTimeSeries(
      base: widget.fromUnit,
      target: widget.toUnit,
      startDate: DateTime.now()
          .subtract(const Duration(days: 30))
          .toIso8601String()
          .split("T")
          .first,
      endDate: DateTime.now().toIso8601String().split("T").first,
    );
    setState(() {
      final rates = result['rates'];
      ratesAsMap = rates.entries.toList().asMap();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ratesAsMap.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    // Calculate the width of the chart container area
    final double containerWidth = MediaQuery.of(context).size.width * 0.9;
    final double screenWidth =
        containerWidth - (2 * 0); // Container width - padding (24 on each side)
    final double finalChartWidth = chartContentWidth > screenWidth
        ? chartContentWidth
        : screenWidth;

    return SizedBox(
      height: 250,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          height: 250,
          width:
              finalChartWidth, // The width is now dynamic (wider than screen if needed)
          child: LineChart(
            LineChartData(
              // 1. Grid and Border Styling
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(color: Colors.grey.shade200, strokeWidth: 1);
                },
                getDrawingVerticalLine: (value) {
                  return FlLine(color: Colors.grey.shade100, strokeWidth: 1);
                },
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),

              // 2. Axis Ranges
              minX: 0,
              maxX: maxDataPoints - 1,
              minY: 0,
              maxY: maxY, // Dynamically set max Y based on data
              // 3. Title Configuration (Labels)
              titlesData: FlTitlesData(
                show: true,
                topTitles: AxisTitles(
                  // MODIFIED: Enabled and customized top titles for the chart title
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28, // Reserve space for the title
                    getTitlesWidget: (value, meta) {
                      // We only want the title widget to appear once, usually at the first interval (value 0)
                      if (value == 3) {
                        // Centered roughly in the middle of the X-axis (0-6)
                        return SideTitleWidget(
                          space: 4,
                          meta: meta,
                          child: Text(
                            '${widget.fromUnit} / ${widget.toUnit} Currency Ratio',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.indigo,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  // X-Axis (Days)
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: getBottomTitles,
                    interval: 1,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: getLeftTitles,
                    interval: 2,
                  ),
                ),
              ),

              // 4. Touch Interaction (Tooltips)
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  // to: Colors.indigo.withOpacity(0.8),
                  getTooltipItems: (List<LineBarSpot> touchedSpots) {
                    return touchedSpots.map((spot) {
                      return LineTooltipItem(
                        '${ratesAsMap[spot.x]!.key}\n',
                        const TextStyle(
                          color: Colors.white60,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text:
                                '${widget.fromUnit} / ${widget.toUnit} = ${spot.y.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      );
                    }).toList();
                  },
                ),
                handleBuiltInTouches: true,
              ),

              // 5. Line Data (The actual plot)
              lineBarsData: [
                LineChartBarData(
                  spots: ratesAsMap.entries.map((item) {
                    return FlSpot(item.key as double, item.value.value);
                  }).toList(),
                  isCurved: true,
                  color: Colors.indigo,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: true), // Show data points
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.withValues(alpha: .3),
                        Colors.indigo.withValues(alpha: .0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Custom function to create X-axis titles (Days 1 to 7)
  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );

    return SideTitleWidget(
      space: 8.0,
      meta: meta,
      child: Text(ratesAsMap[value.toInt()]?.key ?? 'no key', style: style),
    );
  }

  // Custom function to create Y-axis titles (k$ increments)
  Widget getLeftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    String text = value.toInt().toString();

    return SideTitleWidget(
      space: 12.0,
      meta: meta,
      child: Text(text, style: style, textAlign: TextAlign.right),
    );
  }
}

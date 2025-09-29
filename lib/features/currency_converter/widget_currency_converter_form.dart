import 'package:flutter/material.dart';

import 'provider_unit_change.dart';
import 'utils/units.dart';

class CurrencyConverterForm extends StatefulWidget {
  const CurrencyConverterForm({super.key});

  @override
  State<CurrencyConverterForm> createState() => _CurrencyConverterFormState();
}

class _CurrencyConverterFormState extends State<CurrencyConverterForm> {
  final fromController = TextEditingController();
  final toController = TextEditingController();

  List<String> units = [];
  Map<String, double> unitToRates = {};
  String date = '';
  String fromUnit = '';
  String toUnit = '';
  double fromValue = 0;
  double toValue = 0;

  @override
  void initState() {
    super.initState();
    fetchUnitsAndFactors().then((result) {
      setState(() {
        units = result['units'];
        unitToRates = result['unitToRates'];
        date = result['date'];
        fromUnit = units.first;
        toUnit = units.length > 1 ? units[1] : units.first;
      });

      if (mounted) {
        final unitChangeNotif = UnitChangeProvider.of(context);
        unitChangeNotif.updateFromUnit(fromUnit);
        unitChangeNotif.updateToUnit(toUnit);
      }
    });
  }

  Future<Map<String, dynamic>> fetchUnitsAndFactors() async {
    return await CurrencyUnits().fetchUnitsAndFactors();
  }

  double convertUnit(double value, String from, String to) {
    if (!unitToRates.containsKey(from) || !unitToRates.containsKey(to)) {
      return value;
    }
    double valueInBase = value / unitToRates[from]!;
    return valueInBase * unitToRates[to]!;
  }

  void updateToValue() {
    final value = double.tryParse(fromController.text) ?? 0;
    final result = convertUnit(value, fromUnit, toUnit);
    toController.text = result.toString();
  }

  void updateFromValue() {
    final value = double.tryParse(toController.text) ?? 0;
    final result = convertUnit(value, toUnit, fromUnit);
    fromController.text = result.toString();
  }

  void swapUnits() {
    setState(() {
      final tempUnit = fromUnit;
      fromUnit = toUnit;
      toUnit = tempUnit;
      final tempValue = fromController.text;
      fromController.text = toController.text;
      toController.text = tempValue;
    });
    updateToValue();
  }

  @override
  Widget build(BuildContext context) {
    if (units.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    final unitChangeNotifier = UnitChangeProvider.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Updated at: "),
            Text(date, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Flexible(
              flex: 0,
              child: Container(
                constraints: BoxConstraints.tight(Size(180, 56)),
                alignment: Alignment.bottomCenter,
                child: InputDecorator(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 16,
                    ),
                    isDense: true,
                    border: UnderlineInputBorder(),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: fromUnit,
                      items: units
                          .map(
                            (u) => DropdownMenuItem(value: u, child: Text(u)),
                          )
                          .toList(),
                      onChanged: (v) {
                        setState(() => fromUnit = v!);
                        updateToValue();
                        unitChangeNotifier.updateFromUnit(v!);
                      },
                      isDense: true,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: fromController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Value'),
                onChanged: (_) => updateToValue(),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 2),
            ),
            child: IconButton(
              icon: Icon(Icons.swap_vert),
              style: TextButton.styleFrom(padding: EdgeInsets.only(left: 1)),
              onPressed: swapUnits,
            ),
          ),
        ),
        Row(
          children: [
            Flexible(
              flex: 0,
              child: Container(
                constraints: BoxConstraints.tight(Size(180, 56)),
                alignment: Alignment.bottomCenter,
                child: InputDecorator(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 16,
                    ),
                    isDense: true,
                    border: UnderlineInputBorder(),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: toUnit,
                      items: units
                          .map(
                            (u) => DropdownMenuItem(value: u, child: Text(u)),
                          )
                          .toList(),
                      onChanged: (v) {
                        setState(() => toUnit = v!);
                        updateToValue();
                        unitChangeNotifier.updateToUnit(v!);
                      },
                      isDense: true,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: toController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Value'),
                onChanged: (_) => updateFromValue(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

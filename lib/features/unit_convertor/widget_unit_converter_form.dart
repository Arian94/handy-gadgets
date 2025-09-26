import 'package:flutter/material.dart';

import 'utils/units.dart';

class UnitConverterForm extends StatefulWidget {
  final String type;
  const UnitConverterForm({super.key, required this.type});

  @override
  State<UnitConverterForm> createState() => _UnitConverterFormState();
}

class _UnitConverterFormState extends State<UnitConverterForm> {
  final fromController = TextEditingController();
  final toController = TextEditingController();
  late List<String> units;
  late Map<String, double> unitToFactors;

  String fromUnit = 'Meter';
  String toUnit = 'Kilometer';
  double fromValue = 0;
  double toValue = 0;

  @override
  void initState() {
    super.initState();
    final result = makeUnitsAndFactors(widget.type);
    units = result['units'];
    unitToFactors = result['unitToFactors'];
    fromUnit = units.first;
    toUnit = units.length > 1 ? units[1] : units.first;
  }

  @override
  void didUpdateWidget(UnitConverterForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.type != widget.type) {
      final result = makeUnitsAndFactors(widget.type);
      units = result['units'];
      unitToFactors = result['unitToFactors'];
      fromUnit = units.first;
      toUnit = units.length > 1 ? units[1] : units.first;
      fromController.clear();
      toController.clear();
    }
  }

  Map<String, dynamic> makeUnitsAndFactors(String type) {
    late Map<String, dynamic> result;

    if (type == 'length') {
      result = LengthUnits().makeUnitsAndFactors();
    } else if (type == 'time') {
      result = TimeUnits().makeUnitsAndFactors();
    } else if (type == 'weight') {
      result = WeightUnits().makeUnitsAndFactors();
    }

    return {'units': result['units'], 'unitToFactors': result['unitToFactors']};
  }

  double convertUnit(double value, String from, String to) {
    if (!unitToFactors.containsKey(from) || !unitToFactors.containsKey(to)) {
      return value;
    }
    double valueInBase = value * unitToFactors[from]!;
    return valueInBase / unitToFactors[to]!;
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
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 0,
              child: Container(
                constraints: BoxConstraints.tight(Size(180, 48)),
                alignment: Alignment.bottomCenter,
                child: InputDecorator(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
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
                      },
                      isDense: true,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
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
              icon: Icon(Icons.swap_horiz),
              onPressed: swapUnits,
            ),
          ),
        ),
        Row(
          children: [
            Flexible(
              flex: 0,
              child: Container(
                constraints: BoxConstraints.tight(Size(180, 48)),
                alignment: Alignment.bottomCenter,
                child: InputDecorator(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
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
                      },
                      isDense: true,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
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

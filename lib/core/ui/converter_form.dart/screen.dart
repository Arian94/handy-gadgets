import 'package:flutter/material.dart';
import 'package:handy_gadgets_app/core/ui/converter_form.dart/widget_dropdown.dart';
import 'package:handy_gadgets_app/core/ui/converter_form.dart/widget_swap_button.dart';
import 'package:handy_gadgets_app/core/ui/converter_form.dart/widget_text_field.dart';

class UnitConverterForm extends StatefulWidget {
  final Map<String, dynamic> unitsAndFactors;

  const UnitConverterForm({super.key, required this.unitsAndFactors});

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
    units = widget.unitsAndFactors['units'];
    unitToFactors = widget.unitsAndFactors['unitToFactors'];
    fromUnit = units.first;
    toUnit = units.length > 1 ? units[1] : units.first;

    super.initState();
  }

  @override
  void didUpdateWidget(UnitConverterForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.unitsAndFactors != widget.unitsAndFactors) {
      units = widget.unitsAndFactors['units'];
      unitToFactors = widget.unitsAndFactors['unitToFactors'];
      fromUnit = units.first;
      toUnit = units.length > 1 ? units[1] : units.first;
      fromController.clear();
      toController.clear();
    }
  }

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();

    super.dispose();
  }

  String convertUnit(double value, String from, String to) {
    if (!unitToFactors.containsKey(from) || !unitToFactors.containsKey(to)) {
      return value.toStringAsFixed(3);
    }
    double valueInBase = value * unitToFactors[from]!;
    return (valueInBase / unitToFactors[to]!).toStringAsFixed(3);
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
              child: DropdownWidget(
                unitList: units,
                selectedUnit: fromUnit,
                onUnitChanged: (value) {
                  setState(() => fromUnit = value);
                  updateToValue();
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: TextFieldWidget(
                controller: fromController,
                onValueChanged: (_) => updateToValue(),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
          child: SwapButtonWidget(swapUnits: swapUnits),
        ),
        Row(
          children: [
            Flexible(
              flex: 0,
              child: DropdownWidget(
                unitList: units,
                selectedUnit: toUnit,
                onUnitChanged: (value) {
                  setState(() => toUnit = value);
                  updateToValue();
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: TextFieldWidget(
                controller: toController,
                onValueChanged: (_) {
                  updateFromValue();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

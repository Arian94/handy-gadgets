import 'package:flutter/material.dart';
import 'package:handy_gadgets_app/features/unit_convertor/utils/units.dart';

class DropdownWidget extends StatelessWidget {
  final UnitList unitList;
  final String selectedUnit;
  final ValueChanged<String> onUnitChanged;

  const DropdownWidget({
    super.key,
    required this.unitList,
    required this.selectedUnit,
    required this.onUnitChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.tightFor(width: 180, height: 56),
      alignment: Alignment.bottomCenter,
      child: InputDecorator(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 16),
          isDense: true,
          border: UnderlineInputBorder(),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedUnit,
            items: unitList
                .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                .toList(),
            onChanged: (v) {
              if (v != null) {
                onUnitChanged(v);
              }
            },
            isDense: true,
          ),
        ),
      ),
    );
  }
}

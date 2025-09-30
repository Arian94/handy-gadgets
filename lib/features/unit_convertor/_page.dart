import 'package:flutter/material.dart';

import 'package:handy_gadgets_app/core/ui/converter_form.dart/screen.dart';
import 'package:handy_gadgets_app/features/unit_convertor/widget_tab_bar.dart';
import 'utils/units.dart';

class UnitConverterPage extends StatefulWidget {
  const UnitConverterPage({super.key});

  @override
  State<StatefulWidget> createState() => _UnitConverterPageState();
}

class _UnitConverterPageState extends State<UnitConverterPage> {
  static const tabNames = ['length', 'time', 'weight'];

  String activeTab = tabNames[0];

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: tabNames.length,
          child: Column(
            children: [
              TabBarWidget(
                tabNames: tabNames,
                onTap: (index) {
                  setState(() {
                    activeTab = tabNames[index];
                  });
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: UnitConverterForm(
            unitsAndFactors: makeUnitsAndFactors(activeTab),
          ),
        ),
      ],
    );
  }
}

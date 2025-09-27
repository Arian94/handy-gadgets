import 'package:flutter/material.dart';

import 'provider_unit_change.dart';
import 'widget_currency_converter_form.dart';
import 'widget_currency_time_chart.dart';

class ConverterTabScreen extends StatelessWidget {
  const ConverterTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final unitChangeNotifier = UnitChangeProvider.of(context);

    return ListenableBuilder(
      listenable: unitChangeNotifier,
      builder: (context, _) => Column(
        children: [
          CurrencyConverterForm(),
          SizedBox(height: 40),
          CurrencyTimeChart(
            fromUnit: unitChangeNotifier.fromUnit,
            toUnit: unitChangeNotifier.toUnit,
          ),
        ],
      ),
    );
  }
}

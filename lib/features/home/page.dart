import 'package:flutter/material.dart';
import 'package:handy_gadgets_app/features/home/widget_currency_converter_button.dart';
import 'package:handy_gadgets_app/features/home/widget_notes_button.dart';
import 'package:handy_gadgets_app/features/home/widget_unit_converter_button.dart';

import 'utils/circular_flow_delegate.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: CircularFlowDelegate(),
      children: [
        UnitConverterButtonWidget(),
        CurrencyConverterButtonWidget(),
        NotesButtonWidget(),
      ],
    );
  }
}

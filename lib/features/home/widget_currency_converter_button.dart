import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handy_gadgets_app/main.dart';

class CurrencyConverterButtonWidget extends StatelessWidget {
  const CurrencyConverterButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 155,
      width: 155,
      decoration: BoxDecoration(
        color: Colors.indigo.shade300.withValues(alpha: .1),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            color: Colors.indigo.shade300.withValues(
              alpha: .3,
            ), // Shadow color and opacity
            spreadRadius: 1, // Extends the shadow outwards
            blurRadius: 15, // Softens the shadow edges
          ),
        ],
      ),
      child: TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.only(bottom: 12)),
        onPressed: () {
          Navigator.pushNamed(context, RouteNames.currencyConverter);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/currency_converter.svg'),
            Text("Currency Converter", style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}

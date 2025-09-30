import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handy_gadgets_app/main.dart';

import 'utils/circular_flow_delegate.dart';
import 'utils/triangle_border.dart';
import 'utils/triangle_shape.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: CircularFlowDelegate(),
      children: [
        CustomPaint(
          painter: TrianglePainter(),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.unitConverter);
            },
            style: ElevatedButton.styleFrom(
              shape: TriangleBorder(
                side: BorderSide(width: 4, color: Colors.transparent),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            ),
            child: SizedBox(
              height: 80,
              child: Column(
                children: [
                  const Text("Unit Converter"),
                  SizedBox(height: 8),
                  SvgPicture.asset(
                    'assets/icons/unit_converter.svg',
                    height: 36,
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
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
        ),
        Container(
          height: 140,
          width: 120,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withValues(
                  alpha: 0.4,
                ), // Shadow color and opacity
                spreadRadius: 2, // Extends the shadow outwards
                blurRadius: 10, // Softens the shadow edges
                offset: const Offset(0, 8), // Moves the shadow down and right
              ),
            ],
          ),
          child: Stack(
            alignment: AlignmentGeometry.center,
            children: [
              SvgPicture.asset('assets/icons/notes.svg'),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.notesList);
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.transparent),
                  ),
                  padding: EdgeInsets.only(
                    top: 60,
                    bottom: 60,
                    right: 35,
                    left: 40,
                  ),
                  backgroundColor: Colors.transparent,
                ),
                child: Text(
                  "Notes",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

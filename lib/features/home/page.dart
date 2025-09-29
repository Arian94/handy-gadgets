import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handy_gadgets_app/main.dart';

import 'utils/circular_flow_delegate.dart';
import 'utils/triangle_border.dart';
import 'utils/trianlge_shape.dart';

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
                    'assets/icons/unit-converter.svg',
                    height: 36,
                  ),
                ],
              ),
            ),
          ),
        ),
        Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Container(
              height: 150,
              // width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.shade100.withValues(
                      alpha: .3,
                    ), // Shadow color and opacity
                    spreadRadius: 2, // Extends the shadow outwards
                    blurRadius: 10, // Softens the shadow edges
                    offset: const Offset(
                      0,
                      8,
                    ), // Moves the shadow down and right
                  ),
                ],
              ),
              child: SvgPicture.asset('assets/icons/currency-converter.svg'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.currencyConverter);
              },
              style: TextButton.styleFrom(
                shape: CircleBorder(
                  side: BorderSide(width: 4, color: Colors.transparent),
                ),
                padding: EdgeInsets.all(80),
                backgroundColor: Colors.transparent,
              ),
              child: Container(
                padding: EdgeInsets.only(top: 10),
                child: const Text(""),
              ),
            ),
            Positioned(
              bottom: -2,
              child: Text(
                "Currency Converter",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Stack(
          alignment: AlignmentGeometry.center,
          children: [
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
                    offset: const Offset(
                      0,
                      8,
                    ), // Moves the shadow down and right
                  ),
                ],
              ),
              child: SvgPicture.asset('assets/icons/notes.svg'),
            ),
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
                  left: 45,
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
      ],
    );
  }
}

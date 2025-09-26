import 'package:flutter/material.dart';
import 'package:handy_gadgets_app/main.dart';

import 'utils/circular_flow_delegate.dart';
import 'utils/triangle_border.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: CircularFlowDelegate(),
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.unitConverter);
          },
          style: ElevatedButton.styleFrom(
            shape: TriangleBorder(
              side: BorderSide(width: 4, color: Colors.black87),
            ),
            padding: EdgeInsets.all(60),
          ),
          child: const Text("Unit Converter"),
        ),
        ElevatedButton(
          onPressed: () {
            return;
          },
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 4, color: Colors.black87),
            ),
            padding: EdgeInsets.all(60),
          ),
          child: const Text("Currency Converter"),
        ),
        ElevatedButton(
          onPressed: () {
            return;
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(5.0),
              side: BorderSide(width: 4, color: Colors.black87),
            ),
            padding: EdgeInsets.all(50),
          ),
          child: const Text("Notes"),
        ),
      ],
    );
  }
}

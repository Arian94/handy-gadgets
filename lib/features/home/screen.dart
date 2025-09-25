import 'package:flutter/material.dart';

import 'utils/circular_flow_delegate.dart';
import 'utils/triangle_border.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Flow(
        delegate: CircularFlowDelegate(),
        children: [
          ElevatedButton(
            onPressed: () {
              return;
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
      ),
    );
  }
}

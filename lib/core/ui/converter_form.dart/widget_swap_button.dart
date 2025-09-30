import 'package:flutter/material.dart';

class SwapButtonWidget extends StatelessWidget {
  final VoidCallback? swapUnits;

  const SwapButtonWidget({super.key, required this.swapUnits});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: IconButton(
        icon: Icon(Icons.swap_vert),
        style: TextButton.styleFrom(padding: EdgeInsets.only(left: 1)),
        onPressed: swapUnits,
      ),
    );
  }
}

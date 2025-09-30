import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handy_gadgets_app/core/routes/route_names.dart';

import 'utils/triangle_border.dart';
import 'utils/triangle_shape.dart';

class UnitConverterButtonWidget extends StatelessWidget {
  const UnitConverterButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
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
              SvgPicture.asset('assets/icons/unit_converter.svg', height: 36),
            ],
          ),
        ),
      ),
    );
  }
}

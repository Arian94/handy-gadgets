import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handy_gadgets_app/main.dart';

class NotesButtonWidget extends StatelessWidget {
  const NotesButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

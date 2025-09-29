import 'package:flutter/material.dart';

void showNotification(String message, BuildContext context) {
  // Use ScaffoldMessenger.of(context) to access the SnackBar queue
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating, // Makes it look modern and rounded
      backgroundColor: Colors.green.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      action: SnackBarAction(
        label: 'DISMISS',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
        textColor: Colors.black87,
      ),
    ),
  );
}

import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onValueChanged;

  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Value'),
      onChanged: onValueChanged,
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;

  const CustomTextField({
    required this.label,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[800],
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white60),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white38),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white60),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xffcdbdfb)),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
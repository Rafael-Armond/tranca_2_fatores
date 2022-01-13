import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String label;
  final Function(String) onChanged;
  final bool isObscured;
  final String? hint;
  final Icon? icon;

  const CustomTextForm({ 
    Key? key,
    required this.label,
    required this.onChanged,
    this.isObscured = false,
    this.hint,
    this.icon,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        icon: icon,
        labelStyle: const TextStyle(fontSize: 14, color: Colors.blueAccent),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueAccent,
          ),
        ),
      ),
      obscureText: isObscured,
      onChanged: onChanged,
    );
  }
}
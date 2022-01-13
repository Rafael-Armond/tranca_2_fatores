import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Text text;
  final Function() onPressed;

  const CustomButton({ 
    Key? key,
    required this.text,
    required this.onPressed,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: text,
      onPressed: onPressed,
      // Style the button
    );
  }
}
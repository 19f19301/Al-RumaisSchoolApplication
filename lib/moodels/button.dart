
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const Button({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(9.0),
      ),
      color: Colors.red,
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

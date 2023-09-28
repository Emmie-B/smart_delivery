import 'package:flutter/material.dart';

import '../constants.dart';

class CustomMajorButton extends StatelessWidget {
  CustomMajorButton(
      {super.key, required this.text, required this.onPressed, this.color});

  final String? text;
  final Function()? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Set a fixed width or use constraints
      child: TextButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Text(
          text!,
          style: buttonText,
        ),
      ),
    );
  }
}

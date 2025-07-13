import 'package:flutter/material.dart';
import 'package:glowup/Styles/app_font.dart';

class OntapText extends StatelessWidget {
  final String text;
  final void Function()? pressedMethod;
  const OntapText({super.key, required this.text, required this.pressedMethod});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: pressedMethod,
      child: Text(text, style: AppFonts.regular14),
    );
  }
}

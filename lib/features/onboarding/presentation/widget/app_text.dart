import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final TextAlign? textAlign;
  const AppText({super.key, required this.title, this.style, this.textAlign});
  @override
  Widget build(BuildContext context) {
    return Text(title, style: style, textAlign: textAlign);
  }
}

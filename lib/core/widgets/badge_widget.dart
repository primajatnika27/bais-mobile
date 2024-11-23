import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  const BadgeWidget({
    super.key,
    required this.text,
    this.backgroundColor = const Color(0xFFE6EEF8),
    this.textColor = const Color(0xFF0057B8),
    this.borderColor = const Color(0xFF0057B8),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 12),
      ),
    );
  }
}

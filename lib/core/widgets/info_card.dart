import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final Widget? icon;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;

  const InfoCard({
    super.key,
    this.icon,
    required this.text,
    this.textColor = const Color(0xFF1F1F1F),
    this.backgroundColor = const Color(0xFFEAF6FF),
    this.borderColor = const Color(0xFF007BFF),
    this.borderWidth = 1.0,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon ?? const SizedBox(width: 0),
          if (icon != null) const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 20 / 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

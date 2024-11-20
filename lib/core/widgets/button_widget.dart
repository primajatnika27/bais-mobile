import 'package:flutter/material.dart';

enum ButtonStyleType { outline, fill, disable }

class ButtonWidget extends StatelessWidget {
  final String text;
  final ButtonStyleType styleType;
  final VoidCallback? onPressed;
  final Color fillColor;
  final Color outlineColor;
  final Color textColor;
  final Color disabledColor;
  final double borderRadius;
  final double borderWidth;
  final double textSize;
  final Widget? icon; // Add icon parameter
  final EdgeInsets padding;
  final TextStyle? textStyle;

  const ButtonWidget(
      {super.key,
        required this.text,
        required this.styleType,
        this.onPressed,
        this.fillColor = const Color(0xFF007BFF), // Default fill color
        this.outlineColor = const Color(0xFF007BFF), // Default outline color
        this.textColor =
        const Color(0xFFFFFFFF), // Default text color for fill style
        this.disabledColor = const Color(0xFFD1D5DB), // Default disabled color
        this.borderRadius = 8.0,
        this.borderWidth = 1.0,
        this.textSize = 14,
        this.icon, // Icon parameter
        this.padding =
        const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        this.textStyle = const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        )});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: styleType == ButtonStyleType.disable ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(_getBackgroundColor()),
        foregroundColor: WidgetStateProperty.all(_getTextColor()),
        side: styleType == ButtonStyleType.outline
            ? WidgetStateProperty.all(
          BorderSide(color: outlineColor, width: borderWidth),
        )
            : null,
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        padding: WidgetStateProperty.all(padding),
        elevation: WidgetStateProperty.all(0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            icon!,
            const SizedBox(width: 8), // Spacing between icon and text
          ],
          Text(
            text,
            style: textStyle,
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (styleType) {
      case ButtonStyleType.outline:
        return fillColor;
      case ButtonStyleType.fill:
        return fillColor;
      case ButtonStyleType.disable:
        return disabledColor;
      default:
        return fillColor;
    }
  }

  Color _getTextColor() {
    switch (styleType) {
      case ButtonStyleType.outline:
        return outlineColor;
      case ButtonStyleType.fill:
        return textColor;
      case ButtonStyleType.disable:
        return const Color(0xFF7A7A7A); // Disabled text color
      default:
        return textColor;
    }
  }
}
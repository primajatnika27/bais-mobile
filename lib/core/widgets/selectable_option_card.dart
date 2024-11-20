import 'dart:io';

import 'package:bais_mobile/core/widgets/dashed_border_painter.dart';
import 'package:flutter/material.dart';

class SelectableOptionCard extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback onTap;
  final String? imagePath; // Path to the selected image
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final bool showBorder;

  const SelectableOptionCard({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.imagePath,
    this.borderColor = Colors.blue,
    this.borderRadius = 6.0,
    this.borderWidth = 2.0,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: imagePath != null
              ? DecorationImage(
            image: FileImage(File(imagePath!)),
            fit: BoxFit.cover,
          )
              : null,
        ),
        child: Stack(
          children: [
            if (showBorder && imagePath == null)
              CustomPaint(
                painter: DashedBorderPainter(
                  color: borderColor,
                  strokeWidth: borderWidth,
                  borderRadius: borderRadius,
                ),
                child: Container(),
              ),
            if (imagePath == null)
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    icon,
                    const SizedBox(height: 8),
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

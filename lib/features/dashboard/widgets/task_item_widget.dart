import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TaskItemWidget extends StatelessWidget {
  final String value;
  final String title;
  final String svgPath;
  final Color color;
  final Color bgColor;
  final VoidCallback? onPressed;

  const TaskItemWidget({
    super.key,
    required this.value,
    required this.title,
    required this.svgPath,
    required this.color,
    required this.bgColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: AppTheme.shadow2,
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                  child: Center(
                    child: Image.asset(
                      svgPath,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppTheme.secondary900,
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.secondary800,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}

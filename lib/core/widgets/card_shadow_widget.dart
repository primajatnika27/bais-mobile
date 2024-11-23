import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

class CardShadowWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Widget child;
  const CardShadowWidget({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            offset: Offset(2, 4),
            spreadRadius: -5,
            blurRadius: 18,
            color: AppTheme.shadow2,
          )
        ],
      ),
      child: child,
    );
  }
}

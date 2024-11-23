import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

class CardWrapperWidget extends StatelessWidget {
  final String? title;
  final Widget? bottomWidget;
  final String? subtitle;
  final Widget child;
  final double? width;
  final double? height;
  final Widget? badge; // Optional badge widget

  const CardWrapperWidget({
    this.width,
    this.bottomWidget,
    this.height,
    super.key,
    this.title,
    required this.child,
    this.subtitle,
    this.badge, // Accepting the badge as an optional parameter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border300, width: 1),
        color: Colors.white,
        boxShadow: const [AppTheme.boxShadow300],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null
              ? Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                if (badge != null) badge!, // Only display the badge if it is not null
              ],
            ),
          )
              : const SizedBox(),
          subtitle != null
              ? Padding(
            padding: title != null
                ? const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            )
                : const EdgeInsets.all(16),
            child: Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppTheme.secondary250,
              ),
            ), // Only display the badge if it is not null,
          )
              : const SizedBox(),
          if (title != null || subtitle != null) const Divider(color: Color(0xFFD0D5DD)),
          child,
          if (bottomWidget != null) const Divider(color: Color(0xFFD0D5DD)),
          bottomWidget != null
              ? Padding(
            padding: const EdgeInsets.all(16),
            child: bottomWidget,
          )
              : const SizedBox(),
        ],
      ),
    );
  }
}

import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class BottomButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final bool usingBorder;
  final bool disabled;
  final Color fillColor;
  final bool withPadding;

  const BottomButtonWidget({
    super.key,
    this.onTap,
    this.title = 'Save',
    this.usingBorder = true,
    this.disabled = false,
    this.fillColor = AppTheme.primary,
    this.withPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: withPadding ? const EdgeInsets.all(16) : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        border: usingBorder
            ? const Border(
          top: BorderSide(
            color: Color(0xFFEAECF0),
            width: 1,
          ),
        )
            : null,
      ),
      child: ButtonWidget(
        onPressed: onTap,
        text: title,
        styleType: ButtonStyleType.fill,
        fillColor: onTap == null ? AppTheme.border500 : (!disabled ? fillColor : AppTheme.border500),
        textColor: onTap == null ? AppTheme.secondary250 : (!disabled ? AppTheme.white950 : AppTheme.secondary250),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}

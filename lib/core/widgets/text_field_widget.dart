import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String? title;
  final String? bottomInfo;
  final String placeholder;
  final Color titleColor;
  final Color placeholderColor;
  final Color backgroundColor;
  final Widget? suffixIcon; // Pass icon through as a widget
  final Widget? prefixIcon; // Pass icon through as a widget
  final String? suffixText;
  final bool required;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool obscureText;
  final bool isEnabled;
  final Color? borderColor;
  final bool isError; // To indicate if there's an error
  final String? errorMessage; // The error message to display
  final Function(String)? onChanged; // onChanged callback

  const TextFieldWidget({
    super.key,
    this.title,
    this.bottomInfo,
    required this.placeholder,
    this.titleColor = AppTheme.secondary800,
    this.placeholderColor = AppTheme.secondary250,
    this.backgroundColor = AppTheme.background, // Default background color
    this.suffixIcon,
    this.prefixIcon, // Icon widget passed from outside
    this.controller,
    this.suffixText,
    this.keyboardType,
    this.obscureText = false,
    this.isEnabled = true,
    this.borderColor,
    this.required = false,
    this.isError = false, // Default to no error
    this.errorMessage,
    this.onChanged,
  });

  getSuffixIcon() {
    if (suffixText != null) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(suffixText!),
      );
    }
    if (suffixIcon != null) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: suffixIcon,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Row(
            children: [
              Text(
                title!,
                style: TextStyle(
                  color: titleColor,
                ),
              ),
              required
                  ? const Text(
                '*',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              )
                  : const SizedBox(),
            ],
          ),
        if (title != null) const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: backgroundColor, // Apply the background color
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isError ? Colors.red : (borderColor ?? const Color(0xFFC1C7D1)),
            ),
          ),
          child: TextField(
            enabled: isEnabled,
            obscureText: obscureText,
            controller: controller,
            keyboardType: keyboardType,
            onChanged: onChanged, // Attach the onChanged callback
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(
                color: placeholderColor,
              ),
              suffixIcon: getSuffixIcon(),
              prefixIcon: prefixIcon != null
                  ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: prefixIcon,
              )
                  : null,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: InputBorder.none, // Remove the internal border
            ),
          ),
        ),
        if (isError && errorMessage != null) const SizedBox(height: 8),
        if (isError && errorMessage != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 4.0),
                child: Icon(
                  Icons.info,
                  color: Colors.red,
                  size: 16,
                ),
              ),
              Expanded(
                child: Text(
                  errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        if (bottomInfo != null && !isError) const SizedBox(height: 8),
        if (bottomInfo != null && !isError)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 4.0),
                child: Icon(
                  Icons.info,
                  color: Color(0xFF475467),
                  size: 16,
                ),
              ),
              Expanded(
                child: Text(
                  bottomInfo!,
                  style: const TextStyle(
                    color: Color(0xFF475467),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
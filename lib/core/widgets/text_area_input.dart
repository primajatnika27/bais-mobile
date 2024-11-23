import 'package:flutter/material.dart';

class TextAreaInput extends StatelessWidget {
  final String? title;
  final String placeholder;
  final Color titleColor;
  final Color placeholderColor;
  final Color backgroundColor; // New background color
  final TextEditingController? controller;
  final int maxLines;
  final bool required;
  final ValueChanged<String>? onChange;
  final VoidCallback? onEditingComplete;
  final String? semanticLabel;
  final bool? isEnabled;

  const TextAreaInput({
    super.key,
    this.title,
    required this.placeholder,
    this.titleColor = const Color(0xFF1F1F1F),
    this.placeholderColor = const Color(0xFF7A7A7A),
    this.backgroundColor = const Color(0xFFF9FAFB), // Default background color
    this.controller,
    this.maxLines = 5, // Default maxLines for the TextArea
    this.required = false,
    this.onChange,
    this.onEditingComplete,
    this.semanticLabel,
    this.isEnabled,
  });

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
                  fontFamily: 'Inter',
                  color: titleColor,
                  fontWeight: FontWeight.w500,
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
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: const Color(0xFFD1D5DB),
            ),
          ),
          child: Semantics(
            label: semanticLabel,
            explicitChildNodes: true,
            container: true,
            identifier: semanticLabel,
            child: TextField(
              enabled: isEnabled,
              controller: controller,
              maxLines: maxLines,
              onChanged: onChange,
              onEditingComplete: onEditingComplete,
              textInputAction: TextInputAction.newline,
              onSubmitted: (_) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: placeholderColor,
                ),
                contentPadding: const EdgeInsets.all(16.0),
                border: InputBorder.none, // Remove the internal border
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'text_field_widget.dart';

class TimeInput extends StatelessWidget {
  final String? title;
  final String placeholder;
  final Color titleColor;
  final Color placeholderColor;
  final Color backgroundColor;
  final TextEditingController? controller;
  final bool is24HourFormat; // Add support for 24-hour format
  final Widget suffixIcon; // Icon widget passed from outside
  final Function(String)? onChanged;
  final bool required;
  final String? semanticsLabel;

  const TimeInput({
    super.key,
    this.title,
    required this.placeholder,
    this.titleColor = const Color(0xFF1F1F1F),
    this.placeholderColor = const Color(0xFF7A7A7A),
    this.backgroundColor = const Color(0xFFF9FAFB),
    this.controller,
    this.is24HourFormat = true, // Default to 24-hour format
    required this.suffixIcon, // Require icon from outside
    this.onChanged,
    this.required = false,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        TimeOfDay? pickedTime = await _selectTime(context);
        if (pickedTime != null && controller != null) {
          final now = DateTime.now();
          final formattedTime = DateFormat(is24HourFormat ? 'HH:mm' : 'hh:mm a').format(DateTime(
            now.year,
            now.month,
            now.day,
            pickedTime.hour,
            pickedTime.minute,
          ));
          controller!.text = formattedTime;
        }
      },
      child: AbsorbPointer(
        child: Semantics(
          label: semanticsLabel,
          explicitChildNodes: true,
          container: true,
          child: TextFieldWidget(
            title: title,
            placeholder: placeholder,
            titleColor: titleColor,
            placeholderColor: placeholderColor,
            backgroundColor: backgroundColor,
            controller: controller,
            suffixIcon: suffixIcon, // Pass the icon
            onChanged: onChanged,
            required: required,
          ),
        ),
      ),
    );
  }

  Future<TimeOfDay?> _selectTime(BuildContext context) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
  }
}

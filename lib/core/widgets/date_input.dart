import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/button_widget.dart';
import 'package:bais_mobile/core/widgets/popup_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'text_field_widget.dart';

class DateInput extends StatelessWidget {
  final String? title;
  final String placeholder;
  final Color titleColor;
  final Color placeholderColor;
  final Color backgroundColor;
  final TextEditingController? controller;
  final Widget suffixIcon;
  final Function(String)? onChange;
  final bool required;
  final DateTime? minDate;
  final DateTime? maxDate;
  final DateTime? initialSelectedDate;
  final bool isStart;
  final String? semanticLabel;

  const DateInput({
    super.key,
    this.title,
    required this.placeholder,
    this.titleColor = const Color(0xFF1F1F1F),
    this.placeholderColor = const Color(0xFF7A7A7A),
    this.backgroundColor = const Color(0xFFF9FAFB),
    this.controller,
    required this.suffixIcon,
    this.onChange,
    this.required = false,
    this.minDate,
    this.maxDate,
    this.initialSelectedDate,
    this.isStart = false,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final pickedDate = await _selectDate(context, minDate, maxDate);
        if (pickedDate != null && controller != null) {
          String formattedDate = DateFormat('d MMMM yyyy').format(pickedDate);
          controller!.text = formattedDate;
          onChange?.call(formattedDate);
        }
      },
      child: AbsorbPointer(
        child: Semantics(
          label: semanticLabel,
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
            required: required,
          ),
        ),
      ),
    );
  }

  // Future<DateTime?> _selectDate(BuildContext context) {
  //   return showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2100),
  //     builder: (context, child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           colorScheme: const ColorScheme.light(
  //             primary: Colors.blue,
  //             onPrimary: Colors.white,
  //             onSurface: Colors.black,
  //           ),
  //           textButtonTheme: TextButtonThemeData(
  //             style: TextButton.styleFrom(
  //               foregroundColor: Colors.blue,
  //             ),
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );
  // }

  Future<DateTime?> _selectDate(BuildContext context, DateTime? minDate, DateTime? maxDate) async {
    return await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        final controller = DateRangePickerController();
        return ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 673),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCDCFD0),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
                Text(
                  isStart ? 'Please Choose Start Date' : 'Please Choose End Date',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                PopupCalendar(
                  controller: controller,
                  minDate: minDate,
                  maxDate: maxDate,
                  selectionMode: DateRangePickerSelectionMode.single,
                  initialSelectedDate: initialSelectedDate ?? DateTime.now(),
                  initialDisplayDate: initialSelectedDate ?? DateTime.now(),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ButtonWidget(
                    onPressed: () => Navigator.pop(context, controller.selectedDate),
                    text: 'Simpan Tanggal',
                    styleType: ButtonStyleType.fill,
                    fillColor: AppTheme.primary,
                    textColor: AppTheme.white950,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

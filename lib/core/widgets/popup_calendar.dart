import 'package:bais_mobile/core/helpers/utils/datetime_extensions.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PopupCalendar extends StatefulWidget {
  final DateRangePickerController controller;
  final DateTime? minDate;
  final DateTime? maxDate;
  final DateTime? initialDisplayDate;
  final DateTime? initialSelectedDate;
  final PickerDateRange? initialSelectedRange;
  final DateRangePickerSelectionMode selectionMode;
  const PopupCalendar({
    super.key,
    this.minDate,
    this.maxDate,
    this.initialDisplayDate,
    this.initialSelectedDate,
    this.initialSelectedRange,
    required this.controller,
    required this.selectionMode,
  });

  @override
  State<PopupCalendar> createState() => _PopupCalendarState();
}

class _PopupCalendarState extends State<PopupCalendar> {
  bool submitButton = false;

  onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (widget.selectionMode == DateRangePickerSelectionMode.range ||
        widget.selectionMode == DateRangePickerSelectionMode.multiRange) {
      setState(() {
        submitButton = (args.value as PickerDateRange).endDate != null;
      });
    } else {
      setState(() {
        submitButton = true;
      });
    }
  }

  onSubmit() {
    if (!submitButton) return;
    switch (widget.selectionMode) {
      case DateRangePickerSelectionMode.single:
        return Navigator.pop(Get.context!, widget.controller.selectedDate);
      case DateRangePickerSelectionMode.range:
        return Navigator.pop(Get.context!, widget.controller.selectedRange);
      case DateRangePickerSelectionMode.multiple:
        return Navigator.pop(Get.context!, widget.controller.selectedDates);
      case DateRangePickerSelectionMode.multiRange:
        return Navigator.pop(Get.context!, widget.controller.selectedRanges);
      default:
        return Navigator.pop(Get.context!);
    }
  }

  onCancel() => Navigator.pop(Get.context!);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFEEEEEE),
              blurRadius: 40,
              spreadRadius: 0,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              color: Color.fromRGBO(66, 71, 76, 0.05),
              blurRadius: 8,
              spreadRadius: 0,
              offset: Offset(0, 4),
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            // TODO Fix initialDisplayDate or initialSelectedDate
            child: SfDateRangePicker(
              controller: widget.controller,
              initialDisplayDate: widget.initialDisplayDate,
              initialSelectedDate: widget.initialSelectedDate,
              initialSelectedRange: widget.initialSelectedRange,
              minDate: widget.minDate,
              maxDate: widget.maxDate,
              onSelectionChanged: onSelectionChanged,
              showNavigationArrow: true,
              toggleDaySelection: true,
              extendableRangeSelectionDirection:
              ExtendableRangeSelectionDirection.both,
              navigationDirection:
              DateRangePickerNavigationDirection.horizontal,
              selectionMode: widget.selectionMode,
              backgroundColor: Colors.white,
              headerStyle: const DateRangePickerHeaderStyle(
                backgroundColor: Colors.white,
                textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              headerHeight: 50,
              startRangeSelectionColor: AppTheme.primary,
              rangeSelectionColor: AppTheme.primary.withOpacity(0.1),
              endRangeSelectionColor: AppTheme.primary,
              todayHighlightColor: AppTheme.primary,
              allowViewNavigation: true,
              enablePastDates: true,
              selectionColor: AppTheme.primary,
              selectionShape: DateRangePickerSelectionShape.rectangle,
              selectionRadius: 10,
              selectionTextStyle: const TextStyle(fontWeight: FontWeight.w500),
              monthCellStyle: DateRangePickerMonthCellStyle(
                trailingDatesTextStyle: TextStyle(
                  color: (context.isDarkMode
                      ? const Color(0xFFC7C9D8)
                      : const Color(0xFF666B8F))
                      .withOpacity(0.4),
                  fontWeight: FontWeight.w500,
                ),
                disabledDatesTextStyle: TextStyle(
                  color: (context.isDarkMode
                      ? const Color(0xFFC7C9D8)
                      : const Color(0xFF666B8F))
                      .withOpacity(0.4),
                  fontWeight: FontWeight.w500,
                ),
                leadingDatesTextStyle: TextStyle(
                    color: (context.isDarkMode
                        ? const Color(0xFFC7C9D8)
                        : const Color(0xFF666B8F))
                        .withOpacity(0.4),
                    fontWeight: FontWeight.w500),
              ),
              yearCellStyle: const DateRangePickerYearCellStyle(
                todayTextStyle: TextStyle(color: Color(0xFFFF8346)),
              ),
              monthViewSettings: const DateRangePickerMonthViewSettings(
                showTrailingAndLeadingDates: true,
                dayFormat: 'EEE',
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                  textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              (widget.controller.selectedDate ?? DateTime.now()).formatFilter(),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppTheme.secondary800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

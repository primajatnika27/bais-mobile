import 'package:bais_mobile/core/widgets/card_wrapper_widget.dart';
import 'package:bais_mobile/core/widgets/date_input.dart';
import 'package:bais_mobile/core/widgets/dropdown_input.dart';
import 'package:bais_mobile/core/widgets/text_field_widget.dart';
import 'package:bais_mobile/core/widgets/time_input.dart';
import 'package:bais_mobile/features/incident_report/controllers/incident_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class IncidentFormTab extends GetView<IncidentReportController> {
  const IncidentFormTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWrapperWidget(
      title: 'Incident Form',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownInput<String>(
              title: 'Incident Type',
              placeholder: 'Select type',
              controller: controller.incidentTypeController,
              itemToString: (value) => value,
              required: true,
            ),
            const SizedBox(height: 16),
            DropdownInput<String>(
              title: 'Incident Level',
              placeholder: 'Select level',
              controller: controller.incidentLevelController,
              itemToString: (value) => value,
              required: true,
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              title: 'Reporter Name',
              placeholder: 'ex: John Doe',
              controller: controller.reporterNameController,
              required: true,
            ),
            const SizedBox(height: 16),
            DateInput(
              title: 'Incident Date',
              placeholder: 'Select date',
              suffixIcon: SvgPicture.asset(
                "assets/icons/ic_calendar.svg",
              ),
              controller: controller.incidentDateController,
              required: true,
              isStart: true,
            ),
            const SizedBox(height: 16),
            TimeInput(
              placeholder: 'Select time',
              title: 'Incident Time',
              controller: controller.incidentTimeController,
              suffixIcon: const Icon(Icons.access_time),
              required: true,
            ),
          ],
        ),
      ),
    );
  }
}

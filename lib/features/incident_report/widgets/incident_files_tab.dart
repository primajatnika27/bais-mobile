import 'package:bais_mobile/core/helpers/utils/color_extensions.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/card_wrapper_widget.dart';
import 'package:bais_mobile/core/widgets/photo_section_input.dart';
import 'package:bais_mobile/core/widgets/selectable_option_card.dart';
import 'package:bais_mobile/core/widgets/text_area_input.dart';
import 'package:bais_mobile/features/incident_report/controllers/incident_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class IncidentFilesTab extends GetView<IncidentReportController> {
  IncidentFilesTab({super.key}) : cameraImagePath = Rxn<String>();

  final Rxn<String> cameraImagePath;

  void setCameraImagePath(String? path) {
    cameraImagePath.value = path;
  }

  @override
  Widget build(BuildContext context) {
    return CardWrapperWidget(
      title: 'Incident Files Upload',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextAreaInput(
              title: 'Incident Description',
              placeholder: 'ex: Incident description',
              controller: controller.incidentDescriptionController,
            ),
            const SizedBox(height: 16),
            PhotoSectionInput(
              title: 'Pick Photo Incident',
              sampleText: 'ex: Incident photo',
              inputModel: controller.incidentPhotoModel,
              isRequired: true,
            ),
          ],
        ),
      ),
    );
  }
}

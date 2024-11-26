import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/bottom_button_widget.dart';
import 'package:bais_mobile/core/widgets/card_wrapper_widget.dart';
import 'package:bais_mobile/core/widgets/text_area_input.dart';
import 'package:bais_mobile/core/widgets/text_field_widget.dart';
import 'package:bais_mobile/features/incident_report/controllers/monthly_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonthlyReportStep2View extends GetView<MonthlyReportController> {
  const MonthlyReportStep2View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            CardWrapperWidget(
              title: 'Reason',
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldWidget(
                      title: 'Title',
                      placeholder: 'ex: title',
                      controller: controller.titleReportController,
                      required: true,
                    ),
                    const SizedBox(height: 16),
                    TextAreaInput(
                      title: 'Description Report',
                      placeholder: 'ex: desc',
                      controller: controller.descriptionReportController,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomButtonWidget(
        title: 'Submit',
        onTap: () {
          controller.onSubmitReport();
        },
      ),
    );
  }
}

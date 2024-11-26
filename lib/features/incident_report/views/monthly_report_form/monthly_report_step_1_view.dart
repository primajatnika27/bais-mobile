import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/bottom_button_widget.dart';
import 'package:bais_mobile/core/widgets/card_wrapper_widget.dart';
import 'package:bais_mobile/core/widgets/date_input.dart';
import 'package:bais_mobile/core/widgets/dropdown_input.dart';
import 'package:bais_mobile/core/widgets/text_field_widget.dart';
import 'package:bais_mobile/features/incident_report/controllers/monthly_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MonthlyReportStep1View extends GetView<MonthlyReportController> {
  const MonthlyReportStep1View({super.key});

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
              title: 'Report Form',
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DateInput(
                            title: 'Start Date',
                            placeholder: 'start date',
                            suffixIcon: SvgPicture.asset(
                              "assets/icons/ic_calendar.svg",
                            ),
                            controller: controller.startDateController,
                            required: true,
                            isStart: true,
                            onChange: (selectedDateString) {
                              // Convert the string to DateTime
                              DateTime selectedDate =
                              controller.parseDate(selectedDateString);
                              // Update the maximum date for the end date
                              controller.updateEndDateMax(
                                selectedDate.add(
                                  const Duration(days: 30),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Obx(
                              () {
                            return Expanded(
                              child: DateInput(
                                title: 'End Date',
                                placeholder: 'end date',
                                suffixIcon: SvgPicture.asset(
                                  "assets/icons/ic_calendar.svg",
                                ),
                                controller: controller.endDateController,
                                required: true,
                                maxDate: controller.endDateMax.value,
                                isStart: true,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFieldWidget(
                      title: 'Total Incident/Operation',
                      placeholder: 'ex: 4',
                      controller: controller.totalIncidentController,
                      required: true,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    TextFieldWidget(
                      title: 'Reporter Name',
                      placeholder: 'ex: John Doe',
                      controller: controller.reporterNameController,
                      required: true,
                    ),
                    const SizedBox(height: 16),
                    DropdownInput<String>(
                      title: 'Operation Type',
                      placeholder: 'Select type',
                      controller: controller.operationTypeController,
                      itemToString: (value) => value,
                      required: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomButtonWidget(
        title: 'Next',
        onTap: () {
          controller.changeTab(1);
        },
      ),
    );
  }
}

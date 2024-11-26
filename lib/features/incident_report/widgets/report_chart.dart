import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/helpers/utils/color_extensions.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/card_wrapper_widget.dart';
import 'package:bais_mobile/features/incident_report/controllers/report_landing_page_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportChart extends GetView<ReportLandingPageController> {
  const ReportChart({super.key});

  @override
  Widget build(BuildContext context) {
    int maxValue = [10, 10, 10, 10].reduce((a, b) => a > b ? a : b);
    double scaleFactor = maxValue <= 10 ? 10 : maxValue.toDouble();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: CardWrapperWidget(
        title: 'Incident Chart',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 230,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: scaleFactor,
                      barGroups: [
                        _makeGroupData(
                          0,
                          (controller.medicalTreatmentTotal.value) / (scaleFactor / 10).toDouble(),
                          HexColor('#FFA847'),
                        ),
                        _makeGroupData(
                          1,
                          (controller.minorIncidentTotal.value) / (scaleFactor / 10).toDouble(),
                          HexColor('#672BC4'),
                        ),
                        _makeGroupData(
                          2,
                          (controller.nearMissTotal.value) / (scaleFactor / 10).toDouble(),
                          HexColor('#00B3B8'),
                        ),
                        _makeGroupData(
                          3,
                          (controller.potentialHazardTotal.value) / (scaleFactor / 10).toDouble(),
                          HexColor('#A8AD00'),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 70,
                            getTitlesWidget: (value, meta) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 8),
                                  Text(
                                    _getValue(value).toString(),
                                    style: TextStyle(
                                      color: HexColor('#1D2939'),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  Text(
                                    _getLabel(value),
                                    style: const TextStyle(
                                      color: AppTheme.secondary300,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: const FlGridData(
                        show: true,
                        drawVerticalLine: false,
                      ),
                      borderData: FlBorderData(show: false),
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            return BarTooltipItem(
                              (rod.toY * (scaleFactor / 10)).round().toString(),
                              const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
            const Divider(height: 1),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.incidentReport);
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/ic_daily.png',
                            height: 25,
                            width: 25,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Daily Report',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.weeklyReport);
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/ic_weekly.png',
                            height: 25,
                            width: 25,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Weekly Report',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.monthlyReport);
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/ic_monthly.png',
                            height: 25,
                            width: 25,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Monthly Report',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 40,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
      ],
    );
  }

  int _getValue(double value) {
    switch (value.toInt()) {
      case 0:
        return controller.medicalTreatmentTotal.value;
      case 1:
        return controller.minorIncidentTotal.value;
      case 2:
        return controller.nearMissTotal.value;
      case 3:
        return controller.potentialHazardTotal.value;
      default:
        return 0;
    }
  }

  String _getLabel(double value) {
    switch (value.toInt()) {
      case 0:
        return 'Medical\nIncident';
      case 1:
        return 'Minor\nIncident';
      case 2:
        return 'Near Miss';
      case 3:
        return 'Potential Hazard';
      default:
        return '';
    }
  }
}

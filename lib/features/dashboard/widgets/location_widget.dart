import 'package:bais_mobile/features/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find();
    return Column(
      children: [
        const SizedBox(height: 25),
        Row(
          children: [
            SvgPicture.asset(
              'assets/images/svg/map-pin-line.svg',
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white,
                      width: 0.3,
                    ),
                  ),
                ),
                child: Obx(() => Text(
                  controller.location.value,
                  style: const TextStyle(color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

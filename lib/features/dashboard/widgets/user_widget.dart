import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/features/dashboard/controllers/dashboard_controller.dart';
import 'package:bais_mobile/features/dashboard/widgets/user_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserWidget extends GetView<DashboardController> {
  const UserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 14),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.profile);
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: const Color(0xFFF0F8FF).withOpacity(0.1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 0.8,
                    ),
                  ),
                  child: const UserAvatarWidget(),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.usersName.value,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "ID: ${controller.usersId.value}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

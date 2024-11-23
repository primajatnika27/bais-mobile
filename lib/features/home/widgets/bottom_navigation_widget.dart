import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/features/home/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BottomNavigationWidget extends StatelessWidget {
  final NavigationController navigationController =
      Get.put(NavigationController());

  BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: AppTheme.border300,
              width: 1,
            ),
          ),
        ),
        child: Obx(
          () => Row(
            children: [
              NavigationItem(
                active: navigationController.currentIndex.value == 0,
                icon: 'home',
                label: "Dashboard",
                onTap: () => navigationController.changePage(0),
              ),
              NavigationItem(
                active: navigationController.currentIndex.value == 1,
                icon: 'history',
                label: "Task",
                onTap: () => navigationController.changePage(1),
              ),
              // NavigationItem(
              //   active: navigationController.currentIndex.value == 3,
              //   icon: 'profile',
              //   label: "Profile",
              //   onTap: () {
              //     navigationController.changePage(3);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationItem extends StatelessWidget {
  final bool active;
  final String label;
  final String icon;
  final VoidCallback onTap;

  const NavigationItem({
    super.key,
    required this.active,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String iconFileName = active ? '$icon-active' : icon;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 4,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                color: active
                    ? AppTheme.primary
                    : const Color.fromARGB(0, 255, 255, 255),
              ),
            ),
            const SizedBox(height: 8),
            SvgPicture.asset(
              'assets/images/svg/navigation/$iconFileName.svg',
              width: 20,
              height: 20,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: active ? AppTheme.primary : const Color(0xFF475467),
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

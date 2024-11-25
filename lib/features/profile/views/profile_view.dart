import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/app_bar_general.dart';
import 'package:bais_mobile/core/widgets/bottom_button_widget.dart';
import 'package:bais_mobile/core/widgets/general_table_row.dart';
import 'package:bais_mobile/core/widgets/general_table_wrapper.dart';
import 'package:bais_mobile/features/profile/controllers/create_profile_controller.dart';
import 'package:bais_mobile/features/profile/widgets/profile_headers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<CreateProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneral(
        title: '',
        backgroundColor: AppTheme.primary,
        onTapLeading: () => Get.back(),
        withTabBar: true,
      ),
      body: Column(
        children: [
          const ProfileHeaders(),

          Obx(() {
            return GeneralTableWrapper(
              title: 'Details',
              children: [
                GeneralTableRow(
                  label: 'Full Name',
                  value: controller.usersName.value,
                ),
                GeneralTableRow(
                  label: 'Email',
                  value: controller.emailUser.value,
                ),
                const GeneralTableRow(
                  label: 'Role',
                  value: 'User',
                ),
                const GeneralTableRow(
                  label: 'Division',
                  value: '-',
                ),
                GeneralTableRow(
                  label: 'Phone',
                  value: controller.phone.value,
                ),
                GeneralTableRow(
                  label: 'Address',
                  value: controller.address.value,
                ),
              ],
            );
          }),
        ],
      ),
      bottomNavigationBar: BottomButtonWidget(
        title: 'Sign Out',
        onTap: () {
          controller.onSignOut();
        },
      ),
    );
  }
}

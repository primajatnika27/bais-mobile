import 'package:bais_mobile/core/helpers/utils/color_extensions.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/card_wrapper_widget.dart';
import 'package:bais_mobile/core/widgets/general_table_row.dart';
import 'package:bais_mobile/core/widgets/general_table_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileHeaders extends StatelessWidget {
  const ProfileHeaders({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 154,
      child: Stack(
        children: [
          // Blue Background
          Container(
            height: 100,
            color: AppTheme.primary,
          ),
          SizedBox(
            height: 154,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppTheme.secondary800,
                        ),
                        child: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                // Profile
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Stack(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppTheme.secondary100,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(color: Colors.white),
                          ),
                          child: SvgPicture.asset('assets/icons/ic_avatar.svg'),
                        ),
                        // photo icon
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: AppTheme.primary,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white),
                              ),
                              padding: const EdgeInsets.all(4),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

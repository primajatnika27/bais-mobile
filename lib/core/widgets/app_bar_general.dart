import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarGeneral extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool withTabBar;
  final bool withLeading;
  final VoidCallback? onTapLeading;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final Color? backgroundColor;

  const AppBarGeneral({
    super.key,
    required this.title,
    this.withTabBar = false,
    this.withLeading = true,
    this.onTapLeading,
    this.bottom,
    this.actions = const [],
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.white,
      iconTheme: const IconThemeData(
        color: Colors.black, //change your color here
      ),
      centerTitle: withLeading,
      automaticallyImplyLeading: withLeading,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: AppTheme.navy,
        ),
      ),
      leading: withLeading
          ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor != null ? AppTheme.white : AppTheme.primary,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: IconButton(
            iconSize: 24,
            onPressed: onTapLeading ?? () => Navigator.pop(context),
            icon: SvgPicture.asset(
              'assets/icons/ic_arrow_back.svg',
              color: backgroundColor != null ? AppTheme.primary : AppTheme.white,
            ),
          ),
        ),
      )
          : null,
      actions: actions,
      bottom: bottom,
      shape: withTabBar
          ? null
          : const Border(
        bottom: BorderSide(
          color: AppTheme.border300,
          width: 1,
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}

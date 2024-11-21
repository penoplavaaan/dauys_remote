import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class AppBottomNavigationItem extends StatelessWidget {
  const AppBottomNavigationItem({
    super.key,
    required this.title,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  final String title;
  final String icon;
  final bool isActive;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final Color color = isActive ? AppColors.white : AppColors.white.withOpacity(0.4);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 14),
            Image.asset(
              icon,
              height: 22,
              width: 22,
              color: color,
            ),
            const SizedBox(height: 7),
            Text(
              title,
              style: AppStyles.magistral11w400.copyWith(color: color),
            ),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}

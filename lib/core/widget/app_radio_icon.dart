import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/widget/gradient_overlay.dart';
import 'package:flutter/material.dart';

class AppRadioIcon extends StatelessWidget {
  const AppRadioIcon({
    super.key,
    this.isActive = false,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GradientOverlay(
      gradient: isActive
          ? null
          : LinearGradient(
              colors: [
                AppColors.white.withOpacity(.2),
                AppColors.white.withOpacity(.2),
              ],
            ),
      child: Container(
        height: 26,
        width: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: AppColors.white),
        ),
        padding: const EdgeInsets.all(4),
        child: isActive
            ? Container(
                height: 18,
                width: 18,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
              )
            : const SizedBox.expand(),
      ),
    );
  }
}

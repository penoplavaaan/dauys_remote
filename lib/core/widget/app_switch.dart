import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_gradients.dart';
import 'package:flutter/material.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
  });

  final bool value;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 24,
      width: 44,
      decoration: value
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: AppGradients.buttonRainbow,
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.white.withOpacity(.2)),
            ),
      alignment: value ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        height: 22,
        width: 22,
        margin: const EdgeInsets.all(1),
        decoration: value
            ? BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkGradient2.withOpacity(.2),
                    blurRadius: 5,
                  ),
                ],
              )
            : BoxDecoration(
                color: AppColors.white.withOpacity(.2),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkGradient2.withOpacity(.2),
                    blurRadius: 5,
                  ),
                ],
              ),
      ),
    );
  }
}

import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_gradients.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/gradient_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum AppButtonType { gradient, outlined, text }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onTap,
    this.type = AppButtonType.gradient,
    this.iconAsset,
    this.width,
  });

  final String title;
  final AppButtonType type;
  final void Function()? onTap;
  final String? iconAsset;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final decoration = switch (type) {
      AppButtonType.gradient => BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: AppGradients.buttonRainbow,
        ),
      AppButtonType.outlined => BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.white.withOpacity(0.2),
          ),
        ),
      AppButtonType.text => BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
    };

    final isDisabled = onTap == null;

    final disabledDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: AppColors.white.withOpacity(0.2),
    );

    final text = Text(
      title,
      style: AppStyles.magistral16w500.copyWith(
        color: AppColors.white,
      ),
    );

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 44,
        width: width ?? double.infinity,
        decoration: isDisabled ? disabledDecoration : decoration,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconAsset != null) ...[
              Image.asset(iconAsset!, height: 20, width: 20),
              const SizedBox(width: 20),
            ],
            const Spacer(),
            isDisabled //
                ? GradientOverlay(
                    gradient: AppGradients.darkGradient,
                    child: text,
                  )
                : text,
            const Spacer(),
            if (iconAsset != null) const SizedBox(width: 40),
          ],
        ),
      ),
    );
  }
}

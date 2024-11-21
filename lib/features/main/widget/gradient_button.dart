import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/gradient_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: GradientOverlay(
        child: Container(
          height: 40,
          width: 87,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.white),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: AppStyles.magistral16w500.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}

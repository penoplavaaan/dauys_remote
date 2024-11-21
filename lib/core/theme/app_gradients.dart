import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppGradients {
  static const darkGradient = LinearGradient(
    colors: [
      AppColors.darkGradient1,
      AppColors.darkGradient2,
    ],
  );

  static const darkGradientVertical = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.darkGradient1,
      AppColors.darkGradient2,
    ],
  );

  static final darkGradient80 = LinearGradient(
    colors: [
      AppColors.darkGradient1.withOpacity(0.8),
      AppColors.darkGradient2.withOpacity(0.8),
    ],
  );

  static const buttonRainbow = LinearGradient(
    colors: [
      AppColors.backgroundButtonGradient1,
      AppColors.backgroundButtonGradient2,
      AppColors.backgroundButtonGradient3,
    ],
  );

  static final buttonRainbow50 = LinearGradient(
    colors: [
      AppColors.backgroundButtonGradient1.withOpacity(0.5),
      AppColors.backgroundButtonGradient2.withOpacity(0.5),
      AppColors.backgroundButtonGradient3.withOpacity(0.5),
    ],
  );

  static final buttonGrayGradient15 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.white.withOpacity(0.15),
      AppColors.buttonBackgroundGrayGradient.withOpacity(0.15),
    ],
  );
}

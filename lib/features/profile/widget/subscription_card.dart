import 'package:dauys_remote/core/constants/app_icons.dart';
import 'package:dauys_remote/core/helpers/price_extension.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_gradients.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/gradient_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({
    super.key,
    required this.percent,
    required this.noMonth,
    required this.month,
    required this.price,
    required this.priceMonth,
    required this.isSelected,
    required this.onTap,
  });

  final double percent;
  final double noMonth;
  final String month;
  final double price;
  final double priceMonth;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 4, top: 10, right: 4, bottom: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.white.withOpacity(.1),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$percent%',
                        style: AppStyles.magistral12w700.copyWith(color: AppColors.white),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              noMonth.toString(),
                              style: AppStyles.magistral40w700.copyWith(color: AppColors.white, height: 1),
                            ),
                            Text(
                              month,
                              style: AppStyles.magistral12w500.copyWith(color: AppColors.white),
                            ),
                            const SizedBox(height: 10),
                            GradientOverlay(
                              child: Text(
                                '${price.toNicePrice()}T', // TODO KANTUR add coma separator
                                style: AppStyles.magistral20w700.copyWith(color: AppColors.white),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${priceMonth.toNicePrice()} T/', // TODO KANTUR add coma separator
                                  style: AppStyles.magistral12w500.copyWith(color: AppColors.white.withOpacity(.4)),
                                ),
                                Text(
                                  'месяц',
                                  style: AppStyles.magistral12w400.copyWith(color: AppColors.white.withOpacity(.2)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Positioned.fill(
                    child: GradientOverlay(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.white, width: 2),
                        ),
                      ),
                    ),
                  ),
                if (isSelected)
                  Positioned(
                    right: 11,
                    top: 42,
                    child: Container(
                      height: 24,
                      width: 24,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        gradient: AppGradients.buttonRainbow,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        AppIcons.check,
                        height: 12,
                        width: 12,
                        fit: BoxFit.cover,
                        color: AppColors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dauys_remote/core/constants/app_icons.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/gradient_overlay.dart';
import 'package:flutter/material.dart';

enum TextType { normal, bold }

class Textt {
  final String text;
  final TextType type;

  Textt(this.text, this.type);
}

class SubscriptionCheckedCard extends StatelessWidget {
  const SubscriptionCheckedCard({
    super.key,
    required this.texts,
  });

  final List<Textt> texts;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white.withOpacity(.1),
      ),
      child: Row(
        children: [
          GradientOverlay(
            child: Image.asset(
              AppIcons.check,
              height: 20,
              width: 20,
              fit: BoxFit.contain,
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 17),
          Expanded(
            child: RichText(
              maxLines: 3,
              text: TextSpan(
                children: texts
                    .map((e) => TextSpan(
                          text: e.text,
                          style: e.type == TextType.normal
                              ? AppStyles.magistral16w400.copyWith(color: AppColors.white)
                              : AppStyles.magistral16w700.copyWith(color: AppColors.white),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

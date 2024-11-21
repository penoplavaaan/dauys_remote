import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class MyDataCard extends StatelessWidget {
  const MyDataCard({
    super.key,
    required this.title,
    required this.data,
  });

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppStyles.magistral12w500.copyWith(color: AppColors.white.withOpacity(.5)),
          ),
          const SizedBox(height: 6),
          Text(
            data,
            style: AppStyles.magistral16w500.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}

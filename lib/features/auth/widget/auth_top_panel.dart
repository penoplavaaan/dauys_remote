import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

import '../../gateway/gateway_screen.dart';

class AuthTopPanel extends StatelessWidget {
  const AuthTopPanel({
    super.key,
    required this.title,
    this.action,
    this.screenId,
    this.onBack,
  });

  final String title;
  final Widget? action;
  final int? screenId;
  final Function()? onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => onBack != null ? onBack!() : Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => GateWayScreen(index: screenId?? 0)),
            ),
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: 32,
              width: 32,
              alignment: Alignment.center,
              child: const Icon(
                Icons.chevron_left, // TODO KANTUR: change to asset icon
                size: 20,
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(width: 20),
          const Spacer(),
          Text(
            title,
            style: AppStyles.magistral16w500.copyWith(
              color: AppColors.white,
              height: 1,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 14),
          SizedBox(
            width: 32,
            height: 32,
            child: action,
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}

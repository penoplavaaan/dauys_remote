import 'package:dauys_remote/core/constants/app_image.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_gradients.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.title,
    required this.icon,
    this.hasMore = false,
    this.page,
  });

  final String title;
  final String icon;

  final bool hasMore;
  final Widget? page;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (page == null) return;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page!),
          );
        },
        behavior: HitTestBehavior.opaque,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.white.withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        icon,
                        height: 26,
                        width: 26,
                        color: AppColors.white,
                        fit: BoxFit.cover,
                      ),
                      const Spacer(),
                      if (hasMore)
                        Container(
                          height: 24,
                          decoration: BoxDecoration(
                            gradient: AppGradients.buttonRainbow,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          alignment: Alignment.center,
                          child: Text(
                            'Акции',
                            style: AppStyles.magistral14w500.copyWith(color: AppColors.white),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.magistral16w600.copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ),
            if (hasMore)
              Image.asset(
                AppImage.backgroundLines,
                height: 46,
              ),
          ],
        ),
      ),
    );
  }
}

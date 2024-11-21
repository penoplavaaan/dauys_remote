import 'package:dauys_remote/core/constants/app_svg.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/gradient_overlay.dart';
import 'package:dauys_remote/features/main/sing_screen.dart';
import 'package:dauys_remote/features/main/widget/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlaylistItemNew extends StatelessWidget {
  const PlaylistItemNew({
    super.key,
    required this.image,
    required this.title,
    required this.name,
    this.showAddToFavorite = false,
    this.onTap,
  });

  final String image;
  final String title;
  final String name;
  final bool showAddToFavorite;
  final VoidCallback? onTap; // This is the onTap callback type

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Wrap the entire Row with GestureDetector
      onTap: onTap, // When tapped, trigger the onTap callback if provided
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  image,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              SvgPicture.asset(
                AppSvg.playOverlay,
                height: 20,
                width: 20,
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.magistral14w500.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 3),
                Text(
                  name,
                  style: AppStyles.magistral12w400.copyWith(color: AppColors.white.withOpacity(0.5)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          GradientButton(
            title: 'Спеть',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SingScreen(),
                ),
              );
            },
          ),
          if (showAddToFavorite) ...[
            const SizedBox(width: 4),
            GradientOverlay(
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(width: 1, color: AppColors.white),
                ),
                alignment: Alignment.center,
                child: GradientOverlay(
                  child: SvgPicture.asset(
                    AppSvg.star,
                    height: 20,
                    width: 20,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}


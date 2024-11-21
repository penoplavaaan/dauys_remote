import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/main/playlist_screen.dart';
import 'package:dauys_remote/features/main/widget/playlist_item.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeAreaTop: false,
      disableBackgroundColorSpots: true,
      body: Column(
        children: [
          Container(
            height: 192,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.backgroundButtonGradient1.withOpacity(0.6),
                  AppColors.backgroundButtonGradient1.withOpacity(0),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopSpacer(),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
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
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'История',
                    style: AppStyles.magistral30w700.copyWith(color: AppColors.white),
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'За последний месяц',
                    style: AppStyles.magistral16w400.copyWith(color: AppColors.white.withOpacity(0.6)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: playlist.length,
              itemBuilder: (context, index) => PlaylistItem(
                image: playlist[index]['image'],
                title: playlist[index]['title'],
                name: playlist[index]['name'],
              ),
              separatorBuilder: (_, __) => const SizedBox(height: 12),
            ),
          ),
        ],
      ),
    );
  }
}

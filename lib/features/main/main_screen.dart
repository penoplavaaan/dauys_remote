import 'package:dauys_remote/core/constants/app_tmp_image.dart';
import 'package:dauys_remote/core/helpers/song_extension.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_avatar.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/main/playlist_screen.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:flutter/material.dart';

part 'main_screen_data.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  openPlaylist(Map<String, dynamic> item, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaylistScreen(
          title: item['title'],
          image: item['image'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeAreaTop: false,
      body: ListView(
        padding: const EdgeInsets.only(left: 16),
        children: [
          const TopSpacer(),
          // Avatar row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AppAvatar(asset: AppTmpImage.avatar, size: 46),
              const SizedBox(width: 16),
              Text(
                'N.Jordan',
                style: AppStyles.magistral20w500.copyWith(color: AppColors.white),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            'Рекомандации дня',
            style: AppStyles.magistral20w500.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 165,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: recommendation.length,
              itemBuilder: (context, index) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => openPlaylist(recommendation[index], context),
                child: SizedBox(
                  height: 165,
                  width: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          recommendation[index]['image'],
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        recommendation[index]['title'],
                        style: AppStyles.magistral14w700.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        (recommendation[index]['songs'] as int).toSongString(),
                        style: AppStyles.magistral12w400.copyWith(color: Colors.white.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (_, __) => const SizedBox(width: 10),
            ),
          ),
        ],
      ),
    );
  }
}

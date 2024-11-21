import 'package:blur/blur.dart';
import 'package:dauys_remote/core/constants/app_icons.dart';
import 'package:dauys_remote/core/constants/app_tmp_image.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_gradients.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_avatar.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/core/widget/gradient_overlay.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:dauys_remote/features/profile/history_screen.dart';
import 'package:dauys_remote/features/profile/favorites_screen.dart';
import 'package:dauys_remote/features/profile/my_data_screen.dart';
import 'package:dauys_remote/features/profile/my_playlists_screen.dart';
import 'package:dauys_remote/features/profile/payments_screen.dart';
import 'package:dauys_remote/features/profile/settings_screen.dart';
import 'package:dauys_remote/features/profile/subscriptions_screen.dart';
import 'package:dauys_remote/features/profile/widget/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      disableBackgroundColorSpots: true,
      safeAreaTop: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: AppGradients.buttonRainbow50,
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const TopSpacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      gradient: AppGradients.buttonGrayGradient15,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.black,
                          blurRadius: 50,
                          offset: Offset(30, 0),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppIcons.settings,
                      height: 14,
                      width: 14,
                      color: AppColors.white,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
              const SizedBox(height: 7),
              SizedBox(
                height: 216,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 60),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.45),
                                blurRadius: 50,
                                offset: const Offset(30, 0),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Blur(
                              blur: 10,
                              colorOpacity: 0,
                              child: Container(
                                height: 156,
                                width: 358,
                                decoration: BoxDecoration(
                                  gradient: AppGradients.buttonGrayGradient15,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const AppAvatar(
                          asset: AppTmpImage.avatar,
                          size: 120,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Michael Jordan',
                          style: AppStyles.magistral22w500.copyWith(color: AppColors.white),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GradientOverlay(
                              child: Image.asset(
                                AppIcons.crown,
                                height: 20,
                                width: 20,
                                fit: BoxFit.cover,
                                color: AppColors.white,
                              ),
                            ),
                            const SizedBox(width: 10),
                            GradientOverlay(
                              child: Text(
                                'Премиум пользователь',
                                style: AppStyles.magistral14w400.copyWith(color: AppColors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    const Row(
                      children: [
                        SizedBox(width: 16),
                        ProfileTile(
                          title: 'Мои данные',
                          icon: AppIcons.clowd,
                          page: MyDataScreen(),
                        ),
                        SizedBox(width: 10),
                        ProfileTile(
                          title: 'Избранное',
                          icon: AppIcons.starOutlined,
                          page: FavoritesScreen(),
                        ),
                        SizedBox(width: 16),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        SizedBox(width: 16),
                        ProfileTile(
                          title: 'История',
                          icon: AppIcons.history,
                          page: HistoryScreen(),
                        ),
                        SizedBox(width: 10),
                        ProfileTile(
                          title: 'Мои плейлисты',
                          icon: AppIcons.record,
                          page: MyPlaylistsScreen(),
                        ),
                        SizedBox(width: 16),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        SizedBox(width: 16),
                        ProfileTile(
                          title: 'Настройки',
                          icon: AppIcons.settings,
                          page: SettingsScreen(),
                        ),
                        SizedBox(width: 16),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {},
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Image.asset(
                            AppIcons.exit,
                            height: 20,
                            width: 20,
                            color: AppColors.red,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Выйти',
                            style: AppStyles.magistral16w500.copyWith(color: AppColors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

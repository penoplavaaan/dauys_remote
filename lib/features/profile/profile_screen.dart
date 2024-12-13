import 'package:blur/blur.dart';
import 'package:dauys_remote/core/constants/app_icons.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_gradients.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_avatar.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/core/widget/gradient_overlay.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:dauys_remote/features/profile/my_data_screen.dart';
import 'package:dauys_remote/features/profile/settings_change_password_screen.dart';
import 'package:dauys_remote/features/profile/settings_screen.dart';
import 'package:dauys_remote/features/profile/widget/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../api/api.dart';
import '../../core/constants/app_image.dart';
import '../../models/user_model.dart';
import '../../storage/local_storage.dart';
import 'favorites_screen.dart';
import 'history_screen.dart';
import 'my_playlists_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<User> userFuture;

  @override
  void initState() {
    super.initState();
    // Fetch user settings when the screen is initialized
    userFuture = fetchUserSettings();
  }

  // Fetch user settings and handle token retrieval
  Future<User> fetchUserSettings() async {
    try {
      final api = await Api.create();
      return await api.getUserFullData();
    } catch (e) {
      // Handle error, maybe show a dialog or a message
      print('Error fetching user settings: $e');
      rethrow; // Optionally rethrow or handle the error
    }
  }

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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SettingsChangePasswordScreen()),
                        );
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Image.asset(
                        AppIcons.settings,
                        height: 14,
                        width: 14,
                        color: AppColors.white,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
              const SizedBox(height: 7),
              SizedBox(
                height: 216,
                child: FutureBuilder<User>(
                  future: userFuture, // Use the future from initState
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Stack(
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
                                asset: AppImage.icon,
                                size: 120,
                              ),
                              const SizedBox(height: 20),
                              const Center(child: CircularProgressIndicator()),
                              // Text(
                              //   '', // Use username from User model
                              //   style: AppStyles.magistral22w500.copyWith(color: AppColors.white),
                              // ),
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
                                      FlutterI18n.translate(context, "profile.premium_user"),
                                      style: AppStyles.magistral14w400.copyWith(color: AppColors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData) {
                      return Stack(
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
                                asset: AppImage.icon,
                                size: 120,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                '', // Use username from User model
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
                                      FlutterI18n.translate(context, "profile.premium_user"),
                                      style: AppStyles.magistral14w400.copyWith(color: AppColors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    }

                    final user = snapshot.data!; // Get user data
                    print('fetched user on profile screen');
                    print(user);
                    return Stack(
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
                              asset: AppImage.icon,
                              size: 120,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              user.username, // Use username from User model
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
                                    FlutterI18n.translate(context, "profile.premium_user"),
                                    style: AppStyles.magistral14w400.copyWith(color: AppColors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        ProfileTile(
                          title: FlutterI18n.translate(context, "profile.my_data"),
                          icon: AppIcons.clowd,
                          page: MyDataScreen(),
                        ),
                        const SizedBox(width: 10),
                        ProfileTile(
                          title: FlutterI18n.translate(context, "profile.favorites"),
                          icon: AppIcons.starOutlined,
                          page: FavoritesScreen(),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        ProfileTile(
                          title: FlutterI18n.translate(context, "profile.history"),
                          icon: AppIcons.history,
                          page: HistoryScreen(),
                        ),
                        const SizedBox(width: 10),
                        ProfileTile(
                          title: FlutterI18n.translate(context, "profile.my_playlists"),
                          icon: AppIcons.record,
                          page: MyPlaylistsScreen(),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        ProfileTile(
                          title: FlutterI18n.translate(context, "profile.settings"),
                          icon: AppIcons.settings,
                          page: SettingsScreen(),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () async {
                        final localStorage = LocalStorage();
                        await localStorage.clearCredentials();
                        if (context.mounted) {
                          Phoenix.rebirth(context);
                        }
                      },
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
                            FlutterI18n.translate(context, "profile.logout"),
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

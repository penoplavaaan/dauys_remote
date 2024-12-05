import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/auth/widget/auth_top_panel.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:dauys_remote/features/profile/settings_change_language_screen.dart';
import 'package:dauys_remote/features/profile/settings_change_password_screen.dart';
import 'package:dauys_remote/features/profile/settings_devises_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool value = true;

  Widget _title(String title) => Text(
        title,
        style: AppStyles.magistral14w400.copyWith(color: AppColors.white.withOpacity(.4)),
      );

  Widget _text(String text) => Expanded(
        child: Text(
          text,
          style: AppStyles.magistral16w500.copyWith(color: AppColors.white),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeAreaTop: false,
      disableBackgroundColorSpots: true,
      body: Column(
        children: [
          const TopSpacer(),
          const AuthTopPanel(title: 'Настройки'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
              children: [
                _title('БЕЗОПАСНОСТЬ'),
                const SizedBox(height: 7),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsChangePasswordScreen()),
                    );
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.white.withOpacity(.1),
                    ),
                    child: Row(
                      children: [
                        _text('Сменить пароль'),
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _title('ПОДКЛЮЧЕНИЕ'),
                const SizedBox(height: 7),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20),
                    color: AppColors.white.withOpacity(.1),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SettingsDevisesScreen()),
                            );
                          },
                          behavior: HitTestBehavior.opaque,
                          child: SizedBox(
                            height: 60,
                            child: Row(
                              children: [
                                _text('Подключенные устройства'),
                                const SizedBox(width: 16),
                                const Icon(
                                  Icons.chevron_right,
                                  size: 20,
                                  color: AppColors.white,
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _title('ПРИЛОЖЕНИЕ'),
                const SizedBox(height: 7),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20),
                    color: AppColors.white.withOpacity(.1),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SettingsChangeLanguageScreen()),
                            );
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: AppColors.white.withOpacity(.2))),
                            ),
                            child: Row(
                              children: [
                                _text('Сменить язык'),
                                const SizedBox(width: 16),
                                Text(
                                  'Русский',
                                  style: AppStyles.magistral16w400.copyWith(color: AppColors.white.withOpacity(.5)),
                                ),
                                const SizedBox(width: 16),
                                const Icon(
                                  Icons.chevron_right,
                                  size: 20,
                                  color: AppColors.white,
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: AppColors.white.withOpacity(.2))),
                            ),
                            child: Row(
                              children: [
                                _text('Условия пользования'),
                                const SizedBox(width: 16),
                                const Icon(
                                  Icons.chevron_right,
                                  size: 20,
                                  color: AppColors.white,
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          behavior: HitTestBehavior.opaque,
                          child: SizedBox(
                            height: 60,
                            child: Row(
                              children: [
                                _text('Политика конфиденциальности'),
                                const SizedBox(width: 16),
                                const Icon(
                                  Icons.chevron_right,
                                  size: 20,
                                  color: AppColors.white,
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

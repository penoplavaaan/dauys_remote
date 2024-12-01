import 'package:dauys_remote/core/constants/app_icons.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_gradients.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/core/widget/app_switch.dart';
import 'package:dauys_remote/features/auth/widget/auth_top_panel.dart';
import 'package:dauys_remote/features/main/widget/gradient_button.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:dauys_remote/features/profile/settings_change_language_screen.dart';
import 'package:dauys_remote/features/profile/settings_change_password_screen.dart';
import 'package:dauys_remote/features/profile/settings_devices_enter_code_screen.dart';
import 'package:dauys_remote/features/profile/settings_devices_scan_screen.dart';
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
                            setState(() {
                              value = !value;
                            });
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: AppColors.white.withOpacity(.2))),
                            ),
                            child: Row(
                              children: [
                                _text('Отображать пульт управления'),
                                const SizedBox(width: 16),
                                AppSwitch(value: value),
                                const SizedBox(width: 20),
                              ],
                            ),
                          ),
                        ),
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
                GradientButton(
                  title: 'Подключить устройство',
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      barrierColor: AppColors.black.withOpacity(0.3),
                      backgroundColor: Colors.transparent,
                      scrollControlDisabledMaxHeightRatio: 1,
                      builder: (context) => Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              gradient: AppGradients.darkGradientVertical,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  color: AppColors.black.withOpacity(.1),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.only(top: 50, bottom: 30, left: 16, right: 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Подключение устройства',
                                  style: AppStyles.magistral20w500.copyWith(color: AppColors.white),
                                ),
                                const SizedBox(height: 30),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.white.withOpacity(.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const SettingsDevicesScanScreen()),
                                          );
                                        },
                                        behavior: HitTestBehavior.opaque,
                                        child: SizedBox(
                                          height: 60,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Сканировать QR',
                                                  style: AppStyles.magistral16w500.copyWith(color: AppColors.white),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              const Icon(
                                                Icons.chevron_right,
                                                size: 20,
                                                color: AppColors.white,
                                              ),
                                              const SizedBox(width: 16),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 1,
                                        width: double.infinity,
                                        color: AppColors.white.withOpacity(.2),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const SettingsDevicesEnterCodeScreen()),
                                          );
                                        },
                                        behavior: HitTestBehavior.opaque,
                                        child: SizedBox(
                                          height: 60,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Ввести код вручную',
                                                  style: AppStyles.magistral16w500.copyWith(color: AppColors.white),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              const Icon(
                                                Icons.chevron_right,
                                                size: 20,
                                                color: AppColors.white,
                                              ),
                                              const SizedBox(width: 16),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              behavior: HitTestBehavior.opaque,
                              child: Image.asset(
                                AppIcons.close,
                                height: 20,
                                width: 20,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
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

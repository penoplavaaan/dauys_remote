import 'package:dauys_remote/api/api.dart';
import 'package:dauys_remote/core/widget/app_button.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/auth/widget/auth_top_panel.dart';
import 'package:dauys_remote/features/auth/widget/password_input.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../auth/widget/nullable_password_input.dart';

class SettingsChangePasswordScreen extends StatefulWidget {
  const SettingsChangePasswordScreen({super.key});

  @override
  State<SettingsChangePasswordScreen> createState() => _SettingsChangePasswordScreenState();
}

class _SettingsChangePasswordScreenState extends State<SettingsChangePasswordScreen> {
  final controllerOldPassword = TextEditingController();
  final controllerNewPassord = TextEditingController();
  final controllerRepeatPassword = TextEditingController();

  Widget _title(String title) => Text(
    title,
    style: AppStyles.magistral14w400.copyWith(color: AppColors.white.withOpacity(.4)),
  );

  @override
  void dispose() {
    controllerOldPassword.dispose();
    controllerNewPassord.dispose();
    controllerRepeatPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeAreaTop: false,
      disableBackgroundColorSpots: true,
      body: Column(
        children: [
          const TopSpacer(),
          const AuthTopPanel(title: 'Сменить пароль'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
              children: [
                _title('Если вы входили ТОЛЬКО через Google, оставьте пустым:'),
                const SizedBox(height: 10),
                NullablePasswordInput(
                  controller: controllerOldPassword,
                  hintText: 'Введите старый пароль',
                ),
                const SizedBox(height: 30),
                PasswordInput(
                  controller: controllerNewPassord,
                  hintText: 'Новый пароль',
                ),
                const SizedBox(height: 10),
                PasswordInput(
                  controller: controllerRepeatPassword,
                  hintText: 'Повторите пароль',
                ),
                const SizedBox(height: 30),
                Center(
                  child: AppButton(
                    title: 'Сохранить',
                    onTap: () async {
                      final api = await Api.create();
                      final res = await api.changePassword(
                        oldPassword: controllerOldPassword.text,
                        newPassword: controllerNewPassord.text,
                        newPasswordRepeat: controllerRepeatPassword.text,
                      );
                      if(res == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Пароль успешно сохранен!')),
                        );
                        return;
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Ошибка сохранения пароля')),
                      );
                    },
                    width: 150,
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

import 'package:dauys_remote/core/widget/app_button.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/auth/widget/auth_top_panel.dart';
import 'package:dauys_remote/features/auth/widget/password_input.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:flutter/material.dart';

class SettingsChangePasswordScreen extends StatefulWidget {
  const SettingsChangePasswordScreen({super.key});

  @override
  State<SettingsChangePasswordScreen> createState() => _SettingsChangePasswordScreenState();
}

class _SettingsChangePasswordScreenState extends State<SettingsChangePasswordScreen> {
  final controllerOldPassword = TextEditingController();
  final controllerNewPassord = TextEditingController();
  final controllerRepeatPassword = TextEditingController();

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
                PasswordInput(
                  controller: controllerOldPassword,
                  hintText: 'Введите старый пароль',
                ),
                const SizedBox(height: 10),
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
                const Center(
                  child: AppButton(
                    title: 'Сохранить',
                    onTap: null,
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

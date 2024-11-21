import 'package:dauys_remote/core/constants/app_svg.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_button.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/core/widget/app_text_input.dart';
import 'package:dauys_remote/features/auth/widget/auth_top_panel.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingsDevicesEnterCodeScreen extends StatefulWidget {
  const SettingsDevicesEnterCodeScreen({super.key});

  @override
  State<SettingsDevicesEnterCodeScreen> createState() => SettingsDevicesEnterCodeScreenState();
}

class SettingsDevicesEnterCodeScreenState extends State<SettingsDevicesEnterCodeScreen> {
  final controller = TextEditingController();

  bool isDisabled = true;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        isDisabled = controller.text.isEmpty;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
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
          const AuthTopPanel(title: 'Ввести код'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
              children: [
                SvgPicture.asset(AppSvg.deviceCard),
                const SizedBox(height: 12),
                Text(
                  'Введите код, который видите\nна экране интерфейса',
                  style: AppStyles.magistral14w500.copyWith(color: AppColors.white.withOpacity(.5)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                AppTextInput(
                  controller: controller,
                  hintText: 'Введите код',
                ),
                const SizedBox(height: 30),
                Center(
                  child: AppButton(
                    title: 'Отправить',
                    width: 130,
                    onTap: isDisabled ? null : () {},
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

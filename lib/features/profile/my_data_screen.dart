import 'package:dauys_remote/core/constants/app_tmp_image.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_avatar.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/auth/widget/auth_top_panel.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:dauys_remote/features/profile/widget/my_data_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyDataScreen extends StatefulWidget {
  const MyDataScreen({
    super.key,
  });

  @override
  State<MyDataScreen> createState() => _MyDataScreenState();
}

class _MyDataScreenState extends State<MyDataScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeAreaTop: false,
      disableBackgroundColorSpots: true,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const TopSpacer(),
          const AuthTopPanel(title: 'Мои данные'),
          const SizedBox(height: 50),
          const Center(
            child: AppAvatar(
              asset: AppTmpImage.avatar,
              size: 120,
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 30,
                width: 148,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.white.withOpacity(.1),
                ),
                padding: const EdgeInsets.symmetric(vertical: 7),
                alignment: Alignment.center,
                child: Text(
                  'Изменить фото',
                  style: AppStyles.magistral14w500.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const MyDataCard(
            title: 'Ваш логин',
            data: 'Ivanovich',
          ),
          const SizedBox(height: 10),
          const MyDataCard(
            title: 'Ваше имя',
            data: 'Иван',
          ),
          const SizedBox(height: 10),
          const MyDataCard(
            title: 'Номер телефона',
            data: '+7 (707) 777-77-77',
          ),
          const SizedBox(height: 10),
          const MyDataCard(
            title: 'Эл. адрес',
            data: 'ivan@mail.ru',
          ),
        ],
      ),
    );
  }
}

import 'package:dauys_remote/core/constants/app_icons.dart';
import 'package:dauys_remote/core/constants/app_svg.dart';
import 'package:dauys_remote/core/constants/app_tmp_image.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_button.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/main/sing_screen.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SongPreviewScreen extends StatefulWidget {
  const SongPreviewScreen({super.key});

  @override
  State<SongPreviewScreen> createState() => _SongPreviewScreenState();
}

class _SongPreviewScreenState extends State<SongPreviewScreen> {
  final double progress = 0.35;

  Widget buildTitle(String text) => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          text,
          style: AppStyles.magistral16w700.copyWith(color: AppColors.white.withOpacity(0.4)),
        ),
      );

  Widget buildLine(String text) => Text(
        text,
        style: AppStyles.magistral16w700.copyWith(color: AppColors.white),
      );

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeAreaTop: false,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const TopSpacer(),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.keyboard_arrow_down, // TODO KANTUR: change to asset icon
                          size: 20,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Boulevard Depo',
                style: AppStyles.magistral16w500.copyWith(color: AppColors.white),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '4',
                            style: AppStyles.magistral16w500.copyWith(color: AppColors.white),
                          ),
                          const SizedBox(width: 4),
                          SvgPicture.asset(
                            AppSvg.star,
                            height: 21,
                            width: 21,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 44),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                AppTmpImage.albumCover[4],
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Фантики',
                        style: AppStyles.magistral20w700.copyWith(color: AppColors.white),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Hollyflame',
                        style: AppStyles.magistral20w500.copyWith(color: AppColors.white.withOpacity(0.6)),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Image.asset(
                    AppIcons.starOutlined,
                    height: 26,
                    width: 26,
                    color: AppColors.white,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: 7,
                width: double.infinity,
                child: LayoutBuilder(builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  return Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        height: 3,
                        width: width,
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Container(
                        height: 3,
                        width: width * progress,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Positioned(
                        left: (width - 7) * progress,
                        child: Container(
                          height: 7,
                          width: 7,
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    '0:46',
                    style: AppStyles.magistral12w400.copyWith(color: AppColors.white.withOpacity(0.6)),
                  ),
                  const Spacer(),
                  Text(
                    '2:42',
                    style: AppStyles.magistral12w400.copyWith(color: AppColors.white.withOpacity(0.6)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Spacer(),
                  SvgPicture.asset(
                    AppSvg.skipPrev,
                    height: 24,
                    width: 27.26,
                  ),
                  const SizedBox(width: 50),
                  SvgPicture.asset(
                    AppSvg.playBig,
                    height: 60,
                    width: 60,
                  ),
                  const SizedBox(width: 50),
                  SvgPicture.asset(
                    AppSvg.skipNext,
                    height: 24,
                    width: 27.26,
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Текст',
                      style: AppStyles.magistral16w500.copyWith(color: AppColors.white),
                    ),
                    buildTitle('Куплет:'),
                    buildLine('Мимо нас снова метель'),
                    buildLine('Мы увы уже не те'),
                    buildLine('Смотрим будто через'),
                    buildLine('Прицел и ты попадаешь прям в цель'),
                    buildTitle('Запев:'),
                    buildLine('Мы топили лед (буль)'),
                    buildLine('Фразы наперед (пиу)'),
                    buildLine('Мысли о тебе уже не липнут будто мед'),
                    buildLine('Ты меня запомнишь, но не станешь вспоминать'),
                    buildLine('Только в тот момент когда будешь ложиться спать'),
                    buildTitle('Припев:'),
                    buildLine('Мы с тобой будто старые фантики'),
                    buildLine('Старые фантики старые фантики'),
                    buildLine('Я тебя сотру из своей памяти из своей памяти'),
                    buildLine('Из своей памяти'),
                    buildTitle('Куплет 2:'),
                    buildLine('Что-то снова не так'),
                    buildLine('Что-то снова не то'),
                    buildLine('Я тебя потерял среди этих дворов'),
                    buildLine('You might also like'),
                    buildLine('Плевать (Spit)'),
                    buildTitle('Запев:'),
                    buildLine('Мы топили лед (буль)'),
                    buildLine('Фразы наперед (пиу)Мысли о тебе уже не липнут будто мед'),
                    buildLine('Ты меня запомнишь, но не станешь вспоминать'),
                    buildLine('Только в тот момент когда будешь ложиться спать'),
                    buildTitle('Припев:'),
                    buildLine('Мы с тобой будто старые фантики'),
                    buildLine('Старые фантики старые фантики'),
                    buildLine('Я тебя сотру из своей памяти из своей памяти'),
                    buildLine('Из своей памяти'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          AppButton(
            title: 'Спеть',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SingScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:dauys_remote/core/constants/app_icons.dart';
import 'package:dauys_remote/core/constants/app_image.dart';
import 'package:dauys_remote/core/constants/app_svg.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_gradients.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_button.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/song_new.dart';
import '../../models/user_model.dart';
import '../../socket/socket_service.dart';

class SingScreenNew extends StatefulWidget {
  final SongNew song;
  final User user;

  const SingScreenNew({super.key, required this.song, required this.user});

  @override
  State<SingScreenNew> createState() => _SingScreenNewState();
}

class _SingScreenNewState extends State<SingScreenNew> {
  late SocketService client;


  @override
  void initState() {
    super.initState();
    client = SocketService(
      widget.user,
      widget.song,
      2
    );
  }

  @override
  void dispose() {
    client.deactivate();
    super.dispose();
  }

  final controller = PageController();


  Future<T?> bottomSheetBuilder<T>({required List<Widget> children}) => showModalBottomSheet(
        context: context,
        barrierColor: AppColors.black.withOpacity(0.3),
        backgroundColor: Colors.transparent,
        scrollControlDisabledMaxHeightRatio: 1,
        builder: (context) => Container(
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
            children: children,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopSpacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.white.withOpacity(0.8),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFFFFFFFF).withOpacity(0.15),
                        const Color(0xFFA4A4A4).withOpacity(0.15),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.45),
                        blurRadius: 50,
                        offset: const Offset(30, 0),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    AppIcons.close,
                    width: 14,
                    height: 14,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        Expanded(
          child: PageView(
            controller: controller,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.asset(
                        AppImage.mic1,
                        fit: BoxFit.cover,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '1 микрофон',
                            style: AppStyles.magistral25w500.copyWith(color: AppColors.white),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Классический режим',
                            style: AppStyles.magistral12w400.copyWith(color: AppColors.white.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.asset(
                        AppImage.mic2,
                        fit: BoxFit.cover,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '2 микрофона',
                            style: AppStyles.magistral25w500.copyWith(color: AppColors.white),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Режим соревнования с друзьями!',
                            style: AppStyles.magistral12w400.copyWith(color: AppColors.white.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SmoothPageIndicator(
          controller: controller,
          count: 2,
          effect: ExpandingDotsEffect(
            dotColor: AppColors.white.withOpacity(0.2),
            activeDotColor: AppColors.white,
            dotWidth: 10,
            strokeWidth: 20,
            dotHeight: 10,
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppButton(
            title: 'Начать',
            onTap: () async {
              bottomSheetBuilder(
                children: [
                  Text(
                    'Поиск устройств',
                    style: AppStyles.magistral20w500.copyWith(color: AppColors.white),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(1),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundButtonGradient1.withOpacity(0.05),
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundButtonGradient1.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundButtonGradient1.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundButtonGradient1.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Поиск Dauys Karaoke Box',
                    style: AppStyles.magistral14w400.copyWith(color: AppColors.white.withOpacity(0.4)),
                  ),
                ],
              ).then((value) {
                if (value == null) return;
                bottomSheetBuilder(children: [
                  Text(
                    'К сожалению,\nустройства не найдено',
                    textAlign: TextAlign.center,
                    style: AppStyles.magistral20w500.copyWith(color: AppColors.white),
                  ),
                  const SizedBox(height: 26),
                  SvgPicture.asset(
                    AppSvg.s404,
                    height: 148,
                    width: 220,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Убедитесь что Dauys Karaoke Box включен и подключен к той же сети Wi-Fi',
                    textAlign: TextAlign.center,
                    style: AppStyles.magistral14w400.copyWith(color: AppColors.white.withOpacity(0.4)),
                  ),
                  const SizedBox(height: 30),
                  AppButton(
                    title: 'Повторить поиск',
                    onTap: () {
                      Navigator.of(context).pop();
                      bottomSheetBuilder(children: [
                        Text(
                          'Доступные устройства',
                          textAlign: TextAlign.center,
                          style: AppStyles.magistral20w500.copyWith(color: AppColors.white),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: 3,
                            itemBuilder: (index, context) => Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Dauys Karaoke Box',
                                          style: AppStyles.magistral16w500.copyWith(color: AppColors.white),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'KB102242201911WW',
                                          style: AppStyles.magistral12w400
                                              .copyWith(color: AppColors.white.withOpacity(0.5)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.white.withOpacity(.2),
                                      ),
                                      child: Text(
                                        'Подключится',
                                        style: AppStyles.magistral12w400.copyWith(color: AppColors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            separatorBuilder: (_, __) => Container(
                              height: 1,
                              width: double.infinity,
                              color: AppColors.white.withOpacity(0.2),
                            ),
                          ),
                        ),
                      ]);
                    },
                  ),
                ]);
              });
            },
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

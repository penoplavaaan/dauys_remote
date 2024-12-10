import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dauys_remote/core/constants/app_icons.dart';
import 'package:dauys_remote/core/constants/app_svg.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_button.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../api/api.dart';
import '../../core/constants/app_image.dart';
import '../../core/helpers/ImageAWS.dart';
import '../../core/theme/app_gradients.dart';
import '../../models/song_new.dart';
import '../../models/user_model.dart';
import '../../socket/socket_service.dart';
import '../gateway/gateway_screen.dart';

class SongPreviewScreenNew extends StatefulWidget {
  final String songID;

  const SongPreviewScreenNew({
    super.key,
    required this.songID,
  });

  @override
  State<SongPreviewScreenNew> createState() => _SongPreviewScreenNewState();
}

class _SongPreviewScreenNewState extends State<SongPreviewScreenNew> {
  late Future<SongNew> _song;
  late User _user;
  late SongNew _songFinal;
  final controller = PageController();
  late SocketService client;
  Api? api;
  bool isInFavourites = false;

  int _micCount = 1;
  late Widget _connectRegion;
  late Widget _connectToBox;
  late Widget _player;

  bool showChooseMicsRegion = true;
  bool showPlayer = false;
  bool showConnectToBox = false;

  bool _isPlaying = false;
  int _progressInSec = 0;

  @override
  void dispose() {
    try {
      client.deactivate();
    } catch (e) {
      print('Error deactivating socket client');
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _song = Api.create().then((api) => api.getSongById(int.parse(widget.songID))).then((sng) {
      _songFinal = sng;
      isInFavourites = sng.isInUserFavorites;
      return sng;
    });

    Api.create().then((api) => api.getUserFullData()).then((user) => _user = user);
    Api.create().then((Api a) {
      api = a;
    });
  }

  void toggleFavorite() {
    bool newFavVal = !isInFavourites;

    if (api is Api) {
      api?.toggleFavourites(_songFinal.id, newFavVal);
    }
    setState(() {
      isInFavourites = !isInFavourites;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _connectRegion = AppButton(
        title: FlutterI18n.translate(context, "song_preview.select_mode"), // заменено
        onTap: () async {
          bottomSheetBuilder(
            children: [
              Expanded(
                child: PageView(
                  controller: controller,
                  onPageChanged: (page) {
                    setState(() {
                      _micCount = page == 0 ? 1 : 2;
                    });
                  },
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image.asset(
                              AppImage.mic1,
                              fit: BoxFit.fill,
                            ),
                            Column(
                              children: [
                                Text(
                                  FlutterI18n.translate(context, "song_preview.one_microphone"), // заменено
                                  style: AppStyles.magistral25w500.copyWith(color: AppColors.white),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  FlutterI18n.translate(context, "song_preview.classic_mode"), // заменено
                                  style: AppStyles.magistral12w400.copyWith(color: AppColors.white.withOpacity(0.5)),
                                ),
                                const SizedBox(height: 350),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: AppButton(
                                    title: FlutterI18n.translate(context, "song_preview.start"), // заменено
                                    onTap: () {
                                      setState(() {
                                        showChooseMicsRegion = false;
                                        showConnectToBox = true;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
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
                                  FlutterI18n.translate(context, "song_preview.two_microphones"), // заменено
                                  style: AppStyles.magistral25w500.copyWith(color: AppColors.white),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  FlutterI18n.translate(context, "song_preview.competition_mode"), // заменено
                                  style: AppStyles.magistral12w400.copyWith(color: AppColors.white.withOpacity(0.5)),
                                ),
                                const SizedBox(height: 350),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: AppButton(
                                    title: FlutterI18n.translate(context, "song_preview.start"), // заменено
                                    onTap: () {
                                      setState(() {
                                        showChooseMicsRegion = false;
                                        showConnectToBox = true;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
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
            ],
          );
        },
      );

      _connectToBox = AppButton(
        title: FlutterI18n.translate(context, "song_preview.connect_device"), // заменено
        onTap: () async {
          bottomSheetBuilder(
            children: [
              Text(
                FlutterI18n.translate(context, "song_preview.searching_devices"), // заменено
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
                FlutterI18n.translate(context, "song_preview.searching_dauys_box"), // заменено
                style: AppStyles.magistral14w400.copyWith(color: AppColors.white.withOpacity(0.4)),
              ),
            ],
          );

          bool isConnected = false;

          client = SocketService(_user, _songFinal, _micCount);
          await client.configure();

          for (int i = 0; i <= 5; i++) {
            sleep(const Duration(seconds: 3));
            if (client.isConnected()) {
              isConnected = true;
              break;
            }
          }

          if (isConnected) {
            setState(() {
              showChooseMicsRegion = false;
              showPlayer = true;
              showConnectToBox = false;
            });
            await Future.delayed(const Duration(seconds: 4));
            Navigator.pop(context);
          }
        },
      );

      _player = Row(
        children: [
          const Spacer(),
          const SizedBox(width: 50),
          GestureDetector(
            onTap: () {
              if (_isPlaying) {
                client.onPause();
              }
              if (!_isPlaying && _progressInSec != 0) {
                client.onResume();
              }
              if (!_isPlaying && _progressInSec == 0) {
                client.onPlay();
                _progressInSec = 1;
              }
              setState(() {
                _isPlaying = !_isPlaying;
              });
            },
            child: _isPlaying
                ? SvgPicture.asset(
              AppSvg.pauseBig,
              height: 60,
              width: 60,
            )
                : SvgPicture.asset(
              AppSvg.playBig,
              height: 60,
              width: 60,
            ),
          ),
          const SizedBox(width: 50),
          const Spacer(),
        ],
      );
    });

    final starNotFav = GestureDetector(
      onTap: toggleFavorite,
      child: Image.asset(
        AppIcons.starOutlined,
        height: 26,
        width: 26,
        color: AppColors.white,
      ),
    );

    final starFav = GestureDetector(
      onTap: toggleFavorite,
      child: Image.asset(
        AppIcons.starOutlined,
        height: 26,
        width: 26,
        color: AppColors.yellow,
      ),
    );

    return AppScaffold(
      safeAreaTop: false,
      body: FutureBuilder<SongNew>(
        future: _song,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                FlutterI18n.translate(context, "song_preview.error",), // заменено
                style: AppStyles.magistral16w500.copyWith(color: AppColors.white),
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          final song = snapshot.data!;

          return ListView(
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
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const GateWayScreen()),
                          ),
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            height: 32,
                            width: 32,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 20,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    song.name,
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
                                song.rating,
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
                  child: Image.network(
                    ImageAWS.getImageURI(song.songImageUri),
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
                            song.name,
                            style: AppStyles.magistral20w700.copyWith(color: AppColors.white),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            song.album,
                            style: AppStyles.magistral20w500.copyWith(color: AppColors.white.withOpacity(0.6)),
                          ),
                        ],
                      ),
                      const Spacer(),
                      isInFavourites ? starFav : starNotFav,
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
                            width: width * 90,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Positioned(
                            left: (width - 7) * 90,
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
                        '0:00',
                        style: AppStyles.magistral12w400.copyWith(color: AppColors.white.withOpacity(0.6)),
                      ),
                      const Spacer(),
                      Text(
                        formatDuration(jsonDecode(song.metadata)['xmpDM:duration'] ?? '0,0'),
                        style: AppStyles.magistral12w400.copyWith(color: AppColors.white.withOpacity(0.6)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (showChooseMicsRegion) _connectRegion,
                  if (showConnectToBox) _connectToBox,
                  if (showPlayer) _player,
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 400,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FlutterI18n.translate(context, "song_preview.text"), // заменено
                            style: AppStyles.magistral16w500.copyWith(color: AppColors.white),
                          ),
                          buildLine(song.songText),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          );
        },
      ),
    );
  }

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

  String formatDuration(String secondsString) {
    secondsString = secondsString.replaceFirst(',', '.');
    double totalSeconds = 0.0;

    try {
      totalSeconds = double.parse(secondsString);
    } catch (e) {
      print(secondsString);
      throw e;
    }

    int minutes = totalSeconds ~/ 60;
    int seconds = (totalSeconds % 60).toInt();

    String formatted = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return formatted;
  }

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
}

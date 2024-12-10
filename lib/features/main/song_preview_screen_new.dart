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
  final String songID; // Add the songID parameter

  const SongPreviewScreenNew({
    super.key,
    required this.songID,
  });

  @override
  State<SongPreviewScreenNew> createState() => _SongPreviewScreenNewState();
}

class _SongPreviewScreenNewState extends State<SongPreviewScreenNew> {
  late Future<SongNew> _song; // Add a future to fetch the song
  late User _user; // Add a future to fetch the song
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
    try{
      client.deactivate();
    }catch(e){
      print('Error deactivating socket client');
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Fetch the song data using the provided songID
    _song = Api.create().then((api) => api.getSongById(int.parse(widget.songID))).then((sng) {
      _songFinal = sng;
      isInFavourites = sng.isInUserFavorites;
      return sng;
    });

    Api.create().then((api) => api.getUserFullData()).then((user) => _user = user);
    Api.create().then((Api a) {
      api = a;
    });

    // isInFavourites = _songFinal.isInUserFavorites;
    _connectRegion = AppButton(
      title: 'Выбрать режим',
      onTap: () async {
        bottomSheetBuilder(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (page) {
                  if(page == 0){
                    setState(() {
                      _micCount = 1;
                    });
                  }else{
                    setState(() {
                      _micCount = 2;
                    });
                  }
                  print('page');
                  print(page);
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
                            // width: 180,
                          ),
                          Column(
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
                              const SizedBox(height: 350),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: AppButton(
                                  title: 'Начать',
                                  onTap: ()  {
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
                                '2 микрофона',
                                style: AppStyles.magistral25w500.copyWith(color: AppColors.white),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Режим соревнования с друзьями!',
                                style: AppStyles.magistral12w400.copyWith(color: AppColors.white.withOpacity(0.5)),
                              ),
                              const SizedBox(height: 350),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: AppButton(
                                  title: 'Начать',
                                  onTap: ()  {
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
    _connectToBox =  AppButton(
      title: 'Подключить приставку',
      onTap: ()  async {
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
        );

        bool isConnected = false;

        client = SocketService(
          _user,
          _songFinal,
          _micCount
        );
        await client.configure();

        for(int i = 0; i <=5; i++) {
          sleep(const Duration(seconds: 3));
          print('trying to connect from another class');
          if(client.isConnected()) {
            isConnected = true;
            print('connected from another class');
            break;
          }
          print('client is not connected');
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
                if(_isPlaying){
                  client.onPause();
                }
                if(!_isPlaying && _progressInSec != 0){
                  client.onResume();
                }
                if(!_isPlaying && _progressInSec == 0){
                  client.onPlay();
                  _progressInSec = 1;
                }
                setState(() {
                  _isPlaying = !_isPlaying;
                });
                print('Playing (after touch:) $_isPlaying');
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
  }


  void toggleFavorite() {
    bool newFavVal = !isInFavourites;

    if(api is Api){
      api?.toggleFavourites(_songFinal.id, newFavVal);
    }
    setState(() {
      isInFavourites = !isInFavourites;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        future: _song, // Use the future for fetching the song
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          final song = snapshot.data!; // Get the song data

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
                              Icons.keyboard_arrow_down, // TODO: Replace with asset icon
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
                    ImageAWS.getImageURI(song.songImageUri),// Use the fetched image URL
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
                            song.name, // Use the fetched album name
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
                  const SizedBox(height: 20),
                  if(showChooseMicsRegion) _connectRegion,
                  if(showConnectToBox) _connectToBox,
                  if (showPlayer) _player,
                  // Row(
                  //   children: [
                  //     const Spacer(),
                  //     SvgPicture.asset(
                  //       AppSvg.skipPrev,
                  //       height: 24,
                  //       width: 27.26,
                  //     ),
                  //     const SizedBox(width: 50),
                  //     SvgPicture.asset(
                  //       AppSvg.playBig,
                  //       height: 60,
                  //       width: 60,
                  //     ),
                  //     const SizedBox(width: 50),
                  //     SvgPicture.asset(
                  //       AppSvg.skipNext,
                  //       height: 24,
                  //       width: 27.26,
                  //     ),
                  //     const Spacer(),
                  //   ],
                  // ),
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
                            'Текст',
                            style: AppStyles.magistral16w500.copyWith(color: AppColors.white),
                          ),
                          buildLine(song.songText),
                        ],
                      ),
                    )
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
    // Parse the input string to a double
    double totalSeconds = double.parse(secondsString);

    // Convert total seconds to minutes and seconds
    int minutes = totalSeconds ~/ 60; // Integer division for minutes
    int seconds = (totalSeconds % 60).toInt(); // Convert remainder to int

    // Format as mm:ss
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



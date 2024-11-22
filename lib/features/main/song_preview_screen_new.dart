import 'dart:convert';

import 'package:dauys_remote/core/constants/app_icons.dart';
import 'package:dauys_remote/core/constants/app_svg.dart';
import 'package:dauys_remote/core/constants/app_tmp_image.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_button.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/main/sing_screen.dart';
import 'package:dauys_remote/features/main/sing_screen_new.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../api/api.dart';
import '../../core/helpers/ImageAWS.dart';
import '../../models/song_new.dart';

class SongPreviewScreenNew extends StatefulWidget {
  final String songID; // Add the songID parameter

  const SongPreviewScreenNew({
    super.key,
    required this.songID, // Make it required
  });

  @override
  State<SongPreviewScreenNew> createState() => _SongPreviewScreenNewState();
}

class _SongPreviewScreenNewState extends State<SongPreviewScreenNew> {
  late Future<SongNew> _song; // Add a future to fetch the song

  @override
  void initState() {
    super.initState();
    // Fetch the song data using the provided songID
    _song = Api.create().then((api) => api.getSongById(int.parse(widget.songID)));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeAreaTop: false,
      body: FutureBuilder<SongNew>(
        future: _song, // Use the future for fetching the song
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
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
                          onTap: () => Navigator.of(context).pop(),
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
                                '4', // Example rating, replace with actual data if available
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
                            // 'Hollyflame', // You can update this as needed
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
                  AppButton(
                    title: 'Спеть',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SingScreenNew(songID: '5',),
                        ),
                      );
                    },
                  ),
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
}



import 'package:blur/blur.dart';
import 'package:dauys_remote/core/constants/app_svg.dart';
import 'package:dauys_remote/core/constants/app_tmp_image.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/add_button.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/main/song_preview_screen.dart';
import 'package:dauys_remote/features/main/widget/playlist_item.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

part 'playlist_screen_data.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({
    super.key,
    required this.title,
    required this.image,
  });

  final String title;
  final String image;

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final double percent = 0.2;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      disableBackgroundColorSpots: true,
      safeAreaTop: false,
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Column(
            children: [
              DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x99FE433A),
                      Color(0x00FE433A),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TopSpacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            height: 32,
                            width: 32,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.chevron_left, // TODO KANTUR: change to asset icon
                              size: 20,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 22),
                        Flexible(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              constraints: BoxConstraints.loose(const Size(250, 250)),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.asset(
                                  widget.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 22),
                        AddButton(
                          onTap: () {},
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                style: AppStyles.magistral30w700.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
                  shrinkWrap: true,
                  itemCount: playlist.length,
                  itemBuilder: (context, index) => PlaylistItem(
                    image: playlist[index]['image'],
                    title: playlist[index]['title'],
                    name: playlist[index]['name'],
                  ),
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SongPreviewScreen(),
                ),
              );
            },
            behavior: HitTestBehavior.opaque,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  const Blur(
                    blur: 10,
                    blurColor: AppColors.white,
                    colorOpacity: 0.2,
                    child: SizedBox(height: 59, width: double.infinity),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 11, right: 8, left: 8),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            widget.image,
                            height: 40,
                            width: 40,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
                                style: AppStyles.magistral14w500.copyWith(color: AppColors.white),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                widget.title,
                                style: AppStyles.magistral12w400.copyWith(color: AppColors.white.withOpacity(0.5)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        SvgPicture.asset(
                          AppSvg.playMini,
                          height: 30,
                          width: 30,
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    height: 3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    height: 3,
                    width: MediaQuery.of(context).size.width * percent,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

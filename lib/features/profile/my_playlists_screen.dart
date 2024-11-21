import 'package:dauys_remote/core/constants/app_icons.dart';
import 'package:dauys_remote/core/constants/app_svg.dart';
import 'package:dauys_remote/core/helpers/song_extension.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/add_button.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/auth/widget/auth_top_panel.dart';
import 'package:dauys_remote/features/main/main_screen.dart';
import 'package:dauys_remote/features/main/playlist_screen.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyPlaylistsScreen extends StatefulWidget {
  const MyPlaylistsScreen({
    super.key,
  });

  @override
  State<MyPlaylistsScreen> createState() => _MyPlaylistsScreenState();
}

class _MyPlaylistsScreenState extends State<MyPlaylistsScreen> {
  List<Map<String, dynamic>> myPlaylists = [
    {
      'title': 'Избранное',
      'songs': 12,
      'type': 'svg',
      'icon': AppSvg.star,
      'colors': const [
        Color(0xFF584BE9),
        Color(0xFFAAA4F4),
        Color(0xFFFFFFFF),
      ],
    },
    {
      'title': 'История',
      'songs': 13,
      'type': 'image',
      'icon': AppIcons.history,
      'colors': const [
        Color(0xFF4BE99D),
        Color(0xFFA4E5F4),
        Color(0xFFFFFFFF),
      ],
    },
    {
      'title': 'Ваши оценки',
      'songs': 14,
      'type': 'image',
      'icon': AppIcons.heart,
      'colors': const [
        Color(0xFF4BE96E),
        Color(0xFFA4F4C4),
        Color(0xFFFFFFFF),
      ],
    },
  ];

  Widget _title(String title) => Text(
        title,
        style: AppStyles.magistral20w500.copyWith(color: AppColors.white),
      );

  openPlaylist(Map<String, dynamic> item, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaylistScreen(
          title: item['title'],
          image: item['image'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeAreaTop: false,
      disableBackgroundColorSpots: true,
      body: Column(
        children: [
          const TopSpacer(),
          AuthTopPanel(
            title: 'Мои плейлисты',
            action: AddButton(
              onTap: () {},
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(left: 16, top: 50, bottom: 50),
              children: [
                _title('Ваши плейлисты'),
                const SizedBox(height: 10),
                SizedBox(
                  height: 165,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: myPlaylists.length,
                    itemBuilder: (context, index) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => openPlaylist(myPlaylists[index], context),
                      child: SizedBox(
                        height: 165,
                        width: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: myPlaylists[index]['colors'],
                                ),
                              ),
                              alignment: Alignment.center,
                              child: myPlaylists[index]['type'] == 'svg'
                                  ? SvgPicture.asset(
                                      myPlaylists[index]['icon'],
                                      height: 60,
                                      width: 60,
                                      color: AppColors.white,
                                    )
                                  : Image.asset(
                                      myPlaylists[index]['icon'],
                                      height: 60,
                                      width: 60,
                                      color: AppColors.white,
                                    ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              myPlaylists[index]['title'],
                              style: AppStyles.magistral14w700.copyWith(color: Colors.white),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              (myPlaylists[index]['songs'] as int).toSongString(),
                              style: AppStyles.magistral12w400.copyWith(color: Colors.white.withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                  ),
                ),
                const SizedBox(height: 30),
                _title('Ваши альбомы'),
                const SizedBox(height: 10),
                SizedBox(
                  height: 165,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: recommendation.length,
                    itemBuilder: (context, index) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => openPlaylist(recommendation[index], context),
                      child: SizedBox(
                        height: 165,
                        width: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset(
                                recommendation[index]['image'],
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              recommendation[index]['title'],
                              style: AppStyles.magistral14w700.copyWith(color: Colors.white),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              (recommendation[index]['songs'] as int).toSongString(),
                              style: AppStyles.magistral12w400.copyWith(color: Colors.white.withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                  ),
                ),
                const SizedBox(height: 30),
                _title('Рекомендуем'),
                const SizedBox(height: 10),
                SizedBox(
                  height: 165,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: recommendation.length,
                    itemBuilder: (context, index) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => openPlaylist(recommendation[index], context),
                      child: SizedBox(
                        height: 165,
                        width: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset(
                                recommendation[index]['image'],
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              recommendation[index]['title'],
                              style: AppStyles.magistral14w700.copyWith(color: Colors.white),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              (recommendation[index]['songs'] as int).toSongString(),
                              style: AppStyles.magistral12w400.copyWith(color: Colors.white.withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
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

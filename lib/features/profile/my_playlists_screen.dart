import 'dart:ffi';

import 'package:dauys_remote/api/api.dart';
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
import 'package:dauys_remote/features/profile/favorites_screen.dart';
import 'package:dauys_remote/features/profile/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/helpers/ImageAWS.dart';
import '../../models/collection.dart';
import '../../models/search_results.dart';
import '../../models/user_collection.dart';
import '../main/new_playlist_screen.dart';
import '../main/playlist_screen_new.dart';
import '../main/user_playlist_screen_new.dart';
import 'evaluated_screen.dart';

class MyPlaylistsScreen extends StatefulWidget {
  const MyPlaylistsScreen({
    super.key,
  });

  @override
  State<MyPlaylistsScreen> createState() => _MyPlaylistsScreenState();
}

class _MyPlaylistsScreenState extends State<MyPlaylistsScreen> {
  int favSongsCount = 0;
  String favSongTitle = 'Избранное';
  String favSongType = 'svg';
  String favSongIcon = AppSvg.star;
  List<Color> favSonColors = const [
    Color(0xFF584BE9),
    Color(0xFFAAA4F4),
    Color(0xFFFFFFFF),
  ];

  int historySongsCount = 0;
  String historySongTitle = 'История';
  String historySongType = 'image';
  String historySongIcon = AppIcons.history;
  List<Color> historySonColors = const [
    Color(0xFF4BE99D),
    Color(0xFFA4E5F4),
    Color(0xFFFFFFFF),
  ];

  int evaluatedSongsCount = 0;
  String evaluatedSongTitle = 'Ваши оценки';
  String evaluatedSongType = 'image';
  String evaluatedSongIcon = AppIcons.heart;
  List<Color> evaluatedSonColors = const [
    Color(0xFF4BE96E),
    Color(0xFFA4F4C4),
    Color(0xFFFFFFFF),
  ];

  List<Collection> _collections = [];
  List<UserCollection> _userCollections = [];
  bool _fetchingRecommended = true;
  bool _fetchingUserCollections = true;

  Widget _title(String title) => Text(
        title,
        style: AppStyles.magistral20w500.copyWith(color: AppColors.white),
      );

  openPlaylist(Collection collection, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaylistScreenNew(
          collection: collection,
        ),
      ),
    );
  }

  openUserPlaylist(UserCollection collection, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserPlaylistScreenNew(
          collection: collection,
        ),
      ),
    );
  }

  @override
  void initState() {
    Api.create().then((api){
      api.getFavourites().then((fav){
       var songs = SearchResults.fromJson(fav);
       setState(() {
         favSongsCount = songs.searchCount;
       });
      });


      api.getHistory().then((fav){
        var songs = SearchResults.fromJson(fav);
        setState(() {
          historySongsCount = songs.searchCount;
        });
      });


      api.getEvaluated().then((fav){
        var songs = SearchResults.fromJson(fav);
        setState(() {
          evaluatedSongsCount = songs.searchCount;
        });
      });


      api.getAllCollections().then((collections) {
        setState(() {
          _fetchingRecommended = false;
          _collections = collections;
        });
      });


      api.getAllUserCollections().then((userCollections) {
        setState(() {
          _fetchingUserCollections = false;
          _userCollections = userCollections;
        });
      });
    });
    super.initState();
  }


  String truncateText(String text, {int length = 11}) {
    if (text.length > length) {
      return '${text.substring(0, length)}...';
    } else {
      return text;
    }
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewPlaylistScreen()),
                );
              },
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(left: 16, top: 50, bottom: 50),
              children: [
                _title('Ваши плейлисты'),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                        height: 165,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FavoritesScreen(),
                              ),
                            )
                          },
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
                                      colors: favSonColors,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(
                                    favSongIcon,
                                    height: 60,
                                    width: 60,
                                    color: AppColors.white,
                                  )
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  favSongTitle,
                                  style: AppStyles.magistral14w700.copyWith(color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  favSongsCount.toSongString(),
                                  style: AppStyles.magistral12w400.copyWith(color: Colors.white.withOpacity(0.5)),
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                        height: 165,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HistoryScreen(),
                              ),
                            )
                          },
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
                                      colors: historySonColors,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child:  Image.asset(
                                    historySongIcon,
                                    height: 60,
                                    width: 60,
                                    color: AppColors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  historySongTitle,
                                  style: AppStyles.magistral14w700.copyWith(color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  historySongsCount.toSongString(),
                                  style: AppStyles.magistral12w400.copyWith(color: Colors.white.withOpacity(0.5)),
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                        height: 165,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EvaluatedScreen(),
                              ),
                            )
                          },
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
                                      colors: evaluatedSonColors,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child:  Image.asset(
                                    evaluatedSongIcon,
                                    height: 60,
                                    width: 60,
                                    color: AppColors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  evaluatedSongTitle,
                                  style: AppStyles.magistral14w700.copyWith(color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  evaluatedSongsCount.toSongString(),
                                  style: AppStyles.magistral12w400.copyWith(color: Colors.white.withOpacity(0.5)),
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                _title('Ваши альбомы'),
                const SizedBox(height: 10),
                _fetchingUserCollections
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    :  SizedBox(
                  height: 165,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _userCollections.length,
                    itemBuilder: (context, index) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => openUserPlaylist(_userCollections[index], context),//openPlaylist(recommendation[index], context),
                      child: SizedBox(
                        height: 165,
                        width: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child:  Image.network(
                                ImageAWS.getImageURI(
                                    _userCollections[index].playlistSongsCount == 0
                                    ? null
                                    : _userCollections[index].songs[0]?.songImageUri ?? '',
                                  text: _userCollections[index].playListName
                                ),
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              truncateText(_userCollections[index].playListName),
                              style: AppStyles.magistral14w700.copyWith(color: Colors.white),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              (_userCollections[index].playlistSongsCount).toSongString(),
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
                _fetchingRecommended
                ? const Center(
                  child: CircularProgressIndicator(),
                )
                : SizedBox(
                  height: 180,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _collections.length,
                    itemBuilder: (context, index) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => openPlaylist(_collections[index], context),
                      child: SizedBox(
                        height: 170,
                        width: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                ImageAWS.getImageURI(_collections[index].collectionImageAwsUuid),
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              truncateText(_collections[index].name),
                              style: AppStyles.magistral14w700.copyWith(color: Colors.white),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _collections[index].songsCount.toSongString(),
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

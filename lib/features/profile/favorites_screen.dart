import 'package:dauys_remote/core/helpers/song_extension.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:flutter/material.dart';

import '../../api/api.dart';
import '../../core/helpers/ImageAWS.dart';
import '../../models/search_results.dart';
import '../main/widget/playlist_item_new.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({
    super.key,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  SearchResults songs = SearchResults.fromJson({'searchCount': 0, 'songs': []});
  bool isSearching = true;

  @override
  void initState() {
    Api.create().then((Api a){
      a.getFavourites().then((res){
        setState(() {
          songs = SearchResults.fromJson(res);
          isSearching = false;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeAreaTop: false,
      disableBackgroundColorSpots: true,
      body: Column(
        children: [
          Container(
            height: 192,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.backgroundButtonGradient3.withOpacity(0.6),
                  AppColors.backgroundButtonGradient3.withOpacity(0),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopSpacer(),
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
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'Избранное',
                    style: AppStyles.magistral30w700.copyWith(color: AppColors.white),
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    isSearching? '... песен' : songs.searchCount.toSongString(),
                    style: AppStyles.magistral16w400.copyWith(color: AppColors.white.withOpacity(0.6)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          if(songs.searchCount == 0) ...[
            isSearching ?
            const SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            )
                : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                                'Пока в избранном ничего нет. \nПопробуйте добавить песни, и они появятся на этом экране!',
                                style: AppStyles.magistral16w400.copyWith(
                    color: AppColors.white.withOpacity(0.6)),
                              ),
                ),
          ] else ...[
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: songs.searchCount,
                itemBuilder: (context, index) => PlaylistItemNew(
                  image: ImageAWS.getImageURI(songs.songs[index].songImageUri),
                  title: songs.songs[index].album,
                  name: songs.songs[index].name,
                  songID: songs.songs[index].id,
                  showAddToFavorite: true,
                  isInFavourites: songs.songs[index].isInUserFavorites,
                ),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

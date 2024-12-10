
import 'package:dauys_remote/api/api.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/main/song_preview_screen_new.dart';
import 'package:dauys_remote/features/main/widget/playlist_item_new.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:dauys_remote/features/profile/my_playlists_screen.dart';
import 'package:dauys_remote/models/collection.dart';
import 'package:dauys_remote/models/user_collection.dart';
import 'package:flutter/material.dart';

import '../../core/helpers/ImageAWS.dart';
import '../../core/widget/add_button.dart';
import '../gateway/gateway_screen.dart';
import '../search/search_add_screen.dart';


class UserPlaylistScreenNew extends StatefulWidget {
  const UserPlaylistScreenNew({
    super.key,
    required this.collection,
  });

  final UserCollection collection;

  @override
  State<UserPlaylistScreenNew> createState() => _UserPlaylistScreenNewState();
}

class _UserPlaylistScreenNewState extends State<UserPlaylistScreenNew> {
  final double percent = 0.2;

  @override
  Widget build(BuildContext context) {
    UserCollection userCollection = widget.collection;

    Future<void> _showMyDialog(int index, BuildContext context) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Удаление песни'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Вы точно хотите удалить песню из плейлиста?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Да'),
                onPressed: () {
                  Api.create().then((api){
                    api.removeSongFromPlaylist(
                        userCollection.songs[index]?.id ?? 0,
                        userCollection.id
                    ).then((res){
                      if(res == true){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Песня удалена из плейлиста')),
                        );
                      };
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const GateWayScreen(index: 2)),
                      );
                    });
                  });
                },
              ),
              TextButton(
                child: const Text('Нет'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

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
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const GateWayScreen(index: 2)),
                          ),
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            height: 32,
                            width: 32,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.chevron_left,
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
                                child: Image.network(
                                  ImageAWS.getImageURI(
                                      userCollection.playlistSongsCount == 0
                                          ? null
                                          : userCollection.songs[0]?.songImageUri ?? '',
                                      text: userCollection.playListName
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 22),
                        AddButton(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchAddScreen(playlistId: userCollection.id,)));
                          },
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                truncateText(userCollection.playListName), // Truncated title
                style: AppStyles.magistral30w700.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
                  shrinkWrap: true,
                  itemCount: userCollection.playlistSongsCount,
                  itemBuilder: (context, index) => PlaylistItemNew(
                    image: ImageAWS.getImageURI(userCollection.songs[index]?.songImageUri),
                    title: userCollection.songs[index]?.genre ?? '',
                    name: userCollection.songs[index]?.name ?? '',
                    songID: userCollection.songs[index]?.id ?? 0,
                    isInFavourites: userCollection.songs[index]?.isInUserFavorites ?? false,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SongPreviewScreenNew(
                              songID: (userCollection.songs[index]?.id ?? '').toString(),
                          ),
                        ),
                      );
                    },
                    onLongTap: () async {
                      await _showMyDialog(index, context);

                      print('long tap');
                    },
                  ),
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const SongPreviewScreenNew(songID: '1',),
          //       ),
          //     );
          //   },
          //   behavior: HitTestBehavior.opaque,
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(5),
          //     child: Stack(
          //       alignment: Alignment.bottomLeft,
          //       children: [
          //         const Blur(
          //           blur: 10,
          //           blurColor: AppColors.white,
          //           colorOpacity: 0.2,
          //           child: SizedBox(height: 59, width: double.infinity),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(top: 8, bottom: 11, right: 8, left: 8),
          //           child: Row(
          //             children: [
          //               ClipRRect(
          //                 borderRadius: BorderRadius.circular(5),
          //                 child: Image.network(
          //                   ImageAWS.getImageURI(widget.collection.collectionImageAwsUuid),
          //                   fit: BoxFit.cover,
          //                   height: 40,
          //                   width: 40,
          //                 ),
          //               ),
          //               const SizedBox(width: 10),
          //               Expanded(
          //                 child: Column(
          //                   mainAxisSize: MainAxisSize.min,
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text(
          //                       truncateText(widget.collection.name),
          //                       style: AppStyles.magistral14w500.copyWith(color: AppColors.white),
          //                     ),
          //                     const SizedBox(height: 3),
          //                     Text(
          //                       truncateText(widget.collection.songsCount.toString()),
          //                       style: AppStyles.magistral12w400.copyWith(color: AppColors.white.withOpacity(0.5)),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //               const SizedBox(width: 10),
          //               SvgPicture.asset(
          //                 AppSvg.playMini,
          //                 height: 30,
          //                 width: 30,
          //               ),
          //               const SizedBox(width: 20),
          //             ],
          //           ),
          //         ),
          //         Container(
          //           margin: const EdgeInsets.symmetric(horizontal: 8),
          //           height: 3,
          //           width: double.infinity,
          //           decoration: BoxDecoration(
          //             color: AppColors.white.withOpacity(0.2),
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //         ),
          //         Container(
          //           margin: const EdgeInsets.symmetric(horizontal: 8),
          //           height: 3,
          //           width: MediaQuery.of(context).size.width * percent,
          //           decoration: BoxDecoration(
          //             color: AppColors.white,
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  String truncateText(String text, {int length = 20}) {
    if (text.length > length) {
      return '${text.substring(0, length)}...';
    } else {
      return text;
    }
  }

}

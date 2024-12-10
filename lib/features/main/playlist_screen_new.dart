
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/main/song_preview_screen_new.dart';
import 'package:dauys_remote/features/main/widget/playlist_item_new.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:dauys_remote/models/collection.dart';
import 'package:flutter/material.dart';

import '../../core/helpers/ImageAWS.dart';
import '../gateway/gateway_screen.dart';


class PlaylistScreenNew extends StatefulWidget {
  const PlaylistScreenNew({
    super.key,
    required this.collection,
  });

  final Collection collection;

  @override
  State<PlaylistScreenNew> createState() => _PlaylistScreenNewState();
}

class _PlaylistScreenNewState extends State<PlaylistScreenNew> {
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
                                  ImageAWS.getImageURI(widget.collection.collectionImageAwsUuid),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 22),
                        // AddButton(
                        //   onTap: () {},
                        // ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                truncateText(widget.collection.name), // Truncated title
                style: AppStyles.magistral30w700.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
                  shrinkWrap: true,
                  itemCount: widget.collection.songsCount,
                  itemBuilder: (context, index) => PlaylistItemNew(
                    image: ImageAWS.getImageURI(widget.collection.songs[index].songImageUri),
                    title: widget.collection.songs[index].genre,
                    name: widget.collection.songs[index].name,
                    songID: widget.collection.songs[index].id,
                    isInFavourites: widget.collection.songs[index].isInUserFavorites,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SongPreviewScreenNew(
                              songID: widget.collection.songs[index].id.toString(),
                          ),
                        ),
                      );
                    },
                  ),
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
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

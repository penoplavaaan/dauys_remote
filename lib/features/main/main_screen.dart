import 'package:dauys_remote/core/constants/app_tmp_image.dart';
import 'package:dauys_remote/core/helpers/song_extension.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_avatar.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/main/playlist_screen_new.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../api/api.dart';
import '../../core/constants/app_image.dart';
import '../../core/helpers/ImageAWS.dart';
import '../../models/collection.dart';

part 'main_screen_data.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<List<Collection>> _collections;

  @override
  void initState() {
    super.initState();
    _collections = Api.create().then((api) => api.getAllCollections());
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width for responsive layout
    final screenWidth = MediaQuery.of(context).size.width;

    return AppScaffold(
      safeAreaTop: false,
      body: ListView(
        padding: const EdgeInsets.only(left: 16),
        children: [
          const TopSpacer(),
          // Avatar row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AppAvatar(asset: AppImage.icon, size: 46),
              const SizedBox(width: 16),
              Text(
                'Dauys',
                style: AppStyles.magistral20w500.copyWith(color: AppColors.white),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            FlutterI18n.translate(context, "daily_recommendations"),
            style: AppStyles.magistral20w500.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7, // Adjust the height to the screen height
            child: FutureBuilder<List<Collection>>(
              future: _collections,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No Collections Available'));
                } else {
                  List<Collection> collections = snapshot.data!;
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 3 items per row
                    ),
                    itemCount: collections.length,
                    itemBuilder: (context, index) {
                      Collection collection = collections[index];
                      return GestureDetector(
                        onTap: () {
                          openPlaylist(collection, context);
                        },
                        child: SizedBox(
                          height: screenWidth * 0.5,
                          width: screenWidth * 0.5, // Adjust width to 30% of screen width
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  ImageAWS.getImageURI(collection.collectionImageAwsUuid),
                                  height: screenWidth * 0.35,
                                  width: screenWidth * 0.35,  // Image will fill width of the container
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                truncateText(collection.name),
                                style: AppStyles.magistral14w700.copyWith(color: Colors.white),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                (collection.songsCount).toSongString(context),
                                style: AppStyles.magistral12w400.copyWith(color: Colors.white.withOpacity(0.5)),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Open Playlist screen (you can add more logic for navigation if needed)
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

  String truncateText(String text, {int length = 11}) {
    if (text.length > length) {
      return '${text.substring(0, length)}...';
    } else {
      return text;
    }
  }
}

import 'dart:async';

import 'package:dauys_remote/api/api.dart';
import 'package:dauys_remote/core/constants/app_icons.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:dauys_remote/features/search/search_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../core/helpers/ImageAWS.dart';
import '../../core/widget/app_button.dart';
import '../../models/search_results.dart';
import '../../storage/local_storage.dart';
import '../gateway/gateway_screen.dart';
import '../main/widget/playlist_item_new.dart';

class SearchAddScreen extends StatefulWidget {
  const SearchAddScreen({
    super.key,
    required this.playlistId,
  });

  final int playlistId;

  @override
  State<SearchAddScreen> createState() => _SearchAddScreenState();
}

class _SearchAddScreenState extends State<SearchAddScreen> {
  final controller = TextEditingController();
  final localStorage = LocalStorage();
  SearchResults songs = SearchResults.fromJson({'searchCount': 0, 'songs': []});
  bool searching = false;
  
  bool showHistory = true;
  Timer? _debounce;

  updateSearchFromHistory(String historySearch){
    setState(() {
      controller.text = historySearch;
    });
    _onSearchChanged(historySearch);
  }

  _cleartext(){
    controller.clear();
    setState(() {
      searching = false;
      songs = SearchResults.fromJson({'searchCount': 0, 'songs': []});
    });
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    if(query.length < 3) {
      _debounce?.cancel();
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 800), () async {
      localStorage.saveSearchQuery(query);

      Api api = await Api.create();
      setState(() {
        searching = true;
        songs = SearchResults.fromJson({'searchCount': 0, 'songs': []});
      });

      songs = SearchResults.fromJson(await api.fullTextSearch(query));

      setState(() {
        searching = false;
        songs = songs;
      });
    });
  }

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        showHistory = controller.text.isEmpty;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeAreaTop: false,
      body: ListView(
        children: [
          const TopSpacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              onChanged: _onSearchChanged,
              controller: controller,
              style: AppStyles.magistral16w500.copyWith(color: AppColors.white),
              cursorColor: AppColors.white.withOpacity(0.5),
              cursorErrorColor: AppColors.white.withOpacity(0.5),
              decoration: InputDecoration(
                constraints: const BoxConstraints(maxHeight: 44, maxWidth: double.infinity, minHeight: 44),
                hintText: FlutterI18n.translate(context, "search.hint"), // заменено
                hintStyle: AppStyles.magistral16w500.copyWith(color: AppColors.white.withOpacity(0.5)),
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                filled: true,
                fillColor: AppColors.white.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 12),
                  child: Image.asset(
                    AppIcons.search,
                    height: 20,
                    width: 20,
                    color: AppColors.white,
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(maxHeight: 20, maxWidth: 52, minWidth: 52),
                errorStyle: AppStyles.magistral16w500.copyWith(color: AppColors.white.withOpacity(0.5)),
                errorMaxLines: 10,
                  suffixIcon: IconButton(
                    onPressed: _cleartext,
                    icon: const Icon(Icons.clear,color: AppColors.white),
                  )
              ),
            ),
          ),
          const SizedBox(height: 30),
          if (showHistory) ...[
            SearchHistory(callback: updateSearchFromHistory,)
          ]
          else if (songs.searchCount == 0) ...[
            searching ?  const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Center(child: CircularProgressIndicator(),),
            )
            : Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                FlutterI18n.translate(context, "search.no_results"), // заменено
                style: AppStyles.magistral16w500.copyWith(
                    color: AppColors.white.withOpacity(0.5),
                ),
              ),
            )
          ]
          else ...[
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
                  shrinkWrap: true,
                  itemCount: songs.searchCount,
                  itemBuilder: (context, index) => PlaylistItemNew(
                    image: ImageAWS.getImageURI(songs.songs[index].songImageUri),
                    title: songs.songs[index].name,
                    name:  songs.songs[index].album,
                    songID: songs.songs[index].id,
                    showAddToFavorite: false,
                    onTap: () {
                      Api.create().then((api){
                        api.addSongToPlaylist(
                          widget.playlistId,
                          songs.songs[index].id
                        ).then((res){
                          if(res == true){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Песня добавлена в плейлист!')),
                            );
                          }
                        });
                      });
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => SongPreviewScreenNew(
                      //         songID: songs.songs[index].id.toString(),
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                ),
              )
            ],
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: AppButton(
                title: FlutterI18n.translate(context, "search.ready"),
                width: 130,
                onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const GateWayScreen(index: 2,)),
                      (Route<dynamic> route) => false,
                )
            ),
          )
        ],
      ),
    );
  }
}

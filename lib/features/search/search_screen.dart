import 'package:dauys_remote/core/constants/app_icons.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/main/playlist_screen.dart';
import 'package:dauys_remote/features/main/widget/playlist_item.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:dauys_remote/features/search/search_history.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();

  bool showHistory = true;

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
              controller: controller,
              style: AppStyles.magistral16w500.copyWith(color: AppColors.white),
              cursorColor: AppColors.white.withOpacity(0.5),
              cursorErrorColor: AppColors.white.withOpacity(0.5),
              decoration: InputDecoration(
                constraints: const BoxConstraints(maxHeight: 44, maxWidth: double.infinity, minHeight: 44),
                hintText: 'Какую песню ищете?',
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
              ),
            ),
          ),
          const SizedBox(height: 30),
          showHistory
              ? const SearchHistory()
              : Expanded(
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
        ],
      ),
    );
  }
}

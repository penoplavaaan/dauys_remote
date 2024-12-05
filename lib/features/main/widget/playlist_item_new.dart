import 'package:dauys_remote/core/constants/app_svg.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/gradient_overlay.dart';
import 'package:dauys_remote/features/main/sing_screen.dart';
import 'package:dauys_remote/features/main/widget/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../api/api.dart';

class PlaylistItemNew extends StatefulWidget {
  const PlaylistItemNew({
    super.key,
    required this.image,
    required this.title,
    required this.name,
    required this.songID,
    this.isInFavourites = false,
    this.showAddToFavorite = true,
    this.onTap,
    this.showSingButton = false,
  });

  final String image;
  final String title;
  final String name;
  final int songID;
  final bool showAddToFavorite;
  final VoidCallback? onTap; // This is the onTap callback type
  final bool showSingButton;
  final bool isInFavourites;

  @override
  State<PlaylistItemNew> createState() => _PlaylistItemNewState();
}

class _PlaylistItemNewState extends State<PlaylistItemNew> {
  late bool isInFavourites;
  Api? api;

  @override
  void initState() {
    super.initState();
    Api.create().then((Api a){
      api = a;
    });
    isInFavourites = widget.isInFavourites;
  }

  void toggleFavorite() {
    bool newFavVal = !isInFavourites;

    if(api is Api){
      api?.toggleFavourites(widget.songID, newFavVal);
    }
    setState(() {
      isInFavourites = !isInFavourites;
    });
  }

  @override
  Widget build(BuildContext context) {
    final starInFav = GradientOverlay(
      child: GestureDetector(
        onTap: toggleFavorite,
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(width: 1, color: AppColors.white),
          ),
          alignment: Alignment.center,
          child: GradientOverlay(
            child: SvgPicture.asset(
              AppSvg.star,
              height: 20,
              width: 20,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
    final starNotFav = GestureDetector(
      onTap: toggleFavorite,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(width: 1, color: AppColors.white),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          AppSvg.star,
          height: 20,
          width: 20,
          color: AppColors.white,
        ),
      ),
    );

    return GestureDetector( // Wrap the entire Row with GestureDetector
      onTap: widget.onTap, // When tapped, trigger the onTap callback if provided
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  widget.image,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              SvgPicture.asset(
                AppSvg.playOverlay,
                height: 20,
                width: 20,
              ),
            ],
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
                  widget.name,
                  style: AppStyles.magistral12w400.copyWith(color: AppColors.white.withOpacity(0.5)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          if(widget.showSingButton) ...[
            GradientButton(
              title: 'Спеть',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SingScreen(),
                  ),
                );
              },
            ),
          ],
          if (widget.showAddToFavorite) ...[
            const SizedBox(width: 4),
            isInFavourites
                ? starInFav
                : starNotFav,
          ],
        ],
      ),
    );
  }
}


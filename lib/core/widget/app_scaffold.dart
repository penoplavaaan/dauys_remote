import 'package:dauys_remote/core/constants/app_image.dart';
import 'package:dauys_remote/core/theme/app_gradients.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.disableBackgroundColorSpots = false,
    this.safeAreaTop = true,
  });

  final Widget body;

  final bool disableBackgroundColorSpots;
  final bool safeAreaTop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppGradients.darkGradientVertical,
            ),
          ),
          if (!disableBackgroundColorSpots) ...[
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(AppImage.backgroundTopRight),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(AppImage.backgroundBottomLeft),
            ),
          ],
          SafeArea(
            top: safeAreaTop,
            bottom: false,
            child: body,
          ),
        ],
      ),
    );
  }
}

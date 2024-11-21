import 'package:dauys_remote/core/theme/app_gradients.dart';
import 'package:flutter/material.dart';

class GradientOverlay extends StatelessWidget {
  const GradientOverlay({
    super.key,
    required this.child,
    this.gradient,
  });

  final Widget child;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          (gradient ?? AppGradients.buttonRainbow).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: child,
    );
  }
}

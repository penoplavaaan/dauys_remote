import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    required this.asset,
    required this.size,
  });

  final String asset;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size,
        maxWidth: size,
        minHeight: size,
        minWidth: size,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size),
        child: Image.asset(
          asset,
          height: size,
          width: size,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

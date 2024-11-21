import 'dart:math';

import 'package:flutter/material.dart';

class TopSpacer extends StatelessWidget {
  const TopSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: max(MediaQuery.of(context).padding.top, 40));
  }
}

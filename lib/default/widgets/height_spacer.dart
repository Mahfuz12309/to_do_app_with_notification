import 'package:flutter/material.dart';

class HeightSpacer extends StatelessWidget {
  const HeightSpacer({super.key, required this.hight});
  final double hight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hight,
    );
  }
}

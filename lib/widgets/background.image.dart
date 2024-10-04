import 'package:flutter/material.dart';
import '../common/app.config.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              kPrimaryColor,
              BlendMode.srcOver,
            ),
          ),
        ),
      ),
    );
  }
}
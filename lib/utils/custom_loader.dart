import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoader extends StatelessWidget {
  final double size;

  const CustomLoader({super.key, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.flickr(
        leftDotColor: const Color(0xff68C71E),
        rightDotColor: const Color(0xFFFF006E), // Use your buttonColor here
        size: size,
      ),
    );
  }
}

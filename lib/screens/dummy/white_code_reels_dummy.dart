import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:whitecodel_reels/whitecodel_reels.dart';



class WhiteCodeReelsDummy extends StatefulWidget {
  const WhiteCodeReelsDummy({super.key});

  @override
  State<WhiteCodeReelsDummy> createState() => _WhiteCodeReelsDummyState();
}

class _WhiteCodeReelsDummyState extends State<WhiteCodeReelsDummy> with WidgetsBindingObserver {
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _videoPlayerController?.pause(); // Pause the video before disposing
    _videoPlayerController?.dispose(); // Dispose of the controller
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      _videoPlayerController?.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WhiteCodelReels(
        key: UniqueKey(),
        context: context,
        loader: const Center(
          child: CircularProgressIndicator(),
        ),
        videoList: List.generate(
          10,
              (index) => 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        ),
        isCaching: true,
        builder: (context, index, child, videoPlayerController, pageController) {
          _videoPlayerController = videoPlayerController; // Store the controller

          return Stack(
            children: [
              child,
              Positioned(
                bottom: 20,
                right: 10,
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {
                        // Like button logic
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () {
                        // Comment button logic
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                        // Share button logic
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}




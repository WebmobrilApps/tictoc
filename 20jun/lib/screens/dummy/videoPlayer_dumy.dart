import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final List<String> videosURL = [
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
    "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4",
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
    "https://sample-videos.com/video321/mp4/480/big_buck_bunny_480p_2mb.mp4",
  ];

  late PageController _pageController;
  late List<ChewieController> _chewieControllers;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _chewieControllers = List.generate(videosURL.length, (index) {
      return ChewieController(
        videoPlayerController: VideoPlayerController.network(videosURL[index]),
        autoPlay: true,
        looping: true,
        allowFullScreen: true,
        showControls: true,
      );
    });
  }

  @override
  void dispose() {
    _chewieControllers.forEach((controller) {
      controller.dispose();
    });
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! < 0) {
            // Swipe up to go to next video
            if (_pageController.page!.toInt() < videosURL.length - 1) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          } else if (details.primaryDelta! > 0) {
            // Swipe down to go to previous video
            if (_pageController.page!.toInt() > 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          }
        },
        child: PageView.builder(
          controller: _pageController,
          itemCount: videosURL.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            // Return Chewie player with video controller for current index
            return Stack(
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: 9 / 16,
                    child: Chewie(
                      controller: _chewieControllers[index],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 30,
                  child: IconButton(
                    icon: Icon(
                      Icons.pause,
                      color: Colors.white,
                      size: 50,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_chewieControllers[index].isPlaying) {
                          _chewieControllers[index].pause();
                        } else {
                          _chewieControllers[index].play();
                        }
                      });
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

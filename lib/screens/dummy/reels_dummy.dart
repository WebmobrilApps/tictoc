import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ReelsScreen extends StatefulWidget {
  final List<String> videoUrls; // Pass video URLs list

  const ReelsScreen({Key? key, required this.videoUrls}) : super(key: key);

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final PageController _pageController = PageController();
  final List<VideoPlayerController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _initializeVideos();
  }

  void _initializeVideos() {
    for (var url in widget.videoUrls) {
      final controller = VideoPlayerController.network(url)
        ..initialize().then((_) {
          setState(() {}); // Update UI after initialization
        });
      _controllers.add(controller);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose(); // Dispose all controllers
    }
    _pageController.dispose();
    super.dispose();
  }

  void _pauseAllVideos() {
    for (var controller in _controllers) {
      if (controller.value.isPlaying) {
        controller.pause();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _controllers.length,
        onPageChanged: (index) {
          _pauseAllVideos(); // Pause all videos before playing new one
          if (_controllers[index].value.isInitialized) {
            _controllers[index].play();
          }
        },
        itemBuilder: (context, index) {
          return VisibilityDetector(
            key: Key('video_$index'),
            onVisibilityChanged: (info) {
              if (info.visibleFraction == 0) {
                _controllers[index].pause(); // Pause if video is out of view
              } else if (_controllers[index].value.isInitialized) {
                _controllers[index].play(); // Play if video is in view
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                _controllers[index].value.isInitialized
                    ? AspectRatio(
                  aspectRatio: _controllers[index].value.aspectRatio,
                  child: VideoPlayer(_controllers[index]),
                )
                    : const Center(child: CircularProgressIndicator()),

                // Play/Pause on tap
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_controllers[index].value.isPlaying) {
                          _controllers[index].pause();
                        } else {
                          _controllers[index].play();
                        }
                      });
                    },
                  ),
                ),

                // Video Controls
                Positioned(
                  bottom: 20,
                  right: 15,
                  child: Column(
                    children: [
                      Icon(Icons.favorite, color: Colors.white, size: 30),
                      SizedBox(height: 15),
                      Icon(Icons.comment, color: Colors.white, size: 30),
                      SizedBox(height: 15),
                      Icon(Icons.share, color: Colors.white, size: 30),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

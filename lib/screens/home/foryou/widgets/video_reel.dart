
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tictoc/screens/home/foryou/widgets/reels_bottom_details.dart';
import 'package:tictoc/screens/home/foryou/widgets/reels_side_icons.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';


class VideoReel extends StatefulWidget {
  final String videoUrl;
  const VideoReel({super.key, required this.videoUrl});

  @override
  State<VideoReel> createState() => _VideoReelState();
}

class _VideoReelState extends State<VideoReel> {
  late FlickManager flickManager;
  bool isPlaying = false;  // Track play/pause state
  bool isVisible = false;  // Track visibility of the video

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
        ..initialize().then((_) {
          if (mounted) {
            setState(() {}); // Ensure the UI updates when initialization completes
          }
        }),
    );
  }

  @override
  void dispose() {
    if (flickManager.flickVideoManager?.videoPlayerController?.value.isInitialized == false) {
      flickManager.flickVideoManager?.videoPlayerController?.pause();
      flickManager.flickVideoManager?.videoPlayerController?.dispose();
    }
    flickManager.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.videoUrl),
      onVisibilityChanged: (VisibilityInfo info) {
        isVisible = info.visibleFraction > 0;

        if (isVisible) {
          if (!isPlaying) {
            flickManager.flickControlManager?.play();
            isPlaying = true;
          }
        } else {
          if (isPlaying) {
            flickManager.flickControlManager?.pause();
            isPlaying = false;
          }
        }
      },
      child: Stack(
        children: [
          FlickVideoPlayer(
            flickManager: flickManager,
            preferredDeviceOrientation: const [
              DeviceOrientation.portraitUp,
            ],
          ),
          const ReelsSideIcons(),
          const ReelsBottomDetails(),
        ],
      ),
    );
  }
}
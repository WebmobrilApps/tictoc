import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class ChewieVideoPlayer extends StatefulWidget {
  final File? videoFile;

  const ChewieVideoPlayer({this.videoFile, Key? key}) : super(key: key);

  @override
  State<ChewieVideoPlayer> createState() => _ChewieVideoPlayerState();
}

class _ChewieVideoPlayerState extends State<ChewieVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    if (widget.videoFile != null) {
      _initializePlayer(widget.videoFile!);
    }
  }

  Future<void> _initializePlayer(File videoFile) async {
    _videoPlayerController = VideoPlayerController.file(videoFile);
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      showOptions: false, // Disable the three-dot menu
    );
    setState(() {}); // Rebuild to show the video player
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Show video player if initialized, otherwise a placeholder
        _chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized
            ? AspectRatio(
          aspectRatio: _videoPlayerController.value.aspectRatio,
       //   aspectRatio: 0.7,
          child: Chewie(controller: _chewieController!),
        )
            : const Center(child: CircularProgressIndicator()),
      ],
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}


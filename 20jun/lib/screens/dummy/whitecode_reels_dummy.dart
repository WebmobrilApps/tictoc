import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:whitecodel_reels/whitecodel_reels.dart';

List<String> videos = [
  "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4",
  "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_2mb.mp4",
  "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_5mb.mp4",
  "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_10mb.mp4",
  "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_20mb.mp4",
  "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_30mb.mp4",
  "https://sample-videos.com/video321/mp4/480/big_buck_bunny_480p_1mb.mp4",
  "https://sample-videos.com/video321/mp4/480/big_buck_bunny_480p_2mb.mp4",
  "https://sample-videos.com/video321/mp4/480/big_buck_bunny_480p_5mb.mp4",
  "https://sample-videos.com/video321/mp4/480/big_buck_bunny_480p_10mb.mp4",
  "https://sample-videos.com/video321/mp4/480/big_buck_bunny_480p_20mb.mp4",
  "https://sample-videos.com/video321/mp4/480/big_buck_bunny_480p_30mb.mp4",
  "https://sample-videos.com/video321/mp4/360/big_buck_bunny_360p_1mb.mp4",
  "https://sample-videos.com/video321/mp4/360/big_buck_bunny_360p_2mb.mp4",
  "https://sample-videos.com/video321/mp4/360/big_buck_bunny_360p_5mb.mp4",
  "https://sample-videos.com/video321/mp4/360/big_buck_bunny_360p_10mb.mp4",
  "https://sample-videos.com/video321/mp4/360/big_buck_bunny_360p_20mb.mp4",
  "https://sample-videos.com/video321/mp4/360/big_buck_bunny_360p_30mb.mp4",
  "https://sample-videos.com/video321/mp4/240/big_buck_bunny_240p_1mb.mp4",
  "https://sample-videos.com/video321/mp4/240/big_buck_bunny_240p_2mb.mp4",
  "https://sample-videos.com/video321/mp4/240/big_buck_bunny_240p_5mb.mp4",
  "https://sample-videos.com/video321/mp4/240/big_buck_bunny_240p_10mb.mp4",
  "https://sample-videos.com/video321/mp4/240/big_buck_bunny_240p_20mb.mp4",
  "https://sample-videos.com/video321/mp4/240/big_buck_bunny_240p_30mb.mp4"
];

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    // Initialize your video controller here, for example:
    _videoPlayerController = VideoPlayerController.asset('assets/video.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: WhiteCodelReels(
              key: UniqueKey(),
              context: context,
              loader: const Center(
                child: CircularProgressIndicator(),
              ),
              isCaching: false,
              videoList: List.generate(videos.length, (index) => videos[index]),
              builder: (context, index, child, videoPlayerController, pageController) {
                // Sync with the external controller
                _videoPlayerController = videoPlayerController;

                bool isReadMore = false;
                StreamController<double> videoProgressController = StreamController<double>();

                videoPlayerController.addListener(() {
                  double videoProgress = videoPlayerController.value.position.inMilliseconds /
                      videoPlayerController.value.duration.inMilliseconds;
                  videoProgressController.add(videoProgress);
                });

                return Stack(
                  children: [
                    child,
                    StreamBuilder(
                      stream: videoProgressController.stream,
                      builder: (context, snapshot) {
                        return Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbShape: SliderComponentShape.noThumb,
                              overlayShape: SliderComponentShape.noOverlay,
                              trackHeight: 2,
                            ),
                            child: Slider(
                              value: (snapshot.data ?? 0).clamp(0.0, 1.0),
                              min: 0.0,
                              max: 1.0,
                              activeColor: Colors.red,
                              inactiveColor: Colors.white,
                              onChanged: (value) {
                                final position = videoPlayerController.value.duration.inMilliseconds * value;
                                videoPlayerController.seekTo(Duration(milliseconds: position.toInt()));
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(96.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  // Toggle play/pause using the controller inside WhiteCodelReels
                  if (_videoPlayerController.value.isPlaying) {
                    _videoPlayerController.play();

                  } else {
                    _videoPlayerController.pause();
                  }
                });
              },
              child: Text(_videoPlayerController.value.isPlaying ? 'Play' : 'Pause'),
            ),
          ),
        ],
      ),
    );
  }
}



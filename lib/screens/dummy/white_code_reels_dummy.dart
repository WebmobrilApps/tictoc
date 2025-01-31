
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:video_player/video_player.dart';
import 'package:whitecodel_reels/whitecodel_reels.dart';

List<String> videos = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
  "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
  "https://sample-videos.com/video321/mp4/480/big_buck_bunny_480p_2mb.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
  "https://sample-videos.com/video321/mp4/360/big_buck_bunny_360p_30mb.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
  "https://sample-videos.com/video321/mp4/480/big_buck_bunny_480p_2mb.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
  "https://sample-videos.com/video321/mp4/360/big_buck_bunny_360p_30mb.mp4",
];


class WhiteCodeReelsDummy extends StatefulWidget {
  const WhiteCodeReelsDummy({super.key});

  @override
  State<WhiteCodeReelsDummy> createState() => _WhiteCodeReelsDummyState();
}

class _WhiteCodeReelsDummyState extends State<WhiteCodeReelsDummy>   with WidgetsBindingObserver {
  VideoPlayerController? _currentVideoController;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _currentVideoController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      _currentVideoController?.pause();
    }
    super.didChangeAppLifecycleState(state);
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
                videoList:
                List.generate(videos.length, (index) => videos[index]),
                builder: (context, index, child, videoPlayerController,
                    pageController) {
                  bool isReadMore = false;
                  StreamController<double> videoProgressController =
                  StreamController<double>();

                  videoPlayerController.addListener(() {
                    double videoProgress = videoPlayerController
                        .value.position.inMilliseconds /
                        videoPlayerController.value.duration.inMilliseconds;
                    videoProgressController.add(videoProgress);
                  });
                  _currentVideoController = videoPlayerController;
                  return Stack(
                    children: [
                      child,
                      Positioned(
                        bottom: 00,
                        left: 0,
                        right: 00, // Add right padding to avoid mingling with other widgets
                        child: Container(
                          padding: const EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.2),
                                Colors.black.withOpacity(0.5),
                              ],),),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset('assets/images/profile6.png', width: 35, height: 35),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: largeText16(
                                      context,'DisaSmith',
                                      textColor: whiteColor,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis, // Ensure truncation
                                      maxLines: 1, // Limit to one line
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Image.asset('assets/images/tick.png', width: 15, height: 15),
                                  const SizedBox(width: 6),
                                  smallText12(context,'10h ago', textColor: const Color(0xffADADAD)),
                                ],
                              ),
                              SizedBox(
                                width: screenWidth * 0.71, // Restrict width
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Montes fames volutpat fusce nisl in id lacus viverra mauris.  ',
                                          style: GoogleFonts.jost(fontSize: 12,fontWeight: FontWeight.w400)
                                      ),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: buttonColor,
                                            borderRadius: BorderRadius.circular(2.5),
                                          ),
                                          child: smallText12(
                                            context,
                                            'Follow',
                                            textColor: whiteColor,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              UiHelper.verticalSpace(height: 8),
                              Row(
                                children: [
                                  smallText12(context, '#Tamil #Thiru #Ram',textColor: whiteColor,fontWeight: FontWeight.w600),
                                  UiHelper.horizontalSpace(width: 8),
                                  mediumText14(context, 'See Translation',textColor: whiteColor,fontWeight: FontWeight.w600),
                                ],
                              ),
                              const SizedBox(height: 30,),
                            ],
                          ),),
                      ),
                      Positioned(
                        bottom: 40,
                        right: 10,
                        child: SizedBox(
                          //height: 450,
                          // color: Colors.red.withOpacity(0.5),
                          child: Column(
                            children: [
                              Stack( alignment: Alignment.bottomCenter,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 6),
                                      child: Image.asset('assets/images/profile6.png', width: 49,height:49,)),
                                  Positioned(bottom: 0,
                                      child: Image.asset('assets/images/plus.png', width: 21,height:22,)),
                                ],
                              ),
                              UiHelper.verticalSpace(height: 14),

                              Image.asset('assets/images/like_heart.png',height: 33.6,width: 33.6,),
                              mediumText14(context, '1.2K',textColor: whiteColor,fontWeight: FontWeight.w600),
                              UiHelper.verticalSpace(height: 14),
                              Image.asset('assets/images/chat.png',height: 33.6,width: 33.6,),
                              mediumText14(context, '45',textColor: whiteColor,fontWeight: FontWeight.w600),
                              UiHelper.verticalSpace(height: 14),
                              Image.asset('assets/images/bookmark.png',height: 25.2,width:26,),
                              UiHelper.verticalSpace(height: 14),
                              IconButton(
                                onPressed: () {},
                                icon: Image.asset('assets/images/share.png',height: 33.6,width:33.6,),
                                color: Colors.white,
                              ),
                              UiHelper.verticalSpace(height: 14),
                              Image.asset('assets/images/profile7.png',height: 50.0,width:50.0,),
                            ],
                          ),
                        ),
                      ),
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
                                overlayShape:
                                SliderComponentShape.noOverlay,
                                trackHeight: 2,
                              ),
                              child: Slider(
                                value: (snapshot.data ?? 0).clamp(0.0, 1.0),
                                min: 0.0,
                                max: 1.0,
                                activeColor: Colors.red,
                                inactiveColor: Colors.white,

                                onChanged: (value) {
                                  final position = videoPlayerController
                                      .value.duration.inMilliseconds *
                                      value;
                                  videoPlayerController.seekTo(Duration(
                                      milliseconds: position.toInt()));
                                },
                                // onChangeEnd: (value) {
                                //   videoPlayerController.play();
                                // },
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }),
          ),
          Container(
            color: Colors.black,
            padding: EdgeInsets.only(
              top: 10,
              bottom: Platform.isIOS ? 20 : 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add_box,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.account_box,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/screens/home/sound_screen.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
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


class ForYou extends StatefulWidget {
  const ForYou({super.key});

  @override
  State<ForYou> createState() => _ForYouState();
}

class _ForYouState extends State<ForYou> with WidgetsBindingObserver {
  VideoPlayerController? _currentVideoController;
  bool _isLoading = false; // Track loading state


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    //  _initialize(); // Initialize resources
  }

  Future<void> _initialize() async {
    // Simulate initialization work
    await Future.delayed(const Duration(seconds: 2)); // Mock delay
    setState(() {
      _isLoading = false; // Set loading to false after initialization
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
      print("AppLifecycleState: Paused or Detached");
      _currentVideoController?.pause();
    }
  }

  void didPushNext() {
    // Called when navigating to another screen
    print("Navigated to another screen");
    _currentVideoController?.pause();
  }

  void didPopNext() {
    // Called when returning to this screen
    print("Returned to this screen");
    _currentVideoController?.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  _isLoading
          ? const Center(
        child: CircularProgressIndicator(color: Colors.blue,), // Show loader while loading
      ) : Column(
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
                        bottom: 0,
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
                              /*  Row(
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
                              ),*/
                              Row(
                                //  crossAxisAlignment: CrossAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/profile6.png', width: 35, height: 35).pOnly(bottom: 8),
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
                                  smallText12(context,'10h ago',  textColor: const Color(0xffADADAD)),
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
                              UiHelper.verticalSpace(height: 8),
                              IntrinsicWidth(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(2.5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/repost.png',height: 12,width: 16,),
                                      smallText12(
                                        context,
                                        'Repost to follower',
                                        textColor: buttonColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30,),
                            ],
                          ),),
                      ),
                      Positioned(
                        bottom: 19,
                        right: 10,
                        child: SizedBox(
                          //height: 450,
                          // color: Colors.red.withOpacity(0.5),
                          child: Column(
                            children: [
                              Stack( alignment: Alignment.bottomCenter,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 11),
                                      child: Image.asset('assets/images/profile6.png', width: 49,height:49,)),
                                  Positioned(bottom: 0,
                                      right: 12,
                                      child: Image.asset('assets/images/plus.png', width: 20.47,height:21.74,)),
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
                              //     UiHelper.verticalSpace(height: 14),
                              IconButton(
                                  onPressed: () {
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: const SoundScreen(),
                                      withNavBar: false, // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                    );
                                  },
                                  icon: Image.asset('assets/images/profile7.png',height: 45.0,width:45.0,)),
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

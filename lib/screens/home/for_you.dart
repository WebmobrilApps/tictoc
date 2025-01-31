
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/screens/home/sound_screen.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';

// List of video URLs
final List<String> videoUrls = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
  "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4",
  'https://www.exit109.com/~dnn/clips/RW20seconds_1.mp4',
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
  "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4",
  'https://www.exit109.com/~dnn/clips/RW20seconds_1.mp4',
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
];


class ForYou extends StatefulWidget {
  const ForYou({super.key});

  @override
  State<ForYou> createState() => _ForYouState();
}

class _ForYouState extends State<ForYou> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          return VideoReel(
            videoUrl: videoUrls[index],
          );
        },
      ),
    );
  }
}

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
    // Initialize FlickManager and video player controller
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl)),
    );
  }

  @override
  void dispose() {
 //   flickManager.dispose();
    flickManager.flickControlManager?.pause(); // Pause the video
    flickManager.flickVideoManager?.videoPlayerController?.dispose(); // Dispose of the video controller
    flickManager.dispose(); // Dispose of FlickManager
    super.dispose();
  }

/*  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      flickManager.flickControlManager?.pause();
    }
  }*/


  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.videoUrl),
      onVisibilityChanged: (VisibilityInfo info) {
        // Manage play and pause based on visibility
        //    setState(() {
        isVisible = info.visibleFraction > 0;
        //  });

        if (isVisible) {
          if (!isPlaying) {
            flickManager.flickControlManager?.play();
            //    setState(() {
            isPlaying = true;
            //  });
          }
        } else {
          if (isPlaying) {
            flickManager.flickControlManager?.pause();
            //  setState(() {
            isPlaying = false;
            // });
          }
        }
      },
      child: Stack(
        children: [
          FlickVideoPlayer(
            flickManager: flickManager,
            preferredDeviceOrientation: [
              DeviceOrientation.portraitUp,
            ],
            // Here, we are not specifying any default controls
            // Just ensure we have no controls overlay on the video
          ),
          // Optionally, you can add custom controls here.
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
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(1.0),
                  ],),),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  SizedBox(height: 87.h,),
                ],
              ),),
          ),
          Positioned(
            bottom: 70,
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
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/screens/home/sound_screen.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class ReelsSideIcons extends StatefulWidget {
  final String fromPage;
  const ReelsSideIcons({super.key, required this.fromPage});

  @override
  State<ReelsSideIcons> createState() => _ReelsSideIconsState();
}

class _ReelsSideIconsState extends State<ReelsSideIcons> {
  @override
  Widget build(BuildContext context) {
    return  Positioned(
      bottom:  widget.fromPage=="FollowingTab"?160:70,
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
    );
  }
}

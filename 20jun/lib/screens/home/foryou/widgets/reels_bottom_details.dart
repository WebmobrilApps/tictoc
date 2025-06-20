import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/ui_helper.dart';
class ReelsBottomDetails extends StatefulWidget {
  final String fromPage;
  const ReelsBottomDetails({super.key, required this.fromPage});

  @override
  State<ReelsBottomDetails> createState() => _ReelsBottomDetailsState();
}

class _ReelsBottomDetailsState extends State<ReelsBottomDetails> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom:  widget.fromPage=="FollowingTab"?80:0,
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
                Padding(
                    padding: EdgeInsets.only(bottom: 8.h), // `.h` makes it responsive
                    child: Image.asset('assets/images/profile6.png', width: 35, height: 35)),
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
            widget.fromPage=="FollowingTab"?const SizedBox():
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
    );
  }
}

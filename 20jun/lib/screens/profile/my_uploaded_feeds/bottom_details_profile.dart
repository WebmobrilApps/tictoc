import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/time_rule.dart';
import 'package:tictoc/model/get_user_content_response.dart'as dfrContent;
import 'package:tictoc/model/get_profile_response.dart' as dfrProfile;
class BottomDetailsProfile extends StatefulWidget {
  final dfrContent.Data reelsData; // <-- Receive the Data object
  const BottomDetailsProfile({super.key,required this.reelsData});

  @override
  State<BottomDetailsProfile> createState() => _BottomDetailsProfileState();
}

class _BottomDetailsProfileState extends State<BottomDetailsProfile> {
  @override
  Widget build(BuildContext context) {
    final reelsData = widget.reelsData;

    return Positioned(
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
            Container(
              width: 260,
              padding: const EdgeInsets.only(left: 4,right: 4,top: 4,bottom: 4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffe87288),
                    Color(0xffd96b74),
                    Color(0xffd26067),
                    Color(0xffd26067),
                  ],),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  cachedImageWidget(
                      image:"$BASEURL/${reelsData.profilePic??''}",
                      borderRadiusValue:50,
                      hasProfileImg:true,
                      height: 38,width: 38),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          largeText16(
                            context,"${reelsData.name??''} . ",
                            textColor: Color(0xfffcb4b9),
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis, // Ensure truncation
                            maxLines: 1, // Limit to one line
                          ),
                          smallText12(context,TimeRule.formatDate(reelsData.createdAt??''), textColor: const Color(0xfffcb4b9),),
                        ],
                      ),
                      mediumText14(context, 'Posted this video',textColor: const Color(0xfffeedef))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 87.h,),
          ],
        ),),
    );
  }
}

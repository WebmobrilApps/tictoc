
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/time_rule.dart';
import 'package:tictoc/model/get_other_user_content_response.dart' as dfrOtherContent;

class BottomDetailsOther extends StatefulWidget {
  final dfrOtherContent.Data reelsData; // <-- Receive the Data object
  const BottomDetailsOther({super.key,required this.reelsData});

  @override
  State<BottomDetailsOther> createState() => _BottomDetailsOtherState();
}

class _BottomDetailsOtherState extends State<BottomDetailsOther> {
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
              Colors.black.withOpacity(0.1),
              Colors.black.withOpacity(0.2),
              Colors.black.withOpacity(0.4),
              Colors.black.withOpacity(0.6),
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(1.0),
            ],),),
        child: Padding(
          padding: const EdgeInsets.only(right: 65),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
               margin: const EdgeInsets.only(right: 16),
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
                              textColor: const Color(0xfffcb4b9),
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
              SizedBox(height: 6.h,),
              smallText12(context, reelsData.descr??'',textColor: whiteColor),
              smallText12(context,   reelsData.tags!.map((tag) => tag.startsWith('#') ? tag : '#$tag').join(' '),
                  textColor: whiteColor, fontWeight: FontWeight.w600),
              SizedBox(height: 87.h,),
            ],
          ),
        ),),
    );
  }
}

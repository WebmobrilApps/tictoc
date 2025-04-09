
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/screens/home/sound_screen.dart';
import 'package:tictoc/screens/profile/feeds/delete_post_bottom_sheet.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:tictoc/model/get_user_content_response.dart'as dfrContent;
import 'package:tictoc/model/get_other_profile_response.dart' as dfrOtherProfile;

class OtherSideIcon extends StatefulWidget {
  final dfrContent.Data reelsData; // <-- Receive the Data object
  final dfrOtherProfile.GetOtherProfileResponse getOtherProfileResponse;
  const OtherSideIcon({super.key, required this.reelsData,required this.getOtherProfileResponse});

  @override
  State<OtherSideIcon> createState() => _OtherSideIconState();
}

class _OtherSideIconState extends State<OtherSideIcon> {
  @override
  Widget build(BuildContext context) {
    final userData = widget.getOtherProfileResponse.data;
    final reelsData = widget.reelsData;
    return  Positioned(
      bottom: 70,
      right: 10,
      child: SizedBox(
        //height: 450,
        // color: Colors.red.withOpacity(0.5),
        child: Column(
          children: [
            MyInkWell(
              onTap: () async{
                Navigator.of(context).pop();
              },
              child: Stack( alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 11),
                    child: cachedImageWidget(
                        image:"$BASEURL/${userData?.profilePic??''}",
                        borderRadiusValue:50,
                        hasProfileImg:true,
                        height: 49,width: 49),
                  ),
                  Positioned(bottom: 0,
                      right: 12,
                      child: Image.asset('assets/images/plus.png', width: 20.47,height:21.74,)),
                ],
              ),
            ),
            UiHelper.verticalSpace(height: 14),
            Image.asset('assets/images/like_heart.png',height: 33.6,width: 33.6,),
            //  mediumText14(context, '1.2K',textColor: whiteColor,fontWeight: FontWeight.w600),
            mediumText14(context, reelsData.likeCount.toString(),textColor: whiteColor,fontWeight: FontWeight.w600),
            UiHelper.verticalSpace(height: 14),
            Image.asset('assets/images/chat.png',height: 33.6,width: 33.6,),
            mediumText14(context, reelsData.commentCount.toString(),textColor: whiteColor,fontWeight: FontWeight.w600),
            UiHelper.verticalSpace(height: 14),
            Image.asset('assets/images/bookmark.png',height: 25.2,width:26,),
            mediumText14(context, reelsData.saveCount.toString(),textColor: whiteColor,fontWeight: FontWeight.w600),
            UiHelper.verticalSpace(height: 10),
            IconButton(
              onPressed: ()async {
                final result = await showModalBottomSheet(
                  isScrollControlled: true,
                  useRootNavigator: true,
                  context: context,
                  builder: (context) =>  DeletePostBottomSheet(contentId: reelsData.pkVideos.toString(),),
                );
                if (result != null && result['deleted'] == true) {
                  Navigator.pop(context, {'deleted': true, 'id': result['id']});
                }
              },
              icon: Image.asset('assets/images/delete.png',height: 25.6,width:26, color: Colors.white,),
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

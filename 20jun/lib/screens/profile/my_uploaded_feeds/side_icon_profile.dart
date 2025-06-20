
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/screens/home/following/widgets/comment_following.dart';
import 'package:tictoc/screens/home/sound_screen.dart';
import 'package:tictoc/screens/profile/my_uploaded_feeds/delete_post_bottom_sheet.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:tictoc/model/get_user_content_response.dart'as dfrContent;

class SideIconProfile extends StatefulWidget {
  final dfrContent.Data reelsData; // <-- Receive the Data object
  final String? fromPage;
  const SideIconProfile({super.key,required this.reelsData, this.fromPage});

  @override
  State<SideIconProfile> createState() => _SideIconProfileState();
}

class _SideIconProfileState extends State<SideIconProfile> {
  @override
  Widget build(BuildContext context) {
    print('fromPage:${widget.fromPage}');
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
                    margin: const EdgeInsets.only(bottom: 9),
                    child: cachedImageWidget(
                        image:"$BASEURL/${reelsData.profilePic??''}",
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
            MyInkWell(
                onTap: ()async{
                  Map<String, dynamic> hitLikeDetails = {
                    "pk_videos": reelsData.pkVideos,
                  };
                  print('hitLikeDetails:$hitLikeDetails');
                  BlocProvider.of<TicTocCubit>(context).hitLikeProfileCall(hitLikeDetails).whenComplete((){
                    setState(() {
                      if (reelsData.isLiked == 0) {
                        reelsData.isLiked = 1;
                        reelsData.likeCount = (reelsData.likeCount ?? 0) + 1;
                      } else {
                        reelsData.isLiked = 0;
                        reelsData.likeCount = (reelsData.likeCount ?? 1) - 1;
                      }
                   });
                  });
                },
                child: Image.asset('assets/images/like_heart.png',height: 33.6,width: 33.6,color: reelsData.isLiked==0?Colors.white:buttonColor,)),
            mediumText14(context, reelsData.likeCount.toString(),textColor: whiteColor,fontWeight: FontWeight.w600),
            UiHelper.verticalSpace(height: 14),
            MyInkWell(
                onTap: () async{
                  final result = await showModalBottomSheet<int>(
                    context: context,
                    backgroundColor: Colors.transparent,
                    useRootNavigator: true,
                    isScrollControlled: true,
                    isDismissible: false, // ❌ disable tap-outside
                    enableDrag: false,    // ❌ disable swipe down to dismiss
                    builder: (context) {
                      return CommentBottomSheetWrapper(
                        videoId: widget.reelsData.pkVideos.toString() ?? '',
                      );
                    },
                  );
                  if (result != null) {
                    setState(() {
                      reelsData.commentCount = result;
                    });
                  }
                },
                child: Image.asset('assets/images/chat.png',height: 33.6,width: 33.6,)),
            mediumText14(context, reelsData.commentCount.toString(),textColor: whiteColor,fontWeight: FontWeight.w600),
            UiHelper.verticalSpace(height: 14),
         //   Image.asset('assets/images/bookmark.png',height: 25.2,width:26,),
            MyInkWell(
                onTap: ()async{
                  Map<String, dynamic> bookmarkDetails = {
                    "content_id": reelsData.pkVideos,
                  };
                  print('bookmarkDetails:$bookmarkDetails');
                  BlocProvider.of<TicTocCubit>(context).bookmarkProfileCall(bookmarkDetails).whenComplete((){
                    setState(() {
                      if (reelsData.isSaved == 0) {
                        reelsData.isSaved = 1;
                        reelsData.saveCount = (reelsData.saveCount ?? 0) + 1;
                      } else {
                        reelsData.isSaved = 0;
                        reelsData.saveCount = (reelsData.saveCount ?? 1) - 1;
                        if (widget.fromPage == "MyBookMarkGallery") {
                          Navigator.pop(context, {
                            'unBookmarked': true,
                            'id': reelsData.pkVideos,
                          });
                        }
                      }
                    });
                  });
                },
                child: Image.asset(reelsData.isSaved==0?'assets/images/bookmark.png':'assets/images/bookmark_filled.png',height: 25.2,width:26)),
            mediumText14(context, reelsData.saveCount.toString(),textColor: whiteColor,fontWeight: FontWeight.w600),
            widget.fromPage=="MyBookMarkGallery"?
            const SizedBox():Column(
              children: [
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
              ],
            ),
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

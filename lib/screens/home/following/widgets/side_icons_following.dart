
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/screens/home/following/widgets/comment_following.dart';
import 'package:tictoc/screens/home/sound_screen.dart';
import 'package:tictoc/screens/otherprofile/other_profile.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:tictoc/model/following_feed_response.dart' as dfrFollowing;

class SideIconsFollowing extends StatefulWidget {
  final String fromPage;
  final dfrFollowing.Data? reelsData; // <-- Receive the Data object
  const SideIconsFollowing({super.key, required this.fromPage, this.reelsData});

  @override
  State<SideIconsFollowing> createState() => _SideIconsFollowingState();
}

class _SideIconsFollowingState extends State<SideIconsFollowing> {
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final reelsData = widget.reelsData;
    return BlocConsumer<TicTocCubit, TicTocState>(
      listener: (context, state) {
        if (state.status == TicTocStatus.hitLikeFollowingReelsSuccess) {
        //  UiHelper.toastMessage(state.responseData?.response ?? '');
          setState(() {
            if (reelsData != null) {
              if (reelsData.isLiked == 0) {
                reelsData.isLiked = 1;
                reelsData.likeCount = (reelsData.likeCount ?? 0) + 1;
              } else {
                reelsData.isLiked = 0;
                reelsData.likeCount = (reelsData.likeCount ?? 1) - 1;
              }
            }
          });
        }
        if (state.status == TicTocStatus.bookmarkFollowingSuccess) {
          setState(() {
            if (reelsData != null) {
              if (reelsData.isSaved == 0) {
                reelsData.isSaved = 1;
                reelsData.saveCount = (reelsData.saveCount ?? 0) + 1;
              } else {
                reelsData.isSaved = 0;
                reelsData.saveCount = (reelsData.saveCount ?? 1) - 1;
              }
            }
          });
        }
        if (state.status == TicTocStatus.hitLikeFollowingReelsError) {
          log(state.errorData?.code.toString()??'');
          UiHelper.toastMessage(state.errorData?.message ?? state.error ?? "");
        }
      },
      builder: (context, state) {
        return Positioned(
          bottom:  widget.fromPage=="FollowingTab"?80:70,
          right: 10,
          child: SizedBox(
            child: Column(
              children: [
                MyInkWell(
                  onTap: () async {
                   if(myUserID.toString() != reelsData!.uploaderId?.toString()){
                     PersistentNavBarNavigator.pushNewScreen(
                       context,
                       screen:  OtherProfile(userId: reelsData.uploaderId.toString()),
                       withNavBar: false, // OPTIONAL VALUE. True by default.
                       pageTransitionAnimation: PageTransitionAnimation.cupertino,
                     );
                   }
                  },
                  child: Stack( alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 11),
                        child: cachedImageWidget(
                            image:"$BASEURL/${reelsData?.profilePic??''}",
                            borderRadiusValue:50,
                            hasProfileImg:true,
                            height: 49,width: 49),
                      ),
                      Positioned(bottom: 2,
                          right: 14,
                          child: Image.asset('assets/images/plus.png', width: 20.47,height:21.74,)),
                    ],
                  ),
                ),
                UiHelper.verticalSpace(height: 14),
                MyInkWell(
                    onTap: ()async{
                      Map<String, dynamic> hitLikeDetails = {
                        "pk_videos": reelsData.videoId,
                      };
                      print('hitLikeDetails:$hitLikeDetails');
                      BlocProvider.of<TicTocCubit>(context).hitLikeFollowingReelsCall(hitLikeDetails);
                    },
                    child: Image.asset('assets/images/like_heart.png',height: 33.6,width: 33.6,color: reelsData!.isLiked==0?Colors.white:buttonColor,)),
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
                            videoId: widget.reelsData?.videoId.toString() ?? '',
                          );
                        },
                      );

                      // 👇 if user added a comment, update count
                      if (result != null) {
                        setState(() {
                          reelsData.commentCount = result;
                        });
                      }
                    },
                  child: Image.asset('assets/images/chat.png',height: 33.6,width: 33.6,)),
                mediumText14(context, reelsData.commentCount.toString(),textColor: whiteColor,fontWeight: FontWeight.w600),
                UiHelper.verticalSpace(height: 14),
                MyInkWell(
                    onTap: ()async{
                      Map<String, dynamic> bookmarkDetails = {
                        "content_id": reelsData.videoId,
                      };
                      print('bookmarkDetails:$bookmarkDetails');
                      BlocProvider.of<TicTocCubit>(context).bookmarkFollowingCall(bookmarkDetails);
                    },
                    child: Image.asset(reelsData.isSaved==0?'assets/images/bookmark.png':'assets/images/bookmark_filled.png',height: 25.2,width:26)),
                UiHelper.verticalSpace(height: 1),
                mediumText14(context, reelsData.saveCount.toString(),textColor: whiteColor,fontWeight: FontWeight.w600),
                UiHelper.verticalSpace(height: 10),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/images/share.png',height: 33.6,width:33.6,),
                  color: Colors.white,
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
      },
    );
  }
}
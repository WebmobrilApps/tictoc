import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/get_other_profile_response.dart';
import 'package:tictoc/screens/follower_list/my_follower_list.dart';
import 'package:tictoc/screens/following_list/other_user_following_list.dart';
import 'package:tictoc/screens/profile/profile_details/like_dialog.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/shared_preference.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/custom_navigator.dart';
import '../Chat/chatdetail.dart';
import '../inbox/chat_screen.dart';

class OtherProfileAppBar extends StatefulWidget {
  final GetOtherProfileResponse getOtherProfileResponse;
  const OtherProfileAppBar({super.key,required this.getOtherProfileResponse});

  @override
  State<OtherProfileAppBar> createState() => _OtherProfileAppBarState();
}

class _OtherProfileAppBarState extends State<OtherProfileAppBar> {
  bool hasUpdated = false;
  @override
  Widget build(BuildContext context) {
    final otherProfileData = widget.getOtherProfileResponse.data;
    return BlocConsumer<TicTocCubit, TicTocState>(
      listener: (context, state) {
        if (state.status == TicTocStatus.followUserSuccess) {
          UiHelper.toastMessage(state.responseData?.response ?? '');

          setState(() {
            otherProfileData?.isFollowing = 1; // Update the status
            hasUpdated = true;
          });
        }
        if (state.status == TicTocStatus.unFollowUserSuccess) {
          UiHelper.toastMessage(state.responseData?.response ?? '');
          setState(() {
            otherProfileData?.isFollowing = 0; // Update the status
            hasUpdated = true;
          });
        }
        if (state.status == TicTocStatus.followUserError) {
          print(state.errorData?.message);
          String message = state.errorData?.message ?? state.error ?? "";
          UiHelper.toastMessage(message);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyInkWell(
                 //   onTap: ()async{  Navigator.pop(context, hasUpdated);},
                    onTap: ()async{  Navigator.pop(context, hasUpdated?otherProfileData?.isFollowing:null);},
                    child: Image.asset('assets/images/back_arrow_black.png',height:25.5,width: 25.5,)),
                Row(
                  children: [
                    MyInkWell(
                      onTap: ()async{
                        Share.share('Check out this TicToc App');
                      },
                      child:Image.asset('assets/images/share1.png',height:25.5,width: 25.5,),),
                    UiHelper.horizontalSpace(width: 6),
                    /*    IconButton(
                  highlightColor:Colors.transparent,
                  onPressed: (){
                    //CustomNavigator.push(context: context, screen: const OtherProfileActions());
                    CustomNavigator.push(context: context, screen: const OtherProfileMenu());
                  },
                  icon: Image.asset(
                    "assets/images/more_horiz.png",
                    height: 30,
                    width: 30,
                  ),
                ),*/
                  ],
                ),
              ],
            ).pOnly(left: 20,right: 10),
            const SizedBox(height: 6,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                cachedImageWidget(
                    image:"$BASEURL/${otherProfileData?.profilePic??''}",
                    borderRadiusValue:50,
                    hasProfileImg:true,
                    height: 100,width: 100),
                UiHelper.verticalSpace(height: 3),
                largeText16(context, otherProfileData?.name??'',fontWeight: FontWeight.w500),
                mediumText14(context, '@${otherProfileData?.username??''}',textColor: const Color(0xff484848)),
                UiHelper.verticalSpace(height: 12),
                Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyInkWell(
                      onTap: ()async{
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: MyFollowerList(otherUserId: otherProfileData?.pkUser.toString(),),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Column(
                        children: [
                          smallText12(context,otherProfileData?.followers.toString()??'',fontWeight: FontWeight.w600),
                          smallText12(context, 'Followers',),
                        ],
                      ),
                    ),
                    const SizedBox(width:40),
                    MyInkWell(
                      onTap: ()async{
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: OtherUserFollowingList(otherUserId: otherProfileData!.pkUser.toString(),),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Column(
                        children: [
                          smallText12(context, otherProfileData?.following.toString()??'',fontWeight: FontWeight.w600),
                          smallText12(context, 'Following',),
                        ],
                      ),
                    ),
                    const SizedBox(width:40),
                    MyInkWell(
                      onTap: ()async{
                        final result = await showDialog<bool>(
                          context: context,
                          builder: (context) =>  LikeDialog(
                              totalLikes:otherProfileData!.likes.toString()
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          smallText12(context,otherProfileData?.likes.toString()??'',fontWeight: FontWeight.w600),
                          smallText12(context, 'Likes',),
                        ],
                      ),
                    ),
                  ],
                ),
                UiHelper.verticalSpace(height: 14),
                Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmallPinkButton(
                      isLoading: state.status == TicTocStatus.followUserLoading,
                      onTap: () {
                        if(otherProfileData?.isFollowing==0){
                          Map<String, dynamic> followUserMap = {
                            "follower_id": myUserID,
                            "following_id": otherProfileData?.pkUser,
                          };
                          BlocProvider.of<TicTocCubit>(context).followUserCall(followUserMap);
                        }else{
                          // CustomNavigator.push(context: context, screen:  ChatScreen(userId:otherProfileData!.pkUser.toString()));
                          myFirebaseID = PreferenceManager.getStringValue(key: FIREBASE_ID) ?? "";
                        print('otherUserId:${ otherProfileData!.pkUser.toString()}');
                        print('otherUserFBId:${ otherProfileData.firebaseId.toString()}');
                        print('myFirebaseID:$myFirebaseID');

                          CustomNavigator.push(context: context, screen:  FirebaseChatScreen(

                            otherUserId:  otherProfileData.firebaseId.toString(),
                            otherUserData: otherProfileData.pkUser.toString(),
                       /*     otherUserId: "1234",
                            otherUserFBId:"1234",*/
                            userId: myFirebaseID??'',
                            profileImage:"",
                            userName:  "Pushkar",
                            myImage: "userimage",
                            name: "saraswat",

                              // userId:otherProfileData!.pkUser.toString()
                          )
                          );
                        }
                      },
                      label: otherProfileData?.isFollowing==1?"Message":"Follow",),
                    const SizedBox(width:12),
                    otherProfileData?.isFollowing==0?const SizedBox():
                    SmallPinkButton(
                      isLoading: state.status == TicTocStatus.unFollowUserLoading,
                      onTap: () {
                        BlocProvider.of<TicTocCubit>(context).unFollowUserCall(otherProfileData?.pkUser??0);
                      },
                      icon: Image.asset('assets/images/add_to_follow.png',height: 16,width: 16,),)
                  ],
                ),
                UiHelper.verticalSpace(height: 6),
              ],
            ),
          ],
        );
      },
    );
  }
}

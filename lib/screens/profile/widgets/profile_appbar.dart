import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/model/get_profile_response.dart';
import 'package:tictoc/screens/inbox/followers.dart';
import 'package:tictoc/screens/profile/edit_profile.dart';
import 'package:tictoc/screens/profile/following_list.dart';
import 'package:tictoc/screens/profile/menu_profile_bottom.dart';
import 'package:tictoc/screens/profile/profile_details/like_dialog.dart';
import 'package:tictoc/screens/profile/profile_views.dart';
import 'package:tictoc/screens/profile/share_profile.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';


class ProfileAppBar extends StatelessWidget {

  final GetProfileResponse getProfileResponse;
  const ProfileAppBar({super.key, required this.getProfileResponse});

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                largeText16(context, getProfileResponse.data?.username??'',fontWeight: FontWeight.w500),
                const SizedBox(width: 8,),
                Image.asset('assets/images/down_arrow.png',height:18,width: 11,),
              ],
            ),
            Row(
              children: [
                MyInkWell(
                    onTap: ()async{
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const ProfileViews(),
                        withNavBar: false, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Image.asset('assets/images/footPrint.png',height:25,width: 25,)),
                const SizedBox(width: 16,),
                MyInkWell(
                    onTap: ()async {
                      final result = await showModalBottomSheet(
                        isScrollControlled: true,
                        useRootNavigator: true,
                        context: context,
                        builder: (context) => const MenuProfileBottom(),
                      );
                      if (result != null) {
                        // setState(() {
                        // });
                        //      Navigator.pop(context); // Close the bottom sheet
                      }
                    },
                    child: Image.asset('assets/images/menu.png',height:26,width: 26,)),
              ],
            ),
          ],
        )
    );
  }
}


class ProfileInfo extends StatelessWidget {
  final GetProfileResponse getProfileResponse;
  final PersistentTabController controller;
  const ProfileInfo({super.key, required this.getProfileResponse, required this.controller});

  @override
  Widget build(BuildContext context) {
    final profileData = getProfileResponse.data;
    return Container(
      color: const Color(0xffF2F2F2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UiHelper.verticalSpace(height: 10),
          profileData?.profilePic!=null?
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: buttonColor, width: 1), // Border color and width
                  borderRadius: BorderRadius.circular(50),
                ),
                child: cachedImageWidget(
                    image:"$BASEURL/${profileData?.profilePic??''}",
                    hasProfileImg:true,
                    borderRadiusValue:50,
                    height: 80,width: 80),
              ),
              Positioned(
                  right: 0,
                  bottom: 3,
                  child: Image.asset('assets/images/create.png',height:22,width: 22,)),
            ],
          ):
          Stack(
            children: [
              Image.asset('assets/images/profile1.png',height:80,width: 81,),
              Positioned(
                  right: 0,
                  bottom: 3,
                  child: Image.asset('assets/images/create.png',height:22,width: 22,)),
            ],
          ),
          UiHelper.verticalSpace(height: 3),
          largeText16(context, profileData?.username??'',fontWeight: FontWeight.w500),
          mediumText14(context, profileData?.tictocid??''),
          UiHelper.verticalSpace(height: 10),
          Row( mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyInkWell(
                onTap: ()async{
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const Followers(),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: Column(
                  children: [
                    smallText12(context, profileData!.followers.toString(),fontWeight: FontWeight.w600),
                    smallText12(context, 'Followers',),
                  ],
                ),
              ),
              const SizedBox(width:40),
              MyInkWell(
                onTap: ()async{
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const FollowingList(),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },

                child: Column(
                  children: [
                    smallText12(context, profileData.following.toString(),fontWeight: FontWeight.w600),
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
                        totalLikes:profileData.likes.toString()
                    ),
                  );
                },
                child: Column(
                  children: [
                    smallText12(context, profileData.likes.toString(),fontWeight: FontWeight.w600),
                    smallText12(context, 'Likes',),
                  ],
                ),
              ),
            ],
          ),
          UiHelper.verticalSpace(height: 10),
          Row( mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmallPinkButton(
                onTap: () async {
               final result = await PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen:  EditProfile(getProfileResponse: getProfileResponse),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
               if (result != null) {
                 print('Updated Profile: ${jsonEncode(result.toJson())}');
                   getProfileResponse.data = result; // Update profile data
               }
              }, label: "Edit Profile",),
              const SizedBox(width:16),
              SmallPinkButton(label: "Share Profile",
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const ShareProfile(),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
              ),
              const SizedBox(width:16),
              SmallPinkButton(onTap: () {
                controller.jumpToTab(1);
              }, label: "Add friends",),
            ],
          ),
          UiHelper.verticalSpace(height: 8),
          smallText12(context, 'Add Bio'),
          UiHelper.verticalSpace(height: 4),
          Row( mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/studio.png',height: 15,width: 14,),
              UiHelper.horizontalSpace(width: 12),
              smallText12(context, 'Tictoc Studio'),
            ],
          ),
          UiHelper.verticalSpace(height: 12),
        ],
      ),
    );
  }

  Widget _infoItem(String count, String label) {
    return Column(
      children: [
        Text(count, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}

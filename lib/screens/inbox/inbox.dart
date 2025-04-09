import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/screens/auth/forgot_password.dart';
import 'package:tictoc/screens/inbox/activity_model_top.dart';
import 'package:tictoc/screens/inbox/chat_screen.dart';
import 'package:tictoc/screens/inbox/followers.dart';
import 'package:tictoc/screens/notification/system_notification.dart';
import 'package:tictoc/screens/profile/choose_photo_bottom.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class Inbox extends StatefulWidget {
  final PersistentTabController controller;
  const Inbox({super.key, required this.controller});

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  final List storiesData = [
    {"storyImage":"assets/images/profile2.png", "name":"Thiru", "isLive":true},
    {"storyImage":"assets/images/profile3.png", "name":"Ram", "isLive":true},
    {"storyImage":"assets/images/profile4.png", "name":"Mohan", "isLive":false},
    {"storyImage":"assets/images/profile5.png", "name":"Lokesh", "isLive":false},
    {"storyImage":"assets/images/profile2.png", "name":"Thiru", "isLive":true},
    {"storyImage":"assets/images/profile3.png", "name":"Ram", "isLive":true},
    {"storyImage":"assets/images/profile4.png", "name":"Mohan", "isLive":false},
    {"storyImage":"assets/images/profile5.png", "name":"Lokesh", "isLive":false},
    {"storyImage":"assets/images/profile2.png", "name":"Thiru", "isLive":true},
    {"storyImage":"assets/images/profile3.png", "name":"Ram", "isLive":true},
    {"storyImage":"assets/images/profile4.png", "name":"Mohan", "isLive":false},
    {"storyImage":"assets/images/profile5.png", "name":"Lokesh", "isLive":false},
  ];
  final List inboxData = [
    {"storyImage":"assets/images/inbox1.png", "name":"Thiru", "followStatus":"", "message":"lorem ipsum"},
    {"storyImage":"assets/images/inbox2.png", "name":"DisaSmith", "followStatus":"Follow Back", "message":"Follows you"},
    {"storyImage":"assets/images/inbox3.png", "name":"Suriya", "followStatus":"", "message":"lorem ipsum"},
    {"storyImage":"assets/images/inbox1.png", "name":"Angel", "followStatus":"Following","message":"Following"},
    {"storyImage":"assets/images/inbox2.png", "name":"Bengamine", "followStatus":"", "message":"lorem ipsum"},
    {"storyImage":"assets/images/inbox3.png", "name":"Tokyo", "followStatus":"","message":"lorem ipsum"},
    {"storyImage":"assets/images/inbox1.png", "name":"Thiru", "followStatus":"", "message":"lorem ipsum"},
    {"storyImage":"assets/images/inbox2.png", "name":"DisaSmith", "followStatus":"Follow Back", "message":"Follows you"},
    {"storyImage":"assets/images/inbox3.png", "name":"Suriya", "followStatus":"", "message":"lorem ipsum"},
    {"storyImage":"assets/images/inbox1.png", "name":"Angel", "followStatus":"Following","message":"Following"},
    {"storyImage":"assets/images/inbox2.png", "name":"Bengamine", "followStatus":"", "message":"lorem ipsum"},
    {"storyImage":"assets/images/inbox3.png", "name":"Tokyo", "followStatus":"","message":"lorem ipsum"},
  ];
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: whiteColor, // Green status bar
        statusBarIconBrightness: Brightness.dark, // Light icons for better contrast
      ),
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiHelper.verticalSpace(height: screenHeight*0.075),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyInkWell(
                    onTap:()async{
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const Followers(),
                        withNavBar: false, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(right: 7,top: 2),
                            child: Image.asset('assets/images/add_user.png',height:29,width: 34,)),
                        Positioned(
                          top: 0,right: 0,
                          child: Container(
                            width: 12, height: 14,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: buttonColor
                            ),
                            child: Center(child: smallText12(context, '2',textColor:Colors.white,fontSize: 7.sp,fontWeight: FontWeight.w400)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      largeText16(context, 'Inbox',fontSize: 20),
                      const SizedBox(width: 8,),
                      const GreenCircle(),
                      const SizedBox(width: 8,),
                      Image.asset('assets/images/down_black.png',color:appBlackColor,height:10,width: 8,),
                    ],
                  ),
                  Image.asset('assets/images/search_black.png',height:26,width: 26,),
                ],
              ),
            ),
            UiHelper.verticalSpace(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Stack(alignment: Alignment.centerRight,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(bottom: 4),
                                    child: Image.asset('assets/images/profile1.png',height: 61.58,width: 61.58,)),
                                Positioned(
                                  bottom: 0,
                                  child:Image.asset('assets/images/create.png',height: 24,width: 24,),),
                              ],
                            ),
                            const SizedBox(height: 4),
                            smallText12(context, 'Create',fontWeight: FontWeight.w500)
                          ],
                        ),
                        UiHelper.horizontalSpace(width: 6),
                        Column(
                          children: [
                            Image.asset('assets/images/add_widget.png',height: 61.58,width: 61.58,),
                            const SizedBox(height: 9),
                            smallText12(context, '+ Widget',fontWeight: FontWeight.w500)
                          ],
                        ),
                        UiHelper.horizontalSpace(width: 6),
                        Expanded(
                          child: ConstrainedBox(
                            constraints:  BoxConstraints(maxHeight: screenHeight*0.12), // Dynamically constrain height
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: storiesData.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 6.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(storiesData[index]['storyImage'], height: 61.58, width: 61.58,),
                                      const SizedBox(height: 8),
                                      smallText12(context,  storiesData[index]['name'],fontWeight: FontWeight.w500)
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                      ],
                    ).pOnly(left:20),
                    UiHelper.verticalSpace(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(left: 24,right: 24),
                      child: Column(  crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Image.asset('assets/images/new_followers.png',height: 50,width: 50,),
                                    UiHelper.horizontalSpace(width: 10),
                                    Expanded(
                                      child: MyInkWell(
                                        onTap: ()async{
                                          PersistentNavBarNavigator.pushNewScreen(
                                            context,
                                            screen: const Followers(),
                                            withNavBar: false, // OPTIONAL VALUE. True by default.
                                            pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            mediumText14(context, 'New Followers',fontWeight: FontWeight.w500),
                                            mediumText14(context, 'Quis nulla arcu aliquet et vel leo.',maxLines:1,
                                                fontSize: 15, textColor: const Color(0xff484848),
                                                overflow:TextOverflow.ellipsis, fontWeight: FontWeight.w500),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset('assets/images/right_arrow.png',height: 12,width: 6,),
                            ],
                          ),
                          UiHelper.verticalSpace(height: 12),
                          MyInkWell(
                            onTap: ()async {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                useRootNavigator: true,
                                backgroundColor: Colors.transparent, // To make it look seamless
                                isDismissible: true, // Allows dismissal by tapping outside
                                enableDrag: true, // Enables drag-to-dismiss
                                builder: (context) {
                                  return const ActivityModel();
                                },
                              );
                            },
                            child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/activity.png',height: 50,width: 50,),
                                      UiHelper.horizontalSpace(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            mediumText14(context, 'Activity',fontWeight: FontWeight.w500),
                                            mediumText14(context, 'Someone viewed your profile.',maxLines:1,
                                                fontSize: 15, textColor: const Color(0xff484848),
                                                overflow:TextOverflow.ellipsis, fontWeight: FontWeight.w500),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset('assets/images/right_arrow.png',height: 12,width: 6,),
                              ],
                            ),
                          ),
                          UiHelper.verticalSpace(height: 12),
                          Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Image.asset('assets/images/system_notification.png',height: 50,width: 50,),
                                    UiHelper.horizontalSpace(width: 10),
                                    Expanded(
                                      child: MyInkWell(
                                        onTap: ()async{
                                          PersistentNavBarNavigator.pushNewScreen(
                                            context,
                                            screen: const SystemNotification(),
                                            withNavBar: false, // OPTIONAL VALUE. True by default.
                                            pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            mediumText14(context, 'System notification',fontWeight: FontWeight.w500,),
                                            mediumText14(context, 'Account updates: comment safety tools',maxLines:1,
                                                textColor: const Color(0xff484848),fontSize: 13,
                                                overflow:TextOverflow.ellipsis, fontWeight: FontWeight.w400),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset('assets/images/right_arrow.png',height: 12,width: 6,),
                            ],
                          ),
                          UiHelper.verticalSpace(height: 12),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: inboxData.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  MyInkWell(
                                    onTap:()async{
                                    /*  PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: const ChatScreen(),
                                        withNavBar: false, // OPTIONAL VALUE. True by default.
                                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                      );*/
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Image.asset(inboxData[index]['storyImage'], height: 50, width: 50,),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    mediumText14(context,inboxData[index]['name'],
                                                        maxLines: 1,overflow: TextOverflow.ellipsis,
                                                        fontWeight: FontWeight.w500),
                                                    smallText12(context, inboxData[index]['message'],  maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                    smallText12(context, "5 min", textColor: appGreyColor, maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                       if( inboxData[index]['followStatus']=="Follow Back")
                                        Row(
                                          children: [
                                            const SmallPinkButton(label: 'Follow Back',
                                              padding: EdgeInsets.only(left:10,right:10,top:4,bottom: 4),),
                                            const SizedBox(width: 6,),
                                            Image.asset('assets/images/clear.png',height: 18, width: 18,)
                                          ],
                                        ),
                                        if( inboxData[index]['followStatus']=="")
                                        Image.asset('assets/images/soundScreen2.png',height: 56, width: 44,),
                                        if( inboxData[index]['followStatus']=="Following")
                                        const SmallPinkButton(label: 'Following',backgroundColor:Color(0xffD9D9D9),
                                          textColor: Color(0xff484848),
                                          padding: EdgeInsets.only(left:12,right:12,top:4,bottom: 4),),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 12,),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    UiHelper.verticalSpace(height: screenHeight*0.1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}


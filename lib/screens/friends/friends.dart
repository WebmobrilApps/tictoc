import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tictoc/screens/profile/other_profile_details.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
class Friends extends StatefulWidget {
  const Friends({super.key});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  TextEditingController searchController = TextEditingController();
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
        backgroundColor: appBgColor,
        body:   Padding(
          padding: const EdgeInsets.only(left: 18,right: 18),
          child: Column(
            children: [
              UiHelper.verticalSpace(height: screenHeight*0.08),
              Row(
                children: [
                  Expanded(
                    child: customTextFieldWithBorder(
                      height: 42,
                      hintText: 'Find Friends',
                      controller: searchController,
                      hintFontColor: const Color(0XFF0B0B0B),
                      hintFontSize: 15,
                      textFontSize: 15,
                      bgColor:const Color(0XFFF2F2F2),
                      borderRadiusValue: 10,
                      borderColor:const Color(0XFFF2F2F2),
                      prefixIcon: Image.asset('assets/images/search_black.png',color: const Color(0xff0B0B0B), height: 20, width: 20),
                      suffixIcon: Image.asset('assets/images/clear.png', color:appBlackColor,height: 20, width: 20),

                    ),
                  ),
                  const SizedBox(width: 12,),
                  Image.asset('assets/images/scan.png', height: 24, width: 24),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UiHelper.verticalSpace(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Image.asset('assets/images/invite_friends.png', height: 50, width: 50,),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      mediumText14(context,'Invite friends',
                                          maxLines: 1,overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w500),
                                      smallText12(context, 'Stay connected on TikTok',textColor: const Color(0xff484848),
                                        maxLines: 1,overflow: TextOverflow.ellipsis,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SmallPinkButton( label: 'Invite', fontSize: 14,
                            padding : EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                            onTap: (){
                              Share.share('Check out this awesome Flutter package!');
                            },
                          ),
                        ],
                      ),
                      UiHelper.verticalSpace(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Image.asset('assets/images/contacts.png', height: 50, width: 50,),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      mediumText14(context,'Contacts',
                                          maxLines: 1,overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w500),
                                      smallText12(context, 'find your contacts',textColor: const Color(0xff484848),
                                        maxLines: 1,overflow: TextOverflow.ellipsis,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SmallPinkButton( label: 'Find', fontSize: 14,
                            padding : EdgeInsets.symmetric(horizontal: 24, vertical: 4),),
                        ],
                      ),
                      UiHelper.verticalSpace(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Image.asset('assets/images/facebook.png', height: 50, width: 50,),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      mediumText14(context,'Facebook Friends',
                                          maxLines: 1,overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w500),
                                      smallText12(context, 'find friends on facebook',textColor: const Color(0xff484848),
                                        maxLines: 1,overflow: TextOverflow.ellipsis,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SmallPinkButton( label: 'Find', fontSize: 14,
                            padding : EdgeInsets.symmetric(horizontal: 24, vertical: 4),),
                        ],
                      ),
                      UiHelper.verticalSpace(height: 24),
                      mediumText14(context, 'Suggested accounts',textColor: const Color(0xff484848),fontWeight: FontWeight.w500),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        MyInkWell(
                                            onTap:()async{
                                            //  CustomNavigator.push(context: context, screen: const OtherProfileDetails());
                                              PersistentNavBarNavigator.pushNewScreen(
                                                context,
                                                screen: const OtherProfileDetails(),
                                                withNavBar: false, // OPTIONAL VALUE. True by default.
                                                pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                              );
                                              },
                                            child: Image.asset(inboxData[index]['storyImage'], height: 50, width: 50,)),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              mediumText14(context,inboxData[index]['name'],
                                                  maxLines: 1,overflow: TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w500),
                                              smallText12(context, inboxData[index]['message'],  maxLines: 1,overflow: TextOverflow.ellipsis,),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SmallPinkButton(label: 'Follow',fontSize:12,
                                        onTap:(){print('hhhh');},
                                       ),
                                      const SizedBox(width: 6,),
                                      Image.asset('assets/images/clear.png',height: 20, width: 20),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                            ],
                          );
                        },
                      ),
                      UiHelper.verticalSpace(height: screenHeight*0.09),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

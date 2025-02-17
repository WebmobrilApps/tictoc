import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/screens/auth/forgot_password.dart';
import 'package:tictoc/screens/dummy/bardummu1.dart';
import 'package:tictoc/screens/profile/edit_profile.dart';
import 'package:tictoc/screens/profile/gallery_view.dart';
import 'package:tictoc/screens/profile/menu_profile_bottom.dart';
import 'package:tictoc/screens/profile/profile_views.dart';
import 'package:tictoc/screens/profile/share_profile.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:tictoc/screens/home/explore.dart';
import 'package:tictoc/screens/home/following.dart';
import 'package:tictoc/screens/home/foryou/for_you.dart';
import 'package:tictoc/screens/search/search_screen.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class Profile extends StatefulWidget {
  final PersistentTabController controller;
  const Profile({super.key, required this.controller});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List soundScreenData = [
    {"image":"assets/images/soundScreen1.png","likeCount":"203.2K"},
    {"image":"assets/images/soundScreen2.png","likeCount":"102.2K"},
    {"image":"assets/images/soundScreen3.png","likeCount":"328.2K"},
    {"image":"assets/images/soundScreen4.png","likeCount":"983.0K"},
    {"image":"assets/images/soundScreen5.png","likeCount":"324.11K"},
    {"image":"assets/images/soundScreen2.png","likeCount":"663.09K"},
    {"image":"assets/images/soundScreen1.png","likeCount":"203.2K"},
    {"image":"assets/images/soundScreen3.png","likeCount":"328.2K"},
    {"image":"assets/images/soundScreen4.png","likeCount":"983.0K"},
    {"image":"assets/images/soundScreen5.png","likeCount":"324.11K"},
    {"image":"assets/images/soundScreen1.png","likeCount":"203.2K"},
    {"image":"assets/images/soundScreen2.png","likeCount":"102.2K"},
    {"image":"assets/images/soundScreen3.png","likeCount":"328.2K"},
    {"image":"assets/images/soundScreen4.png","likeCount":"983.0K"},
    {"image":"assets/images/soundScreen5.png","likeCount":"324.11K"},
    {"image":"assets/images/soundScreen2.png","likeCount":"663.09K"},
    {"image":"assets/images/soundScreen1.png","likeCount":"203.2K"},
    {"image":"assets/images/soundScreen3.png","likeCount":"328.2K"},
    {"image":"assets/images/soundScreen4.png","likeCount":"983.0K"},
    {"image":"assets/images/soundScreen5.png","likeCount":"324.11K"},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0); // 3 tabs, "Following" as default
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
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
       // backgroundColor: whiteColor,
         //   backgroundColor: appBgColor,
        backgroundColor: appBgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiHelper.verticalSpace(height: screenHeight*0.075),
            Column(
              children: [
                Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        largeText16(context, 'UsernameTicToc',fontWeight: FontWeight.w500),
                        const SizedBox(width: 8,),
                        Image.asset('assets/images/down_arrow.png',height:18,width: 11,),
                       // Image.asset('assets/images/dropdownnn.png',height:14,width: 8,),
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
                                setState(() {
                                });
                                //      Navigator.pop(context); // Close the bottom sheet
                              }
                            },
                            child: Image.asset('assets/images/menu.png',height:26,width: 26,)),
                      ],
                    ),
                  ],
                ).pOnly(left: 20,right: 20),
                const SizedBox(height: 6,),
                Container(
                  color: const Color(0xffF2F2F2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UiHelper.verticalSpace(height: 10),
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
                      largeText16(context, 'UsernameTicToc',fontWeight: FontWeight.w500),
                      mediumText14(context, '@usernametictoc'),
                      UiHelper.verticalSpace(height: 10),
                      Row( mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              smallText12(context, '40.3K',fontWeight: FontWeight.w600),
                              smallText12(context, 'Followers',),
                            ],
                          ),
                          const SizedBox(width:40),
                          Column(
                            children: [
                              smallText12(context, '300',fontWeight: FontWeight.w600),
                              smallText12(context, 'Following',),
                            ],
                          ),
                          const SizedBox(width:40),
                          Column(
                            children: [
                              smallText12(context, '140,5K',fontWeight: FontWeight.w600),
                              smallText12(context, 'Likes',),
                            ],
                          ),
                        ],
                      ),
                      UiHelper.verticalSpace(height: 10),
                      Row( mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SmallPinkButton(onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: const EditProfile(),
                              withNavBar: false, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation: PageTransitionAnimation.cupertino,
                            );
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
                            widget.controller.jumpToTab(1);
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
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UiHelper.horizontalSpace(width: 18),
                Expanded(
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: const Color(0xff484848),
                    indicatorWeight: 2.0,
                    indicator:  UnderlineTabIndicator(
                      borderSide: const BorderSide(width: 3.0, color: Color(0xff484848)),
                     insets: const EdgeInsets.only(bottom: 6),
                      borderRadius:BorderRadius.circular(0.0), // Adjust if needed
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: GoogleFonts.jost(color: appGreyColor,fontSize: 16,fontWeight: FontWeight.w600),
                    unselectedLabelStyle: GoogleFonts.jost(color: appGreyColor,fontSize: 12,fontWeight: FontWeight.w600),
                    dividerColor:Colors.transparent,
                    padding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    tabs: [
                      Tab(icon:Image.asset('assets/images/gridicons_posts.png',width: 25,height: 21.32,)),
                      Tab(icon:Image.asset('assets/images/bookmark_grey.png',width: 25,height: 21.32,)),
                    ],
                  ),
                ),
                UiHelper.horizontalSpace(width: 18),
              ],
            ),
            const Divider(color: Color(0xffADADAD),thickness: 1.5,),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children:  [
                  // Center(child: Text('Explore Content', style: TextStyle(color: Colors.white))),
                  const GalleryView(),
                  Center(child: largeText16(context, 'Bookmark')),
                  //  ReelsScreen(),
                  // Center(child: Text('For You Content', style: TextStyle(color: Colors.white))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

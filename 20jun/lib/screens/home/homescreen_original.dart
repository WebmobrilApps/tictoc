import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/screens/home/explore.dart';
import 'package:tictoc/screens/home/following/following_feed.dart';
import 'package:tictoc/screens/home/foryou/for_you.dart';
import 'package:tictoc/screens/search/search_screen.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1); // 3 tabs, "Following" as default
    _tabController.addListener((){
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: bgColor, // Green status bar
        statusBarIconBrightness: Brightness.light, // Light icons for better contrast
      ),
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            UiHelper.verticalSpace(height: screenHeight * 0.06),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UiHelper.horizontalSpace(width: 22),
                      Column(
                        children: [
                          const SizedBox(height: 7,),
                          Image.asset('assets/images/live.png', width: 28, height: 28),
                          smallText12(context, 'Live', textColor: whiteColor, fontWeight: FontWeight.w600),
                        ],
                      ),
                      UiHelper.horizontalSpace(width: 18),
                      Expanded(
                        child: TabBar(
                          controller: _tabController,
                          indicator:  UnderlineTabIndicator(
                            borderSide: const BorderSide(width: 2.2, color: Colors.white),
                            insets: const EdgeInsets.only(bottom: 9,left: 3,right: 3),
                            borderRadius:BorderRadius.circular(0.0), // Adjust if needed
                          ),
                          indicatorColor: Colors.white,
                          indicatorWeight: 2.2,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey,
                          labelStyle: GoogleFonts.jost(color: whiteColor,fontSize: 16,fontWeight: FontWeight.w600),
                          unselectedLabelStyle: GoogleFonts.jost(color: whiteColor,fontSize: 12,fontWeight: FontWeight.w600),
                          dividerColor:Colors.transparent,
                          padding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,

                          tabs: const [
                            Tab(text: 'Explore'),
                            Tab(text: 'Following'),
                            Tab(text: 'For You'),
                          ],
                        ).pOnly(bottom:8),
                      ),
                      UiHelper.horizontalSpace(width: 18),
                      MyInkWell(
                          onTap: ()async{
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: const SearchScreen(),
                              withNavBar: false, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation: PageTransitionAnimation.cupertino,
                            );
                          },
                          child: Image.asset('assets/images/search.png', width: 26, height: 26)),
                      UiHelper.horizontalSpace(width: 20),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child:  _tabController.index==1?IntrinsicWidth(
                    child: Container(
                        padding:  const EdgeInsets.only(left:12,right:12,top:5.5,bottom: 5.5),
                        decoration:  BoxDecoration(
                          color:const Color(0xff3c3c3c),
                          borderRadius: BorderRadius.circular(66.67),),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            smallText12(context, '2 LIVE videos | Story ',textColor: whiteColor,fontSize: 6.67,),
                            UiHelper.horizontalSpace(width: 6),
                            Image.asset('assets/images/down.png',height: 8.5,width: 5.5,),
                          ],
                        )),
                  ):const SizedBox(),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  // Center(child: Text('Explore Content', style: TextStyle(color: Colors.white))),
                  Explore(),
                  FollowingFeed(),
                  ForYou(),
                  //SizedBox(),
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

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   String whichTab = "Following";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bgColor,
//       body: Column(
//         children: [
//           UiHelper.verticalSpace(height: screenHeight*0.06  ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               UiHelper.horizontalSpace(width: 24),
//               Column(
//                 children: [
//                   Image.asset('assets/images/live.png',width: 21,height: 25,),
//                   smallText12(context, 'Live',textColor: whiteColor,fontWeight: FontWeight.w600),
//                 ],
//               ),
//               UiHelper.horizontalSpace(width: 24),
//               mediumText14(context, 'Explore',textColor: whiteColor,fontSize: 12,fontWeight: FontWeight.w600),
//               UiHelper.horizontalSpace(width: 24),
//               mediumText14(context, 'Following',textColor: whiteColor,fontSize: 12,fontWeight: FontWeight.w600,decoration: TextDecoration.underline,),
//               UiHelper.horizontalSpace(width: 24),
//               mediumText14(context, 'For You',textColor: whiteColor,fontSize: 12,fontWeight: FontWeight.w600),
//               UiHelper.horizontalSpace(width: 24),
//               Image.asset('assets/images/search.png',width: 26,height: 26,),
//               UiHelper.horizontalSpace(width: 24),
//             ],
//           ),
//
//         ],
//       ),
//     );
//   }
// }



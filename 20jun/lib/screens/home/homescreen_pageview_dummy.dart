import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/screens/home/explore.dart';
import 'package:tictoc/screens/home/following/following_feed.dart';
import 'package:tictoc/screens/search/search_screen.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentIndex = 1; // Default to "Following" tab

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Pause video when switching from "For You" tab
  void _pauseForYouVideo() {
    if (_currentIndex == 2) {
      videoPauseStream.add(true); // Notify "For You" screen to pause video
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      // Pause video when switching away from "For You" tab
      if (_currentIndex == 2 && index != 2) {
        videoPauseStream.add(true); // Notify "For You" screen to pause video
      }
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: bgColor,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            UiHelper.verticalSpace(height: screenHeight * 0.06),

            /// Custom Tab Bar
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UiHelper.horizontalSpace(width: 22),
                      Column(
                        children: [
                          const SizedBox(height: 7),
                          Image.asset('assets/images/live.png', width: 28, height: 28),
                          smallText12(context, 'Live', textColor: whiteColor, fontWeight: FontWeight.w600),
                        ],
                      ),
                      UiHelper.horizontalSpace(width: 18),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildTabItem(0, "Explore"),
                            _buildTabItem(1, "Following"),
                            _buildTabItem(2, "For You"),
                          ],
                        ),
                      ),
                      UiHelper.horizontalSpace(width: 18),
                      MyInkWell(
                        onTap: () async {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: const SearchScreen(),
                            withNavBar: false,
                            pageTransitionAnimation: PageTransitionAnimation.cupertino,
                          );
                        },
                        child: Image.asset('assets/images/search.png', width: 26, height: 26),
                      ),
                      UiHelper.horizontalSpace(width: 20),
                    ],
                  ),
                ),
              ],
            ),

            /// PageView
            Expanded(
              child: PageView(
                controller: _pageController,
                pageSnapping: false,
                onPageChanged: _onPageChanged,
                children: [
                  Explore(),
                  FollowingFeed(),
                  //  ForYou(),
                  SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Custom Tab Bar Item
  Widget _buildTabItem(int index, String text) {
    return GestureDetector(
      onTap: () {
        // Pause the video if leaving "For You" tab
        if (_currentIndex == 2 && index != 2) {
          videoPauseStream.add(true);
        }

        // Change page
        _pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Column(
        children: [
          Text(
            text,
            style: GoogleFonts.jost(
              color: _currentIndex == index ? Colors.white : Colors.grey,
              fontSize: _currentIndex == index ? 16 : 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (_currentIndex == index)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 20,
              color: Colors.white,
            ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/screens/auth/forgot_password.dart';
import 'package:tictoc/screens/auth/sign_up.dart';
import 'package:tictoc/screens/dummy/blackbox.dart';
import 'package:tictoc/screens/friends/friends.dart';
import 'package:tictoc/screens/home/foryou/for_you.dart';
import 'package:tictoc/screens/home/homescreen.dart';
import 'package:tictoc/screens/inbox/inbox.dart';
import 'package:tictoc/screens/preload/home_page.dart';
import 'package:tictoc/screens/preload/preload_page.dart';
import 'package:tictoc/screens/profile/profile.dart';
import 'package:tictoc/screens/upload/upload_video.dart';
import 'package:tictoc/utils/bottommenuicons.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/login_required_bottomsheet.dart';
import 'package:tictoc/utils/shared_preference.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';

class PersistentCustomBottomMenu extends StatefulWidget {
  final int initialIndex;

  const PersistentCustomBottomMenu({super.key, required this.initialIndex});

  @override
  State<PersistentCustomBottomMenu> createState() => _PersistentCustomBottomMenuState();
}

class _PersistentCustomBottomMenuState extends State<PersistentCustomBottomMenu> {
  int _currentIndex = 0;

  PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  ScrollController _scrollController = ScrollController();

  DateTime? lastPressed;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _controller = PersistentTabController(initialIndex: _currentIndex);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> buildScreens() {
      return  [
        const HomeScreen(),
        const Friends(),
        // MyApp(),
        //    PreloadPage(),
        //   githuvVideo(),
        // ForYou(controller: _controller),
        //   UploadVideo(controller: _controller), // Pass the controller here
        Container(),
        //    CameraScreen(),
        isGuest == false ? Inbox(controller: _controller) : Container(),// Prevent guest from accessing
        //  ReelsScreen(),
        isGuest == false ? Profile(controller: _controller) : Container(), // Prevent guest from accessing

      ];
    }
    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: ImageIcon(const AssetImage('assets/images/home.png'),color: _currentIndex==0?const Color(0XFFFFFFFF):appBlackColor),
          inactiveIcon: ImageIcon(const AssetImage('assets/images/home.png'),color: _currentIndex==0?const Color(0XFFFFFFFF):appBlackColor),
          iconSize: 28,
          title:'Home',
          textStyle:GoogleFonts.jost(fontSize: 10,fontWeight: FontWeight.w500,color: const Color(0xff0B0B0B)),
          activeColorPrimary: buttonColor,
          inactiveColorPrimary: const Color(0xff0B0B0B),
        ),
        PersistentBottomNavBarItem(
          icon:  ImageIcon(const AssetImage('assets/images/friends.png',),color: _currentIndex==0?const Color(0XFFFFFFFF):appBlackColor),
          inactiveIcon:  ImageIcon(const AssetImage('assets/images/friends.png'),color: _currentIndex==0?const Color(0XFFFFFFFF):appBlackColor),
          iconSize: 33,
          title:'Friends',
          textStyle:GoogleFonts.jost(fontSize: 10,fontWeight: FontWeight.w500,color: const Color(0xff0B0B0B)),
          activeColorPrimary: buttonColor,
          inactiveColorPrimary: const Color(0xff0B0B0B),
        ),
        /*   PersistentBottomNavBarItem(
          icon: const Icon(Icons.add , color: Colors.white , size: 33),
          activeColorPrimary: const Color(0xffFF0236),
          inactiveColorPrimary: Colors.white,
        ),*/
        PersistentBottomNavBarItem(
          icon: Image.asset('assets/images/menuPlus.png', width: 50, height: 38,).pOnly(bottom: 8),
          activeColorPrimary: buttonColor,
          inactiveColorPrimary: Colors.white,
          onPressed: (context) {

            Navigator.of(context ?? this.context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (_) => UploadVideo(controller: _controller), // ✅ Ensure `_controller` is not null
              ),
            );
          },
        ),
        PersistentBottomNavBarItem(
          icon:  ImageIcon(const AssetImage('assets/images/inbox.png'),color: _currentIndex==0?const Color(0XFFFFFFFF):appBlackColor),
          inactiveIcon:  ImageIcon(const AssetImage('assets/images/inbox.png'),color: _currentIndex==0?const Color(0XFFFFFFFF):appBlackColor),
          iconSize: 30,
          title:'Inbox',
          textStyle:GoogleFonts.jost(fontSize: 10,fontWeight: FontWeight.w500,color: const Color(0xff0B0B0B)),
          activeColorPrimary: buttonColor,
          inactiveColorPrimary: const Color(0xff0B0B0B),
        ),
        PersistentBottomNavBarItem(
          icon:  ImageIcon(const AssetImage('assets/images/profile.png'),color: _currentIndex==0?const Color(0XFFFFFFFF):appBlackColor),
          inactiveIcon:  ImageIcon(const AssetImage('assets/images/profile.png'),color: _currentIndex==0?const Color(0XFFFFFFFF):appBlackColor),
          iconSize: 30,
          title:'Profile',
          textStyle:GoogleFonts.jost(fontSize: 10,fontWeight: FontWeight.w500,color: const Color(0xff0B0B0B)),
          activeColorPrimary: buttonColor,
          inactiveColorPrimary: const Color(0xff0B0B0B),
        ),
      ];
    }


    return WillPopScope(
      onWillPop: () async {
        if (_controller.index == 0) {
          DateTime now = DateTime.now();
          if (lastPressed == null || now.difference(lastPressed!) > const Duration(seconds: 2)) {
            lastPressed = now;
            UiHelper.toastMessage("Tap again to exit",timeInSecForIosWeb:2);
            return false;
          }
          // Exit app if double-tapped within 2 seconds
          SystemNavigator.pop();
          return true;
        } else {
          _controller.jumpToTab(0);
          return false;
        }
      },
      child: Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: buildScreens(),
          margin: const EdgeInsets.symmetric(horizontal: 14 , vertical: 2 ),
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 2 ),
          navBarStyle : NavBarStyle.style13,
          items: navBarsItems(),
          confineToSafeArea: true,
          // backgroundColor: const Color(0XFFFFFFFF),
          backgroundColor: _currentIndex==0?appBlackColor:const Color(0XFFFFFFFF),
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardAppears: true,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(30.0),
            colorBehindNavBar: Colors.white,
            boxShadow: [
              BoxShadow(
                color:  const Color(0xff555E68).withOpacity(0.15), // Specify color and opacity
                spreadRadius: 0,
                blurRadius: 1,
                offset: const Offset(0, 2.5), // Offset for bottom shadow
              ),
              BoxShadow(
                color:  const Color(0xff555E68).withOpacity(0.15), // Specify color and opacity
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(1, 2.5), // Offset for bottom shadow
              ),
            ],
          ),
          onItemSelected: (index) async {
            bool connected = await isConnected();
            if (connected) {
              setState(() {
                if (index == 4 || index == 3) { // Assuming Profile is at index 4
                  if (isGuest) {
                    LoginRequiredBottomSheet.show(context,);
                    _controller.jumpToTab(_currentIndex); // Prevent navigation
                  }
                }
                else {
                  _currentIndex = index;
                }
              });
            } else {
              _controller.jumpToTab(_currentIndex);
              UiHelper.toastMessage(notConnected);
            }
          },

        ),
      ),
    );
  }


}

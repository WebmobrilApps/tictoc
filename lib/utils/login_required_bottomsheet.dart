import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/screens/auth/sign_up.dart';
import 'package:tictoc/screens/bottomnavigationbar/bottomnavigation.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/shared_preference.dart';

class LoginRequiredBottomSheetWidget extends StatefulWidget {
  final PersistentTabController? controller;
  final VoidCallback? onLogin;
  final String? fromPage;

  const LoginRequiredBottomSheetWidget({super.key, this.onLogin, this.controller, this.fromPage});

  @override
  State<LoginRequiredBottomSheetWidget> createState() => _LoginRequiredBottomSheetWidgetState();
}

class _LoginRequiredBottomSheetWidgetState extends State<LoginRequiredBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevents closing on back button press
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.lock, size: 50, color: Colors.redAccent),
            const SizedBox(height: 16),
            largeText16(context,"Login Required",fontSize: 18, fontWeight: FontWeight.bold,textColor: appBlackColor),
            const SizedBox(height: 12),
            mediumText14(context,
              "To access this functionality, please login or sign up.",
                fontSize: 14,textColor: appBlackColor,
            ),
            const SizedBox(height: 30),
            pinkButton(context: context, labelText: 'Sign UP',
              onTap: () {
                Navigator.pop(context);
                isGuest = false;
                PreferenceManager.clearPreferences();
                CustomNavigator.pushAndRemoveUntil(context: context, screen: const SignUp());
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if(widget.fromPage=="uploadVideo"){
                  Navigator.pop(context);
                }
               // widget.controller?.jumpToTab(0);
               // CustomNavigator.pushAndRemoveUntil(context: context, screen: const PersistentCustomBottomMenu(initialIndex:0));
              },
              child: Text("Cancel", style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginRequiredBottomSheet {
  static void show(BuildContext context, {VoidCallback? onLogin,String? fromPage}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
        isDismissible:false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => LoginRequiredBottomSheetWidget(onLogin: onLogin,fromPage:fromPage),
    );
  }
}

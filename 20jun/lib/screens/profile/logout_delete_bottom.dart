import 'package:flutter/material.dart';
import 'package:tictoc/screens/auth/sign_in.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/shared_preference.dart';
import 'package:tictoc/utils/ui_helper.dart';

class LogoutDeleteBottom extends StatefulWidget {
  final String fromMenu;
  const LogoutDeleteBottom({super.key, required this.fromMenu});

  @override
  State<LogoutDeleteBottom> createState() => _LogoutDeleteBottomState();
}

class _LogoutDeleteBottomState extends State<LogoutDeleteBottom> {

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      reverse: true,
      child: IntrinsicHeight(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            bottom: keyboardHeight, // Add padding for the keyboard
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top:12,left: 28, right: 28, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UiHelper.verticalSpace(height: 12),
                largeText16(context, widget.fromMenu=="logout"?'Logout':'Delete Account',fontWeight: FontWeight.w600,textColor: const Color(0xff404040)),
                UiHelper.verticalSpace(height: 18),
                mediumText14(context,  widget.fromMenu=="logout"?'Are you sure you want to logout?':'Are you sure you want to Delete your account permanently?',
                    textAlign: TextAlign.center,fontWeight: FontWeight.w500,textColor: const Color(0xff404040)),
                UiHelper.verticalSpace(height: 40),

                Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmallPinkButton(label: 'Yes',fontSize:16,fontWeight: FontWeight.w500,
                      padding :const EdgeInsets.symmetric(horizontal: 38, vertical: 4),
                      borderRadius: const BorderRadius.all(Radius.circular(22.5),),
                      onTap: (){
                        PreferenceManager.clearPreferences();
                    //    UiHelper.toastMessage(widget.fromMenu=="logout"?'Logout Successfully':'Account Deleted Successfully');
                        CustomNavigator.pushAndRemoveUntil(context: context, screen: const SignIn());
                      },
                    ),
                    const SizedBox(width: 60,),
                    SmallPinkButton(label: 'No',fontSize:16,fontWeight: FontWeight.w500,
                      backgroundColor:Colors.white,textColor:buttonColor,
                      border: Border.all(color: buttonColor, width: 1.0),
                      padding :const EdgeInsets.symmetric(horizontal: 38, vertical: 4),
                      borderRadius: const BorderRadius.all(Radius.circular(22.5),),
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                UiHelper.verticalSpace(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
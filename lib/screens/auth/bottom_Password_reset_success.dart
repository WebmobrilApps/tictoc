import 'package:flutter/material.dart';
import 'package:tictoc/screens/auth/sign_in.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class BottomPasswordResetSuccess extends StatefulWidget {
  const BottomPasswordResetSuccess({super.key});

  @override
  State<BottomPasswordResetSuccess> createState() => _BottomPasswordResetSuccessState();
}

class _BottomPasswordResetSuccessState extends State<BottomPasswordResetSuccess> {
  bool isHideHistory = false;
  final animationDuration = const Duration(milliseconds: 300);
  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      reverse: true,
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25), // Outer spacing
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              bottom: keyboardHeight, // Add padding for the keyboard
            ),
            decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
          //    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UiHelper.verticalSpace(height: 24),
                  largeText16(context, '"Congratulation!”', fontSize: 20, fontWeight: FontWeight.w600),
                  UiHelper.verticalSpace(height: 16),
                  largeText16(context, 'Now you are part of \n the Worlds Amazing Platform ',textAlign: TextAlign.center,lineHeight: 1.4),
                  UiHelper.verticalSpace(height: 18),
                  largeText16(context, 'Your Password has been Updated',),
                  UiHelper.verticalSpace(height: 32),
                  pinkButton(context: context,
                      onTap: (){
                        Navigator.of(context).pop();
                        CustomNavigator.pushAndRemoveUntil(context: context, screen: const SignIn());
                      },
                      labelText:'Done')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
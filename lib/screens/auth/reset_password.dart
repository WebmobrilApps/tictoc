import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/screens/auth/bottom_Password_reset_success.dart';
import 'package:tictoc/screens/auth/otp_verification.dart';
import 'package:tictoc/screens/auth/sign_in.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _isPasswordVisible1 = false;
  bool _isPasswordVisible2 = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
          //    height: screenHeight * 0.73,
              decoration: const BoxDecoration(
                  color:bgColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  )
              ),
              child: Padding(
            //    padding: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.only(left: 26,right: 26,bottom: 24,top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height:screenHeight*0.07,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyInkWell(
                            onTap:()async{
                              Navigator.of(context).pop();
                            },
                            child: Image.asset('assets/images/back_arrow.png',height: 28,width: 28,)),
                        Image.asset('assets/images/logo.png',height: 135,width: 135,).pOnly(right:20),
                        const SizedBox(),
                      ],
                    ),
                  //  UiHelper.verticalSpace(height: 28),
                    UiHelper.verticalSpace(height: screenHeight*0.040),
                    largeText16(context,'Update Password', fontWeight:FontWeight.w600,fontSize: 20,textColor: Colors.white),
                    UiHelper.verticalSpace(height: 8),
                    mediumText14(context,'Create Your New Password',textColor: Colors.white,fontWeight:FontWeight.w400),
                    UiHelper.verticalSpace(height: screenHeight*0.091),
                    TextFormFieldWithLabel(
                      controller: newPasswordController,
                      obscureText: !_isPasswordVisible1,
                      label: "New Password",
                      hintText: '*********',
                      textInputAction:TextInputAction.done,
                      suffixIcon: UnconstrainedBox(
                        child: IconButton(
                          highlightColor:Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: _isPasswordVisible1 ?customImageAsset(imagePath: 'assets/images/eye_show.png',height: 22,width: 22):
                          customImageAsset(imagePath: 'assets/images/eye_off.png',height: 22,width: 22),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible1 = !_isPasswordVisible1;
                            });
                          },
                        ),
                      ),
                    ),
                    UiHelper.verticalSpace(height: 20),
                    TextFormFieldWithLabel(
                      controller: confirmPasswordController,
                      obscureText: !_isPasswordVisible2,
                      label: "Confirm Password",
                      hintText: '*********',
                      textInputAction:TextInputAction.done,
                      suffixIcon: UnconstrainedBox(
                        child: IconButton(
                          highlightColor:Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: _isPasswordVisible2 ?customImageAsset(imagePath: 'assets/images/eye_show.png',height: 22,width: 22):
                          customImageAsset(imagePath: 'assets/images/eye_off.png',height: 22,width: 22),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible2 = !_isPasswordVisible2;
                            });
                          },
                        ),
                      ),
                    ),
                    UiHelper.verticalSpace(height: screenHeight*0.069),
                    poppinsSmall12(context,
                     //   '(Password must be at min 8 characters with 1 special \n character, 2 numbers, 1 uppercase, and 2 lowercase letters.)',
                        '(Password must be at min 8 characters with 1 special character, 2 numbers, 1 uppercase, and 2 lowercase letters.)',
                        fontSize: 10,
                        textColor: Colors.white,
                        textAlign: TextAlign.center),
                 //   UiHelper.verticalSpace(height: 10),
                  ],
                ),
              ),
            ),
            UiHelper.verticalSpace(height: 34),
            pinkButton(context: context,
                onTap: ()async{
                  final result = await showModalBottomSheet<bool>(
                    isScrollControlled: true,
                    useRootNavigator: true,
                    context: context,
                    backgroundColor: Colors.transparent, // Set the background to transparent
                    builder: (context) => const BottomPasswordResetSuccess(),
                  );
                  if (result != null) {
                    setState(() {
                      //  selectedImage = image;
                    });
                    //      Navigator.pop(context); // Close the bottom sheet
                  }
                },
               /* onTap: (){
                  _freeTrialLinkDialog(context);
                },*/
                labelText:'Continue',width: 285),
            UiHelper.verticalSpace(height: 20),
          ],
        ),
      ),
    );
  }
  void _freeTrialLinkDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            elevation: 0,
            insetPadding: const EdgeInsets.all(30),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
            titlePadding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 12),
            contentPadding: const EdgeInsets.only(left: 20, right: 20),
            alignment: Alignment.center,
            title: Center(child: largeText16(context, '"Congratulation!”', fontSize: 20, fontWeight: FontWeight.w600)),
            actionsOverflowButtonSpacing: 6.0,
            content: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
            actions: <Widget>[],
          );
        });
      },
    );
  }
}

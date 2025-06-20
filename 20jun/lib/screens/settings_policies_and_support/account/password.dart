import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tictoc/screens/auth/reset_password.dart';
import 'package:tictoc/screens/auth/sign_in.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:velocity_x/velocity_x.dart';
class Password extends StatefulWidget {
  const Password({super.key});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  TextEditingController textEditingController = TextEditingController();
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  String resendOtpToken = "";


  int remainingTime = 30; // 5 minutes in seconds
  late Timer countdownTimer;
  bool isResendButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    setState(() {
      isResendButtonEnabled = false;
      remainingTime = 30;
    });

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel();
        setState(() {
          isResendButtonEnabled = true;
        });
      }
    });
  }
  @override
  void dispose() {
    //  textEditingController.dispose();
    countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: "Password"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:18,left:18,right: 18),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xffF2F2F2),
                ),
                child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    largeText16(context, 'Enter 6 - digit code',
                        fontWeight: FontWeight.w500,textColor: const Color(0xff404040)),
                    const SizedBox(height: 6,),
                    mediumText14(context, 'To set your password, enter the 6 - digit code\nemailed to k*****m@gamil.com',
                        textColor: const Color(0xff86878B)),
                    const SizedBox(height: 12,),
                   PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: const TextStyle(
                          color:appBlackColor
                      ),
                      length: 6,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                      obscureText: true,
                      obscuringCharacter: '*',
                      blinkWhenObscuring: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        activeColor: const Color(0xffC4C4C4),
                        activeFillColor: const Color(0xffC4C4C4),
                        disabledColor: const Color(0xffC4C4C4),
                        selectedColor: const Color(0xffC4C4C4),
                        selectedFillColor: const Color(0xffC4C4C4),
                        // inactiveColor: Colors.grey,
                        inactiveColor: const Color(0xffC4C4C4),
                        borderWidth: 1.0,
                        shape: PinCodeFieldShape.underline,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 50,
                        fieldWidth: screenHeight>720?45:40,
                      ),
                      cursorColor: buttonColor,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: false,
                      //   errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      textStyle: GoogleFonts.jost(fontSize: 20,color: appBlackColor),
                      onCompleted: (v) {
                        debugPrint("Completed");
                      },
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        return true;
                      },
                    ).pOnly(left: 6,right: 6),
                    MyInkWell(
                      onTap:()async{
                        if (isResendButtonEnabled) {
                          // Your logic to resend the OTP
                        //  resendOtp();
                          UiHelper.toastMessage("OTP resent successfully");
                          // Restart the countdown
                          startCountdown();
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //state.status == SpotsBallStatus.resendVerifyOTPLoading?
                          // const SizedBox(height:25,width:25,child: CircularProgressIndicator(color: Color(0xff009E49),strokeWidth: 3.0,)):
                          isResendButtonEnabled?mediumText14(context, 'Resend Code  ',
                              fontWeight: FontWeight.w500,
                              textColor: isResendButtonEnabled?buttonColor:buttonColor):const SizedBox(),
                          isResendButtonEnabled?const SizedBox():mediumText14(context, "${formatTime(remainingTime)} S", textColor: const Color(0xff484848)),
                        ],
                      ),
                    ),
                    UiHelper.verticalSpace(height: 25),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
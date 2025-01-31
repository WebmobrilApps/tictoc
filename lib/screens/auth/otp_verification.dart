import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tictoc/screens/auth/reset_password.dart';
import 'package:tictoc/screens/auth/sign_in.dart';
import 'package:tictoc/screens/bottomnavigationbar/bottomnavigation.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class OtpVerification extends StatefulWidget {
  final String fromPage;
  const OtpVerification({super.key, required this.fromPage});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {

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
  void resendOtp() {
    // Add the API call or logic to resend the OTP
    debugPrint("OTP resent successfully!");
    UiHelper.toastMessage("OTP resent successfully");
  }


  @override
  void dispose() {
  //  textEditingController.dispose();
    countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus( FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: whiteColor,
        body:  SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
             //  height: screenHeight * 0.73,
                decoration: const BoxDecoration(
                    color:bgColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 26,right: 26,top: 10),
                  child: Column(
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
                      UiHelper.verticalSpace(height: screenHeight*0.070),
                      largeText16(context, 'Verification', fontSize: 20,
                          textColor: whiteColor,
                          fontWeight: FontWeight.w600, textAlign: TextAlign.center),
                      const SizedBox(height: 2,),
                      mediumText14(context, 'Please Enter The 4 Digit Code Sent To \n Your Email',
                          textAlign: TextAlign.center,textColor: whiteColor),
                      const SizedBox(height: 35,),
                      Column(
                        children: [
                          const SizedBox(height: 30,),
                          Padding(
                            padding: const EdgeInsets.only(left: 40, right: 40),
                            child: PinCodeTextField(
                              appContext: context,
                              pastedTextStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              length: 4,
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
                                fieldWidth: 50,
                              ),
                              cursorColor: const Color(0xffFFFFFF),
                              animationDuration: const Duration(milliseconds: 300),
                              enableActiveFill: false,
                              //   errorAnimationController: errorController,
                              controller: textEditingController,
                              keyboardType: TextInputType.number,
                              textStyle: GoogleFonts.jost(fontSize: 20,color: whiteColor),
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
                            ),
                          ),

                          MyInkWell(
                            onTap:()async{
                              if (isResendButtonEnabled) {
                                // Your logic to resend the OTP
                                resendOtp();

                                // Restart the countdown
                                startCountdown();
                              }

                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                 //state.status == SpotsBallStatus.resendVerifyOTPLoading?
                                 // const SizedBox(height:25,width:25,child: CircularProgressIndicator(color: Color(0xff009E49),strokeWidth: 3.0,)):
                                  isResendButtonEnabled? smallText12(context,
                                      'Resend OTP',fontWeight: FontWeight.w500,
                                      textColor: isResendButtonEnabled?const Color(0xffFFFFFF):Colors.white):
                                  smallText12(context,
                                      '${formatTime(remainingTime)}',fontWeight: FontWeight.w500,
                                      textColor: isResendButtonEnabled?const Color(0xffFFFFFF):Colors.white),
                                ],
                              ),
                            ),
                          ),
                          UiHelper.verticalSpace(height: 40),

                        ],
                      ),
                   // UiHelper.verticalSpace(height: 85),
                      UiHelper.verticalSpace(height: screenHeight*0.1),

                    ],
                  ),
                ),
              ),
              UiHelper.verticalSpace(height: 36),
              pinkButton(
                  width: 285, context: context, labelText: widget.fromPage=="ForgotPassword"?'Verify':'Continue',
                  //    isLoading:widget.fromPage=="ForgotPassword"?state.status == SpotsBallStatus.forgotOtpVerifyLoading:state.status == SpotsBallStatus.registerVerifyOTPLoading,
                  onTap: (){
                    if(currentText.isEmpty){
                      UiHelper.toastMessage("Please Enter An OTP");
                    }
                    else if(currentText.length != 4){
                      UiHelper.toastMessage("OTP Should Be Of Four Digits");
                    }else{
                      String otp = currentText.toString();
                      print("otp:$otp");
                      if(widget.fromPage=="ForgotPassword"){
                        CustomNavigator.push(context: context, screen: const ResetPassword());
                      }else{
                     //   CustomNavigator.pushAndRemoveUntil(context: context, screen: const SignIn());
                        CustomNavigator.pushAndRemoveUntil(context: context, screen: const PersistentCustomBottomMenu(initialIndex:0));
                      }

                      /*  if(widget.fromPage=="ForgotPassword"){
                                    BlocProvider.of<SpotsBallCubit>(context).forgotOtpVerifyCall(otp,resendOtpToken.isEmpty?widget.token??'':resendOtpToken);
                                  }else{
                                    BlocProvider.of<SpotsBallCubit>(context).registerOTPVerifyCall(otp,resendOtpToken.isEmpty?widget.token??'':resendOtpToken);
                                  }*/
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

}
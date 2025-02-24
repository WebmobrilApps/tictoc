import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/screens/auth/otp_verification.dart';
import 'package:tictoc/screens/auth/sign_up.dart';
import 'package:tictoc/screens/dummy/dummy_for.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  bool _isChecked1 = false;
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
           //   height: screenHeight * 0.73,
              decoration: const BoxDecoration(
                  color:bgColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  )
              ),
              child: Padding(
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
                    UiHelper.verticalSpace(height: 48),
                    largeText16(context,'Forgot Password',fontWeight:FontWeight.w600,fontSize: 20,textColor: whiteColor),
                    UiHelper.verticalSpace(height: 5),
                    mediumText14(context,'Please Enter Your Email Address or Phone Number',
                        fontWeight:FontWeight.w400,fontSize: 14,textColor: whiteColor,textAlign: TextAlign.center),
                    UiHelper.verticalSpace(height: 5),
                    smallText12(context,'(The Email Address or Phone Number Should Be The Same \n When You Used To SIGN UP)',
                        fontWeight:FontWeight.w500,fontSize: 10,textColor: whiteColor,textAlign: TextAlign.center),
                    UiHelper.verticalSpace(height: screenHeight*0.07),
                    TextFormFieldWithLabel(
                      controller: emailController,
                      label: "Email ID/Phone Number",
                      hintText: 'Email/Phone Number',
                      textInputAction:TextInputAction.next,
                 //     keyboardType: TextInputType.emailAddress,
                    ),
                    UiHelper.verticalSpace(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 16,
                          width: 16,
                          child: Transform.scale(
                            scale: 1.0,
                            child: Checkbox(
                              value: _isChecked1,
                              checkColor:const Color(0xffFFFFFF),
                              onChanged: (bool? value) {
                                setState(() {
                                  //  _isChecked1 = value ?? false;
                                  _isChecked1 = !_isChecked1;
                                });
                              },
                              activeColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              side: WidgetStateBorderSide.resolveWith(
                                    (states) => const BorderSide(
                                    width: 1.0, color: Color(0xffFFFFFF)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: smallText12(context, 'If You Need Update Password Via Email or Phone Number Please Check The Box',
                              textColor: Colors.white,
                          fontSize: 10,fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    UiHelper.verticalSpace(height: screenHeight*0.1),
                    poppinsSmall12(context,
                        //'(Password must be at min 8 characters with 1 special \n character, 2 numbers, 1 uppercase, and 2 lowercase letters.)',
                        '(Password must be at min 8 characters with 1 special character, 2 numbers, 1 uppercase, and 2 lowercase letters.)',
                        textColor: Colors.white, fontSize: 10,
                        textAlign: TextAlign.center),

                  //  UiHelper.verticalSpace(height: 12),

                    /*    customTextField(height:90,hintText: 'thiru@gmail.com',
                      controller: emailController,
                    contentPadding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 12),
                    ),*/

                  ],
                ),
              ),
            ),
            UiHelper.verticalSpace(height: 34),
            pinkButton(context: context,
                onTap: (){
                 CustomNavigator.push(context: context, screen: const OtpVerification(fromPage: 'ForgotPassword',));
                //  CustomNavigator.push(context: context, screen: const DummyFor(fromPage:'ForgotPassword' ,));
                },
                labelText:'Continue',width: 285),
            UiHelper.verticalSpace(height: 20),
          ],
        ),
      ),
    );
  }
}
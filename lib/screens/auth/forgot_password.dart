import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/forgot_password_response.dart';
import 'package:tictoc/screens/auth/otp_verification.dart';
import 'package:tictoc/screens/auth/sign_up.dart';
import 'package:tictoc/screens/auth/widgets/common_auth_widgets.dart';
import 'package:tictoc/screens/dummy/dummy_for.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
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
  TextEditingController emailOrPhoneController = TextEditingController();
  bool _isChecked1 = false;
  void validateAndSubmit() {
    String input = emailOrPhoneController.text.trim();
    final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    final RegExp phoneRegex = RegExp(r'^(?!0+$)\d{5,15}$');

    if (input.isEmpty) {
      UiHelper.toastMessage(PLEASE_ENTER_EMAIL_OR_PHONENUMBER);
      return;
    }

    bool isEmailValid = emailRegex.hasMatch(input);
    bool isPhoneValid = phoneRegex.hasMatch(input);

    if (!isEmailValid && !isPhoneValid) {
      UiHelper.toastMessage(PLEASE_ENTER_VALID_EMAIL_OR_PHONENUMBER);
      return;
    }

    // Proceed with API call if either email or phone number is valid
    BlocProvider.of<TicTocCubit>(context).forgotPasswordCall(input);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: whiteColor,
      body: BlocConsumer<TicTocCubit,TicTocState>(
        listener: (context,state){
          if (state.status == TicTocStatus.forgotPasswordSuccess){
            ForgotPasswordResponse forgotPasswordResponse = state.responseData?.response as ForgotPasswordResponse;
            UiHelper.toastMessage(forgotPasswordResponse.msg??'');
            emailOrPhoneController.clear();
            CustomNavigator.push(context: context, screen: OtpVerification(fromPage: 'ForgotPassword',
                tempToken:forgotPasswordResponse.data?.tempToken??'',
                tmpOtp:forgotPasswordResponse.data?.otp.toString()??'',
            ));
          /*  CustomNavigator.push(context: context, screen:  OtpScreen(token:forgotPasswordResponse.data?.token??'',
              email: emailPhoneController.text,fromPage: "ForgotPassword",));*/
          }
          else if (state.status == TicTocStatus.forgotPasswordError){
            print(state.errorData?.message);
            String message = state.errorData?.message ?? state.error ?? "";
            UiHelper.toastMessage(message);
          }
        },
        builder: (context,state){
          return SingleChildScrollView(
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
                          controller: emailOrPhoneController,
                          label: "Email ID/Phone Number",
                          hintText: 'Email/Phone Number',
                          maxLength: 50,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'\s')), // Prevents spaces
                            LengthLimitingTextInputFormatter(50), // Strictly limits input to 50 characters
                          ],
                          textInputAction:TextInputAction.done,
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
                        const PasswordRequirementText(),
                      ],
                    ),
                  ),
                ),
                UiHelper.verticalSpace(height: 34),
                pinkButton(context: context,
                    isLoading: state.status == TicTocStatus.forgotPasswordLoading,
                  /*  onTap: (){

                      String input = emailOrPhoneController.text.trim();

                      // Regular expression for email validation
                      final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

                      // Regular expression for phone number validation (exactly 10 digits)
                      final RegExp phoneRegex = RegExp(r'^\d{10}$');

                      if (input.isEmpty) {
                        UiHelper.toastMessage("Please enter Email or Phone Number");
                        return;
                      }

                      bool isEmailValid = emailRegex.hasMatch(input);
                      bool isPhoneValid = phoneRegex.hasMatch(input);

                      if (!isEmailValid && !isPhoneValid) {
                        UiHelper.toastMessage("Enter a valid Email or a valid Phone Number");
                        return;
                      }

                      if(emailOrPhoneController.text.isEmpty){
                        UiHelper.toastMessage(PLEASE_ENTER_EMAIL_OR_PHONENUMBER);
                      }else{
                        BlocProvider.of<TicTocCubit>(context).forgotPasswordCall(emailOrPhoneController.text);
                      }

                      //  CustomNavigator.push(context: context, screen: const DummyFor(fromPage:'ForgotPassword' ,));
                    },*/
                    onTap: validateAndSubmit,
                    labelText:'Continue',width: 285),
                UiHelper.verticalSpace(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
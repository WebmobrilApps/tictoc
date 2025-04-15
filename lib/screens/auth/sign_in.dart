import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/guest_login_response.dart';
import 'package:tictoc/model/sign_in_response.dart';
import 'package:tictoc/screens/auth/forgot_password.dart';
import 'package:tictoc/screens/auth/interest.dart';
import 'package:tictoc/screens/auth/otp_verification.dart';
import 'package:tictoc/screens/auth/sign_up.dart';
import 'package:tictoc/screens/auth/widgets/common_auth_widgets.dart';
import 'package:tictoc/screens/bottomnavigationbar/bottomnavigation.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/shared_preference.dart';
import 'package:tictoc/utils/ui_helper.dart';

import '../../main.dart';
class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailOrPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible1 = false;

  @override
  void initState() {
    // TODO: implement initState
    passwordController.text = "Thiru@003";
    _fetchDeviceId();

    super.initState();
  }
  Future<void> _fetchDeviceId() async {
    String? id = await getDeviceId();
    deviceId = id;
    print('deviceId:$deviceId');
  }
  @override
  void dispose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  void _clearControllers() {
    emailOrPhoneController.clear();
    passwordController.clear();
    FocusScope.of(context).unfocus(); // Remove focus from text fields
  }
  void _validateAndSubmit() {
    String input = emailOrPhoneController.text.trim();
    String password = passwordController.text.trim();

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    final phoneRegex = RegExp(r'^(?!0+$)\d{5,15}$');

    if (input.isEmpty) {
      return UiHelper.toastMessage(PLEASE_ENTER_EMAIL_OR_PHONENUMBER);
    }
    if (!emailRegex.hasMatch(input) && !phoneRegex.hasMatch(input)) {
      return UiHelper.toastMessage(PLEASE_ENTER_VALID_EMAIL_OR_PHONENUMBER);
    }
    if (password.isEmpty) {
      return UiHelper.toastMessage(PLEASE_ENTER_PASSWORD);
    }

    Map<String, dynamic> signInDetails = {
      "username": input,
      "password": password,
    };
    print('SignIn Details: $signInDetails');
    BlocProvider.of<TicTocCubit>(context).signInCall(signInDetails);
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: bgColor, // Green status bar
        statusBarIconBrightness: Brightness.light, // Light icons for better contrast
      ),
      child: Scaffold(
        backgroundColor: whiteColor,
        body: BlocConsumer<TicTocCubit,TicTocState>(
          listener: (context,state){
            if (state.status == TicTocStatus.signInSuccess){
              SignInResponse signInResponse = state.responseData?.response as SignInResponse;
              emailOrPhoneController.clear();
              passwordController.clear();
              if(signInResponse.data?.user?.isVerify != 1){
                print('Not verified');
                CustomNavigator.push(
                  context: context,
                  screen: OtpVerification(fromPage: 'signIn',tempToken:signInResponse.data?.tempToken??'',
                    tmpOtp:signInResponse.data?.otp.toString()??'',
                  ),
                );
              }else if(signInResponse.data?.interest==false){
                print('No interest');
                CustomNavigator.pushAndRemoveUntil(context: context,
                    screen: Interest(tmpToken: signInResponse.data?.token??'',
                        userID:signInResponse.data?.user?.pkUser??0));
              }else{
                setState(() {
                  loginValue = true;
                });
                PreferenceManager.insertValue(key: TOKEN, value: signInResponse.data?.token.toString());
                PreferenceManager.insertValue(key: PHONE_NO, value: signInResponse.data?.user?.phone.toString());
                PreferenceManager.insertValue(key: EMAIL_ID, value: signInResponse.data?.user?.email.toString());
                PreferenceManager.insertValue(key: USER_ID, value: signInResponse.data?.user?.pkUser);
                userID = PreferenceManager.getIntegerValue(key: USER_ID) ?? 0;
                CustomNavigator.pushAndRemoveUntil(context: context, screen: const PersistentCustomBottomMenu(initialIndex:0));
              }
            }
            else if (state.status == TicTocStatus.guestLoginSuccess){
              GuestLoginResponse guestLoginResponse = state.responseData?.response as GuestLoginResponse;
              isGuest = true;
              PreferenceManager.insertValue(key: ISGUEST, value: true);
              if(guestLoginResponse.interest==false){
                 CustomNavigator.pushAndRemoveUntil(context: context, screen: Interest(tmpToken: guestLoginResponse.token??'',
                     userID:guestLoginResponse.data?.pkGuest??0));
              }else{
                PreferenceManager.insertValue(key: TOKEN, value: guestLoginResponse.token.toString());
                PreferenceManager.insertValue(key: ISGUEST, value: true);
                CustomNavigator.pushAndRemoveUntil(context: context, screen: const PersistentCustomBottomMenu(initialIndex:0));
              }

            }
            if(state.status == TicTocStatus.signInError){
              print(state.errorData?.message);
              String message = state.errorData?.message ?? state.error ?? "";
              UiHelper.toastMessage(message);
            }
            if(state.status == TicTocStatus.guestLoginError){
              print(state.errorData?.message);
              String message = state.errorData?.message ?? state.error ?? "";
              UiHelper.toastMessage(message);
            }
          },
          builder: (context,state){
            return  SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                      //   padding: const EdgeInsets.all(18.0),
                      padding: const EdgeInsets.only(left: 26,right: 26,bottom: 24,top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height:screenHeight*0.10,),
                          const AuthLogoAndText(),
                          UiHelper.verticalSpace(height: screenHeight*0.11),
                          TextFormFieldWithLabel(
                            controller: emailOrPhoneController,
                            label: "Email ID/Phone Number",
                            hintText: 'Email/Phone Number',
                            textInputAction:TextInputAction.next,
                            maxLength: 50,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s')), // Prevents spaces
                            ],
                            //   keyboardType: TextInputType.emailAddress,
                          ),
                          UiHelper.verticalSpace(height: 20),
                          TextFormFieldWithLabel(
                            controller: passwordController,
                            obscureText: !_isPasswordVisible1,
                            maxLength: 16,
                            label: "Password",
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
                          UiHelper.verticalSpace(height: 12),
                          MyInkWell(
                            onTap: ()async{
                              _clearControllers();
                              CustomNavigator.push(context: context, screen: const ForgotPassword());
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text('Forgot Password?',style:GoogleFonts.poppins(fontSize: 12,color: Colors.white)),
                            ),
                          ),
                          UiHelper.verticalSpace(height: 24),
                          const PasswordRequirementText(),
                        ],
                      ),
                    ),
                  ),
                  UiHelper.verticalSpace(height: 34),
                  pinkButton(context: context,
                      isLoading: state.status == TicTocStatus.signInLoading,
                      onTap: _validateAndSubmit,
                      labelText:'Log In',width: 285),
                  UiHelper.verticalSpace(height: 12),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w500,color: const Color(0xff0B0B0B),),
                      children: [
                        const TextSpan(
                          text: "Don’t have an account?  ",
                        ),
                        TextSpan(
                          text: "Sign Up",
                          style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600,color: const Color(0xff0B0B0B),),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _clearControllers();
                              CustomNavigator.push(context: context, screen: const SignUp());
                            },
                        ),
                      ],
                    ),
                  ),
                  UiHelper.verticalSpace(height: 12),
                  state.status==TicTocStatus.guestLoginLoading? const SizedBox( height:20,width: 20,
                    child: CircularProgressIndicator(color: buttonColor,strokeWidth: 3.0,),):
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w500,color: const Color(0xff0B0B0B),),
                      children: [
                        const TextSpan(
                          text: "Continue as a ",
                        ),
                        TextSpan(
                          text: "Guest",
                          style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600,
                              color: buttonColor,decoration: TextDecoration.underline,
                              decorationThickness:2),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Map<String,dynamic> signInDetails = {
                               "deviceId": deviceId,
                              };
                              print('signInDetails:$signInDetails');
                              BlocProvider.of<TicTocCubit>(context).guestLoginCall(signInDetails);
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

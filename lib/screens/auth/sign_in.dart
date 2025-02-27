import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/guest_login_response.dart';
import 'package:tictoc/model/sign_in_response.dart';
import 'package:tictoc/screens/auth/forgot_password.dart';
import 'package:tictoc/screens/auth/otp_verification.dart';
import 'package:tictoc/screens/auth/sign_up.dart';
import 'package:tictoc/screens/bottomnavigationbar/bottomnavigation.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/shared_preference.dart';
import 'package:tictoc/utils/ui_helper.dart';
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
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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

              if(signInResponse.data?.user?.isVerify == 1){
                UiHelper.toastMessage(signInResponse.msg??'');
                PreferenceManager.insertValue(key: TOKEN, value: signInResponse.data?.token.toString());
                PreferenceManager.insertValue(key: PHONE_NO, value: signInResponse.data?.user?.phone.toString());
                PreferenceManager.insertValue(key: EMAIL_ID, value: signInResponse.data?.user?.email.toString());
                CustomNavigator.pushAndRemoveUntil(context: context, screen: const PersistentCustomBottomMenu(initialIndex:0));
              }else{
                print('Not verified');
                UiHelper.toastMessage(signInResponse.data?.otp.toString()??'');
                CustomNavigator.push(
                  context: context,
                  screen: OtpVerification(fromPage: 'signIn',tempToken:signInResponse.data?.tempToken??''),
                );
              }
            }
            else if (state.status == TicTocStatus.guestLoginSuccess){
              GuestLoginResponse guestLoginResponse = state.responseData?.response as GuestLoginResponse;

              UiHelper.toastMessage(guestLoginResponse.msg??'');
              isGuest = true;
              PreferenceManager.insertValue(key: TOKEN, value: guestLoginResponse.token.toString());
              PreferenceManager.insertValue(key: ISGUEST, value: true);
              CustomNavigator.pushAndRemoveUntil(context: context, screen: const PersistentCustomBottomMenu(initialIndex:0));
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
                          Center(child: Image.asset('assets/images/logo.png',height: 135,width: 135,)),
                          UiHelper.verticalSpace(height: 14),
                          largeText16(context,'"India Owned TicToc App for \n Indians & Rest of the World"',
                              textColor: Colors.white,
                              fontWeight:FontWeight.w500,fontSize: 15),
                          UiHelper.verticalSpace(height: screenHeight*0.11),

                          /*  customTextField2(
                        label: 'Email ID',
                        hintText: 'example@gmail.com',
                        height: 90,
                        controller: emailorPhoneController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                      ),*/
                          //  UiHelper.verticalSpace(height: 36),
                          TextFormFieldWithLabel(
                            controller: emailOrPhoneController,
                            label: "Email ID/Phone Number",
                            hintText: 'Email/Phone Number',
                            textInputAction:TextInputAction.next,
                            //   keyboardType: TextInputType.emailAddress,
                          ),
                          UiHelper.verticalSpace(height: 20),
                          TextFormFieldWithLabel(
                            controller: passwordController,
                            obscureText: !_isPasswordVisible1,
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
                              CustomNavigator.push(context: context, screen: const ForgotPassword());
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text('Forgot Password?',style:GoogleFonts.poppins(fontSize: 12,color: Colors.white)),
                            ),
                          ),
                          UiHelper.verticalSpace(height: 24),
                          poppinsSmall12(context,
                              //   '(Password must be at min 8 characters with 1 special \n character, 2 numbers, 1 uppercase, and 2 lowercase letters.)',
                              '(Password must be at min 8 characters with 1 special character, 2 numbers, 1 uppercase, and 2 lowercase letters.)',
                              fontSize: 10,
                              textColor: whiteColor, textAlign: TextAlign.center),

                          /*    customTextField(height:90,hintText: 'thiru@gmail.com',
                        controller: emailorPhoneController,
                      contentPadding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 12),
                      ),*/

                        ],
                      ),
                    ),
                  ),
                  UiHelper.verticalSpace(height: 34),
                  pinkButton(context: context,
                      isLoading: state.status == TicTocStatus.signInLoading,
                      onTap: (){
                    if(emailOrPhoneController.text.isEmpty){
                      UiHelper.toastMessage(PLEASE_ENTER_EMAIL_OR_PHONENUMBER);
                    }else if(passwordController.text.isEmpty){
                      UiHelper.toastMessage("Please Enter Your Password");
                    }else{
                      Map<String,dynamic> signInDetails = {
                        "username": emailOrPhoneController.text,
                        "password": passwordController.text,
                      };
                      print('signInDetails:$signInDetails');
                      BlocProvider.of<TicTocCubit>(context).signInCall(signInDetails);
                    }
                      },
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

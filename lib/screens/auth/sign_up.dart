import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/sign_up_response.dart';
import 'package:tictoc/screens/auth/otp_verification.dart';
import 'package:tictoc/screens/auth/sign_in.dart';
import 'package:tictoc/screens/auth/widgets/common_auth_widgets.dart';
import 'package:tictoc/screens/auth/widgets/phone_input_widget.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/dialog_utils.dart';
import 'package:tictoc/utils/ui_helper.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _isPasswordVisible1 = false;
  bool _isPasswordVisible2 = false;
  bool isTermsChecked = false;
  String selectedCountryCode = '+91';

  @override
  void initState() {
    // TODO: implement initState
  //  passwordController.text = "Thiru@003";
   // confirmPasswordController.text = "Thiru@003";
    super.initState();
  }
  void _clearControllers() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    selectedCountryCode = '+91';
    isTermsChecked = false;
    FocusScope.of(context).unfocus(); // Remove focus from text fields
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: BlocConsumer<TicTocCubit, TicTocState>(
        listener: (context, state) {
          if (state.status == TicTocStatus.signUpSuccess) {
            SignUpResponse signUpResponse = state.responseData?.response as SignUpResponse;
            UiHelper.toastMessage(signUpResponse.msg ?? '');
            _clearControllers();
            CustomNavigator.push(
              context: context,
              screen: OtpVerification(fromPage: 'signUp',
                  tempToken:signUpResponse.data?.tempToken??'',
                  tmpOtp: signUpResponse.data?.otp.toString()??'',
              ),
            );
          }
          if (state.status == TicTocStatus.signUpError) {
            print(state.errorData?.message);
            String message = state.errorData?.message ?? state.error ?? "";
            UiHelper.toastMessage(message);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: const BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 26, vertical: screenHeight * 0.02),  // Use dynamic padding
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height:screenHeight>720?68.h:36.h,),
                            const AuthLogoAndText(),
                            UiHelper.verticalSpace(height: screenHeight * 0.03), // Dynamic space
                            TextFormFieldWithLabel(
                              controller: nameController,
                              label: "Name",
                              hintText: 'Thiru',
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
                              maxLength: 50,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z ]")), // Allows only letters and spaces
                                FilteringTextInputFormatter.deny(RegExp(r"\s{2,}")), // Prevents consecutive spaces
                               /* TextInputFormatter.withFunction((oldValue, newValue) {
                                  if (newValue.text.length > 50) {
                                    return oldValue; // Reject input if it exceeds 50 characters
                                  }
                                  return newValue; // Accept input otherwise
                                }),*/
                              ],
                            ),
                            UiHelper.verticalSpace(height: 20),
                            TextFormFieldWithLabel(
                              controller: emailController,
                              label: "Email ID",
                              hintText: 'abc@gmail.com',
                              textInputAction: TextInputAction.next,
                              maxLength: 50,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'\s')), // No spaces allowed
                              ],
                              keyboardType: TextInputType.emailAddress,
                            ),
                            UiHelper.verticalSpace(height: 16),
                            Padding(
                              padding: const EdgeInsets.only(left: 18,bottom: 0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: mediumText14(context, "Phone Number",fontWeight: FontWeight.w500, fontSize: 14, textColor: Colors.white,)),
                            ),
                            PhoneInputWidget(
                              controller: phoneController,
                              initialCountryCode: 'IN',
                              onCountryChanged: (code) {
                                selectedCountryCode = code;
                                print("Selected Country Code: $code");
                              },
                            ),
                            UiHelper.verticalSpace(height: 20),
                            TextFormFieldWithLabel(
                              controller: passwordController,
                              obscureText: !_isPasswordVisible1,
                              label: "Password",
                              hintText: '*********',
                              maxLength: 16,
                              textInputAction: TextInputAction.next,
                              suffixIcon: UnconstrainedBox(
                                child: IconButton(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  icon: _isPasswordVisible1
                                      ? customImageAsset(imagePath: 'assets/images/eye_show.png', height: 22, width: 22)
                                      : customImageAsset(imagePath: 'assets/images/eye_off.png', height: 22, width: 22),
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
                              maxLength: 16,
                              textInputAction: TextInputAction.done,
                              suffixIcon: UnconstrainedBox(
                                child: IconButton(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  icon: _isPasswordVisible2
                                      ? customImageAsset(imagePath: 'assets/images/eye_show.png', height: 22, width: 22)
                                      : customImageAsset(imagePath: 'assets/images/eye_off.png', height: 22, width: 22),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible2 = !_isPasswordVisible2;
                                    });
                                  },
                                ),
                              ),
                            ),
                            UiHelper.verticalSpace(height: 12),
                            Row(
                              //  crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: Transform.scale(
                                    scale: 1.0,
                                    child: Checkbox(
                                      value: isTermsChecked,
                                      checkColor:const Color(0xffFFFFFF),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          //  isTermsChecked = value ?? false;
                                          isTermsChecked = !isTermsChecked;
                                        });
                                      },
                                      activeColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      side: WidgetStateBorderSide.resolveWith(
                                            (states) => const BorderSide(
                                            width: 1.0, color: Color(0xffFFFFFF)),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8,),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style:GoogleFonts.poppins(fontWeight:FontWeight.normal,  fontSize: 10, color: whiteColor,),
                                      children: [
                                        TextSpan(
                                          text: "By signing up you accept the ",
                                          style: GoogleFonts.poppins(fontWeight:FontWeight.normal, fontSize: 10, color: whiteColor,),
                                        ),
                                        TextSpan(
                                          text: "Terms of Service and Privacy Policy",
                                          style: GoogleFonts.poppins(fontWeight:FontWeight.normal,  fontSize: 10, color: whiteColor,
                                              decoration: TextDecoration.underline, decorationThickness:1.5),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              FocusScope.of(context).unfocus(); // Hides the keyboard
                                              final result = await DialogUtils.showTermsAndConditions(context); // Call the utility function
                                              print('result:$result');
                                              if (result == 'Agree') {
                                                setState(() {
                                                  isTermsChecked = true;
                                                });
                                              }
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 18,),
                              ],
                            ),
                            UiHelper.verticalSpace(height: 16),
                            const PasswordRequirementText(),
                            UiHelper.verticalSpace(height: 32),
                            // UiHelper.verticalSpace(height: 42),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // bottom: screenHeight * 0.05, // Dynamic position of the button
                      bottom: 0,
                      child: pinkButton(
                        context: context,
                        isLoading: state.status == TicTocStatus.signUpLoading,
                        onTap: () {
                          RegExp passwordRegExp = RegExp(passwordPattern.trim());
                          if (nameController.text.trim().isEmpty) {
                            UiHelper.toastMessage("Please enter Name");
                          }else if(emailController.text.isEmpty && phoneController.text.isEmpty){
                            UiHelper.toastMessage(PLEASE_ENTER_EMAIL_OR_PHONENUMBER);
                          }else if (!RegExp(
                          r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                              .hasMatch(emailController.text) && emailController.text.isNotEmpty) {
                          UiHelper.toastMessage(PLEASE_ENTER_VALID_EMAIL);
                          }
                          else if (phoneController.text.isNotEmpty &&
                              (phoneController.text.length < 5 || phoneController.text.length > 15 || RegExp(r'^0+$').hasMatch(phoneController.text))) {
                            UiHelper.toastMessage(PLEASE_ENTER_VALID_PHONE_NUMBER);
                          } else if (passwordController.text.isEmpty) {
                            UiHelper.toastMessage("Please enter Password");
                          }else if (!passwordRegExp
                              .hasMatch(passwordController.text)) {
                            snackBarMessage(context, PASSWORD_LENGTH_VALIDATION);
                          } else if (confirmPasswordController.text.isEmpty) {
                            UiHelper.toastMessage("Please enter Confirm Password");
                          } else if (passwordController.text != confirmPasswordController.text) {
                            UiHelper.toastMessage(MATCHING_PASSWORD_VALIDATION ?? '');
                          }else if(!isTermsChecked){
                            UiHelper.toastMessage(
                                "Please accept Terms of Service and Privacy Policy");
                          }else{
                            Map<String, dynamic> signUpDetails = {
                              "name": nameController.text,
                              "email": emailController.text,
                              "phone": phoneController.text,
                              "password": passwordController.text,
                              "countryCode":selectedCountryCode
                            };
                            print('signUpDetails:$signUpDetails');
                            BlocProvider.of<TicTocCubit>(context).signUpCall(signUpDetails);
                          }

                        },
                        labelText: 'Sign Up',
                        width: screenWidth * 0.75, // Button width based on screen width
                      ),
                    ),
                  ],
                ),
                UiHelper.verticalSpace(height: 12),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff0B0B0B),
                    ),
                    children: [
                      const TextSpan(text: "Already have an account?  "),
                      TextSpan(
                        text: "Log In",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff0B0B0B),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _clearControllers();
                            CustomNavigator.push(
                              context: context,
                              screen: const SignIn(),
                            );
                          },
                      ),
                    ],
                  ),
                ),
                UiHelper.verticalSpace(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/screens/auth/otp_verification.dart';
import 'package:tictoc/screens/auth/sign_in.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _isPasswordVisible1 = false;
  bool _isPasswordVisible2 = false;
  @override
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
                        UiHelper.verticalSpace(height: 24),
                        Center(
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: screenHeight * 0.18, // Dynamic logo size
                            width: screenWidth * 0.3,   // Dynamic logo size
                          ),
                        ),
                        UiHelper.verticalSpace(height: 14),
                        largeText16(
                          context,
                          '"India Owned TicToc App for \n Indians & Rest of the World"',
                          textColor: whiteColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                        UiHelper.verticalSpace(height: screenHeight * 0.04), // Dynamic space
                        TextFormFieldWithLabel(
                          controller: nameController,
                          label: "Name",
                          hintText: 'Thiru',
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                        ),
                        UiHelper.verticalSpace(height: 20),
                        TextFormFieldWithLabel(
                          controller: emailController,
                          label: "Email ID",
                          hintText: 'example@gmail.com',
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        UiHelper.verticalSpace(height: 20),
                        TextFormFieldWithLabel(
                          controller: passwordController,
                          obscureText: !_isPasswordVisible1,
                          label: "Password",
                          hintText: '*********',
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
                        UiHelper.verticalSpace(height: 24),
                        poppinsSmall12(
                          context,
                          '(Password must be at min 8 characters with 1 special \n character, 2 numbers, 1 uppercase, and 2 lowercase letters.)',
                          fontSize: 10,
                          textColor: whiteColor,
                          textAlign: TextAlign.center,
                        ),
                        UiHelper.verticalSpace(height: 42),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  // bottom: screenHeight * 0.05, // Dynamic position of the button
                  bottom: 0,
                  child: pinkButton(
                    context: context,
                    onTap: () {
                      CustomNavigator.push(
                        context: context,
                        screen: const OtpVerification(fromPage: 'signUp'),
                      );
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
      ),
    );
  }


}
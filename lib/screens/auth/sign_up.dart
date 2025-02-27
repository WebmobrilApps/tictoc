import 'package:country_code_picker/country_code_picker.dart';
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
import 'package:tictoc/screens/auth/widgets/password_req_text.dart';
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
  bool _isChecked1 = false;
  String selectedCountryCode = '+91';
  String countryCode = "";
  String countryISOCode = "IN";

  @override
  void initState() {
    // TODO: implement initState
    passwordController.text = "Thiru@003";
    confirmPasswordController.text = "Thiru@003";
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: whiteColor,
      body: BlocConsumer<TicTocCubit, TicTocState>(
        listener: (context, state) {
          if (state.status == TicTocStatus.signUpSuccess) {
            SignUpResponse signUpResponse = state.responseData?.response as SignUpResponse;
        //    UiHelper.toastMessage(signUpResponse.msg ?? '');
            UiHelper.toastMessage(signUpResponse.data?.otp.toString() ?? '');
            CustomNavigator.push(
              context: context,
              screen: OtpVerification(fromPage: 'signUp',tempToken:signUpResponse.data?.tempToken??''),
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
                            //  SizedBox(height:screenHeight*0.10,),
                            // SizedBox(height:screenWidth>750?92.h:38.h,),
                            SizedBox(height:screenHeight>720?68.h:36.h,),
                            //  SizedBox(height:screenHeight*0.10,),
                            Center(child: Image.asset('assets/images/logo.png',height: 135,width: 135,)),
                            UiHelper.verticalSpace(height: 14),
                            largeText16(
                              context,
                              '"India Owned TicToc App for \n Indians & Rest of the World"',
                              textColor: whiteColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                            UiHelper.verticalSpace(height: screenHeight * 0.03), // Dynamic space
                            TextFormFieldWithLabel(
                              controller: nameController,
                              label: "Name",
                              hintText: 'Thiru',
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
                              ],
                            ),
                            UiHelper.verticalSpace(height: 20),
                            TextFormFieldWithLabel(
                              controller: emailController,
                              label: "Email ID",
                              hintText: 'abc@gmail.com',
                              textInputAction: TextInputAction.next,
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
                            SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: phoneController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly, // Allows only numbers
                                ],
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                    hintText: '987654321',
                                    labelStyle: GoogleFonts.jost(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white,),
                                    hintStyle: GoogleFonts.jost(fontWeight: FontWeight.w400, fontSize: 16, color: const Color(0xffc4c4c4),),
                                    floatingLabelBehavior: FloatingLabelBehavior.always,

                                    prefixIcon: Container(
                                      padding: const EdgeInsets.only(left: 6,top: 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CountryCodePicker(
                                            onChanged: (country) {
                                              FocusScope.of(context).requestFocus(FocusNode());
                                              /*      WidgetsBinding.instance.addPostFrameCallback((_) {
                                            FocusScope.of(context).unfocus();
                                          });*/
                                              selectedCountryCode = country.dialCode??'';
                                              print("Selected Country Code: ${country.dialCode}");
                                            },
                                            initialSelection: 'IN', // Default country (India)
                                            favorite: const ['+91',], // Favorite country codes
                                            showCountryOnly: false,
                                            showOnlyCountryWhenClosed: false,
                                            padding :  EdgeInsets.zero,
                                            margin: const EdgeInsets.only(right:4),
                                            backgroundColor: Colors.transparent,
                                            barrierColor: Colors.transparent,
                                            showFlag: true, // Ensures the flag is shown
                                            flagWidth: 26, // Reduce flag size
                                            showFlagDialog: true, // Shows flag in dialog
                                            showDropDownButton: false, // Adds dropdown arrow
                                            dialogSize: const Size(double.infinity, 500), // Set dialog width and height
                                            textStyle:  GoogleFonts.jost(fontWeight: FontWeight.w400, fontSize: 12, color: const Color(0xffc4c4c4),),
                                            dialogTextStyle: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500,),
                                            searchStyle: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500,),
                                          ),
                                        ],
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.only(left: 20, right: 10, top: 6, bottom: 10,),
                                    focusedBorder:  const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white, width: 2),
                                    ),
                                    enabledBorder:const  UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white, width: 2),
                                    ),
                                    border:const  UnderlineInputBorder(
                                      borderSide: BorderSide(color:Colors.white, width: 2),
                                    ),
                                    counterText: ""
                                ),
                              ),
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
                                                  _isChecked1 = true;
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
                          if(nameController.text.isEmpty){
                            UiHelper.toastMessage("Please Enter Your Name");
                          }else if(emailController.text.isEmpty && phoneController.text.isEmpty){
                            UiHelper.toastMessage(PLEASE_ENTER_EMAIL_OR_PHONENUMBER);
                          //  UiHelper.toastMessage("Please enter your email or phone number");
                          }else if (phoneController.text.length!=10 && phoneController.text.isNotEmpty) {
                            UiHelper.toastMessage("Please Enter A Valid Phone Number");
                          } else if (!RegExp(
                              r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                              .hasMatch(emailController.text) && emailController.text.isNotEmpty) {
                            UiHelper.toastMessage("Please Enter A Valid Email Address");
                          }else if (passwordController.text.isEmpty) {
                            UiHelper.toastMessage("Please Enter Password");
                          } else if (passwordController.text.length < 8 ||
                              passwordController.text.length > 16) {
                            snackBarMessage(context,
                                'Password should be Between 8-16 characters long and it should contain Atleast One Number, One Special Character, One Uppercase and One Lowercase.');
                          } else if (!passwordRegExp
                              .hasMatch(passwordController.text)) {
                            snackBarMessage(context, PASSWORD_LENGTH_VALIDATION);
                          } else if (confirmPasswordController.text.isEmpty) {
                            UiHelper.toastMessage(
                                EMPTY_CONFIRM_PASSWORD_VALIDATION ?? '');
                          } else if (passwordController.text !=
                              confirmPasswordController.text) {
                            UiHelper.toastMessage(
                                MATCHING_PASSWORD_VALIDATION ?? '');
                          }else if(!_isChecked1){
                            UiHelper.toastMessage(
                                "Please Accept Terms of Service and Privacy Policy");
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
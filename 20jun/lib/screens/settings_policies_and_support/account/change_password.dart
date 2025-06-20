import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:tictoc/utils/custom_appbar.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController textEditingController = TextEditingController();
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  String resendOtpToken = "";


  int remainingTime = 30; // 5 minutes in seconds
  late Timer countdownTimer;
  bool isResendButtonEnabled = false;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _isPasswordVisible1 = false;
  bool _isPasswordVisible2 = false;
  bool _isPasswordVisible3 = false;

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
      body: BlocConsumer<TicTocCubit, TicTocState>(
        listener: (context, state) {
          if (state.status == TicTocStatus.changePasswordSuccess) {
            UiHelper.toastMessage(state.responseData?.response??'');
            Navigator.of(context).pop();
          }
          if (state.status == TicTocStatus.changePasswordError) {
            print(state.errorData?.message);
            String message = state.errorData?.message ?? state.error ?? "";
            UiHelper.toastMessage(message);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top:18,left:18,right: 18),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 16,right: 16,top: 40,bottom: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffF2F2F2),
                    ),
                    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormFieldWithLabel(
                          controller: oldPasswordController,
                          obscureText: !_isPasswordVisible1,
                          label: "Old Password",
                          hintText: '*********',
                          maxLength: 16,
                          labelStyle: GoogleFonts.jost(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black,),
                          hintStyle: GoogleFonts.jost(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey,),
                          textStyle: GoogleFonts.jost(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black,),
                          textInputAction:TextInputAction.next,
                          bottomBorderColor:const Color(0xffC4C4C4),
                          cursorColor: Colors.grey,
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
                          controller: newPasswordController,
                          obscureText: !_isPasswordVisible2,
                          label: "New Password",
                          hintText: '*********',
                          maxLength: 16,
                          labelStyle: GoogleFonts.jost(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black,),
                          hintStyle: GoogleFonts.jost(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey,),
                          textStyle: GoogleFonts.jost(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black,),
                          textInputAction:TextInputAction.next,
                          bottomBorderColor:const Color(0xffC4C4C4),
                          cursorColor: Colors.grey,
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
                        UiHelper.verticalSpace(height: 20),
                        TextFormFieldWithLabel(
                          controller: confirmPasswordController,
                          obscureText: !_isPasswordVisible3,
                          label: "Confirm Password",
                          hintText: '*********',
                          maxLength: 16,
                          labelStyle: GoogleFonts.jost(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black,),
                          hintStyle: GoogleFonts.jost(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey,),
                          textStyle: GoogleFonts.jost(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black,),
                          textInputAction:TextInputAction.next,
                          bottomBorderColor:const Color(0xffC4C4C4),
                          cursorColor: Colors.grey,
                          suffixIcon: UnconstrainedBox(
                            child: IconButton(
                              highlightColor:Colors.transparent,
                              splashColor: Colors.transparent,
                              icon: _isPasswordVisible3 ?customImageAsset(imagePath: 'assets/images/eye_show.png',height: 22,width: 22):
                              customImageAsset(imagePath: 'assets/images/eye_off.png',height: 22,width: 22),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible3 = !_isPasswordVisible3;
                                });
                              },
                            ),
                          ),
                        ),
                        UiHelper.verticalSpace(height: 40),
                        pinkButton(context: context, labelText: 'Save',
                          isLoading:state.status == TicTocStatus.changePasswordLoading,
                          onTap: (){
                            RegExp passwordRegExp = RegExp(passwordPattern.trim());
                            if (oldPasswordController.text.isEmpty) {
                              UiHelper.toastMessage("Please enter old password");
                            }else if (newPasswordController.text.isEmpty) {
                              UiHelper.toastMessage("Please enter new password");
                            } else if (newPasswordController.text.length < 8 ||
                                newPasswordController.text.length > 16) {
                              snackBarMessage(context,'Password should be Between 8-16 characters long and it should contain Atleast One Number, One Special Character, One Uppercase and One Lowercase.');
                            }  else if (confirmPasswordController.text.isEmpty) {
                              UiHelper.toastMessage(EMPTY_CONFIRM_PASSWORD_VALIDATION??'');
                            } else if (newPasswordController.text !=
                                confirmPasswordController.text) {
                              UiHelper.toastMessage(MATCHING_PASSWORD_VALIDATION??'');
                            }else{
                              Map<String, dynamic> passwordDetails = {
                                "old_password": oldPasswordController.text,
                                "new_password": newPasswordController.text,
                                "confirm_password": confirmPasswordController.text,
                              };
                              print('passwordDetails:$passwordDetails');
                              BlocProvider.of<TicTocCubit>(context).changePasswordCall(passwordDetails);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
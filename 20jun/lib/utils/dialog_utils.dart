import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/utils/custom_widgets.dart';




import 'package:flutter/material.dart';
import 'package:tictoc/screens/auth/sign_in.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';

class DialogUtils {
  static Future<String?> showTermsAndConditions(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.white,
              elevation: 0,
              insetPadding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: constraints.maxWidth * 0.98,
                 //   padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding:const EdgeInsets.only(right: 8,top: 8),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: MyInkWell(
                              onTap: ()async {
                                Navigator.of(context).pop(); // Close dialog without returning anything
                              },
                              child: Image.asset('assets/images/clear.png', color: Colors.black, height: 30, width: 30),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20,top: 8),
                          child: Center(
                            child: largeText16(context, "Terms of Service and Privacy Policy", fontSize: 20,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 8),
                              child: Column(
                                children: [
                                  mediumText14(context, "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
                                  const SizedBox(height: 6),
                                  mediumText14(context, "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."),
                                  const SizedBox(height: 6),
                                  mediumText14(context, "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
                                  const SizedBox(height: 6),
                                  mediumText14(context, "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
                                  const SizedBox(height: 6),
                                  mediumText14(context, "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."),
                                  const SizedBox(height: 6),
                                  mediumText14(context, "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
                                  const SizedBox(height: 6),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: pinkButton(
                            width: 285,
                            context: context,
                            labelText: 'Agree',
                            onTap: () {
                              Navigator.of(context).pop('Agree'); // Returns "Agree" to calling function
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}


class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool isHideHistory = false;
  final animationDuration = const Duration(milliseconds: 300);
  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      reverse: true,
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25), // Outer spacing
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              bottom: keyboardHeight, // Add padding for the keyboard
            ),
            decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              //    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UiHelper.verticalSpace(height: 24),
                  largeText16(context, '"Congratulation!”', fontSize: 20, fontWeight: FontWeight.w600),
                  UiHelper.verticalSpace(height: 16),
                  largeText16(context, 'Now you are part of \n the Worlds Amazing Platform ',textAlign: TextAlign.center,lineHeight: 1.4),
                  UiHelper.verticalSpace(height: 18),
                  largeText16(context, 'Your Password has been Updated',),
                  UiHelper.verticalSpace(height: 32),
                  pinkButton(context: context,
                      onTap: (){
                        Navigator.of(context).pop();
                        CustomNavigator.pushAndRemoveUntil(context: context, screen: const SignIn());
                      },
                      labelText:'Done')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
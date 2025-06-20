import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_appbar.dart';

import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class SecurityAlerts extends StatefulWidget {
  const SecurityAlerts({super.key});

  @override
  State<SecurityAlerts> createState() => _SecurityAlertsState();
}

class _SecurityAlertsState extends State<SecurityAlerts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: 'Security alerts',),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
          child: Center(
            child: Column(
              children: [
                UiHelper.verticalSpace(height: screenHeight*0.18),
                Image.asset('assets/images/no_unusual.png',height: 70,width: 70,),
                UiHelper.verticalSpace(height: 14),
                mediumText14(context,'No unusual account activity detected in the \n last 7 days',
                    fontWeight:FontWeight.w500, textColor: appGreyColor,textAlign: TextAlign.center),
                UiHelper.verticalSpace(height: screenHeight*0.32),
                pinkButton(context: context, labelText: 'Done', height: 50.4,width: 284.6,
                onTap: (){}),
                UiHelper.verticalSpace(height: 10),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w500,color: const Color(0xff404040),),
                    children: [
                      const TextSpan(
                        text: "Still have questions?  ",
                      ),
                      TextSpan(
                        text: "Contact us",
                        style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600,color: buttonColor,),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                           // CustomNavigator.push(context: context, screen: const SignUp());
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

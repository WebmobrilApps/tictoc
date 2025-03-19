import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';

class AuthLogoAndText extends StatelessWidget {
  const AuthLogoAndText({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: Image.asset('assets/images/logo.png',height: 135,width: 135,)),
        UiHelper.verticalSpace(height: 14),
        largeText16(
          context,
          '"India Owned TicToc App for \n Indians & Rest of the World"',
          textColor: whiteColor,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ],
    );
  }
}

class PasswordRequirementText extends StatelessWidget {
  const PasswordRequirementText({super.key});

  @override
  Widget build(BuildContext context) {
    return poppinsSmall12(
      context,
      '(Password must be at min 8 characters with 1 special character, 2 numbers, 1 uppercase, and 2 lowercase letters.)',
      fontSize: 10,
      textColor: whiteColor,
      textAlign: TextAlign.center,
    );
  }
}


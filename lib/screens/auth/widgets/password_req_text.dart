import 'package:flutter/material.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_widgets.dart';

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

import 'package:flutter/material.dart';
import 'package:tictoc/screens/settings_policies_and_support/terms_and_policies.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/ui_helper.dart';
class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: 'Support'),
      body: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16),
        child: Column(
          children: [
            UiHelper.verticalSpace(height: 26),
            RowPolicyWidget(
              labelText: 'Help Center',
              onTap: (){},
            ),
            RowPolicyWidget(
              labelText: 'Safety Center',
              onTap: (){},
            ),
            RowPolicyWidget(
              labelText: 'Private Center',
              onTap: (){},
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tictoc/screens/settings_policies_and_support/common_policy.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class TermsAndPolicies extends StatefulWidget {
  const TermsAndPolicies({super.key});

  @override
  State<TermsAndPolicies> createState() => _TermsAndPoliciesState();
}

class _TermsAndPoliciesState extends State<TermsAndPolicies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: 'Terms and Policies'),
      body: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16),
        child: Column(
          children: [
            UiHelper.verticalSpace(height: 26),
            RowPolicyWidget(
              labelText: 'Community Guidelines',
              onTap: (){CustomNavigator.push(context: context, screen: const CommonPolicy(pageFrom:'Community Guidelines'));},
            ),
            RowPolicyWidget(
              labelText: 'Terms of Service',
              onTap: (){CustomNavigator.push(context: context, screen: const CommonPolicy(pageFrom:'Terms of Service'));},
            ),
            RowPolicyWidget(
              labelText: 'Privacy Policy',
              onTap: (){CustomNavigator.push(context: context, screen: const CommonPolicy(pageFrom:'Privacy Policy'));},
            ),
            RowPolicyWidget(
              labelText: 'Copyright Policy',
              onTap: (){CustomNavigator.push(context: context, screen: const CommonPolicy(pageFrom:'Copyright Policy'));},
            ),
            RowPolicyWidget(
              labelText: 'Intellectual Property Policy',
              onTap: (){CustomNavigator.push(context: context, screen: const CommonPolicy(pageFrom:'Intellectual Property Policy'));},
            ),
            RowPolicyWidget(
              labelText: 'Open source software Notices',
              onTap: (){CustomNavigator.push(context: context, screen: const CommonPolicy(pageFrom:'Open source software Notices'));},
            ),
          ],
        ),
      ),
    );
  }
}
class RowPolicyWidget extends StatelessWidget {
  final String labelText;
  final VoidCallback? onTap;
  final bool showDivider;


  const RowPolicyWidget({
    super.key,
    required this.labelText,
    this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 9,),
        MyInkWell(
          onTap: ()async{
            onTap!();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              mediumText14(context,labelText,fontWeight:FontWeight.w500,
                  textColor: const Color(0xff404040)).pOnly(left: 14),
              Image.asset(
                'assets/images/right_arrow_1.png',
                height: 20,
                width: 20,
              ).pOnly(right: 10),
            ],
          ),
        ),
        const SizedBox(height: 9,),
        if(showDivider)
          const Divider(color: Color(0xffDEDEDE),thickness: 1,),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tictoc/screens/language/language.dart';
import 'package:tictoc/screens/notification/notification_settings.dart';
import 'package:tictoc/screens/settings_policies_and_support/account/account.dart';
import 'package:tictoc/screens/settings_policies_and_support/activity_center.dart';
import 'package:tictoc/screens/settings_policies_and_support/content_preference.dart';
import 'package:tictoc/screens/settings_policies_and_support/live.dart';
import 'package:tictoc/screens/settings_policies_and_support/privacy.dart';
import 'package:tictoc/screens/settings_policies_and_support/report_a_problem.dart';
import 'package:tictoc/screens/settings_policies_and_support/security/security.dart';
import 'package:tictoc/screens/settings_policies_and_support/support.dart';
import 'package:tictoc/screens/settings_policies_and_support/terms_and_policies.dart';
import 'package:tictoc/screens/profile/logout_delete_bottom.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class SettingsAndPrivacy extends StatefulWidget {
  const SettingsAndPrivacy({super.key});

  @override
  State<SettingsAndPrivacy> createState() => _SettingsAndPrivacyState();
}

class _SettingsAndPrivacyState extends State<SettingsAndPrivacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: '',arrowBeforeWidth: 20,),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                largeText16(context, 'Settings And Privacy',fontSize: 24,fontWeight: FontWeight.w600).pOnly(left:33),
                Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16,top: 18,bottom: 16),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 14,right: 14,top: 12,bottom: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xffF2F2F2),
                        ),
                        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText14(context,'Account',fontWeight:FontWeight.w500, textColor: const Color(0xff404040)),
                            UiHelper.verticalSpace(height: 16),
                            RowSettingsWidget(
                              labelText: 'Account',
                              leadingPath: 'assets/images/account.png',
                                onTap:(){CustomNavigator.push(context: context, screen: const Account());}),
                            RowSettingsWidget(
                                labelText: 'Privacy',
                                leadingPath: 'assets/images/privacy.png',
                                onTap:(){CustomNavigator.push(context: context, screen: const Privacy());}),
                            RowSettingsWidget(
                                labelText: 'Security',
                                leadingPath: 'assets/images/security.png',
                                onTap:(){CustomNavigator.push(context: context, screen: const Security());}),
                            RowSettingsWidget(
                                labelText: 'Share profile',
                                leadingPath: 'assets/images/share_pink.png',
                                showDivider:false,
                                onTap:(){ Share.share('Check out this awesome Flutter package!');}),
                          ],
                        ),
                      ),
                      UiHelper.verticalSpace(height: 16),
                      Container(
                        padding: const EdgeInsets.only(left: 14,right: 14,top: 12,bottom: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xffF2F2F2),
                        ),
                        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText14(context,'Content & Display',fontWeight:FontWeight.w500, textColor: const Color(0xff404040)),
                            UiHelper.verticalSpace(height: 16),
                            RowSettingsWidget(
                                labelText: 'Notification',
                                leadingPath: 'assets/images/notification_pink.png',
                                onTap:(){ CustomNavigator.push(context: context, screen: const NotificationSettings());}),
                            RowSettingsWidget(
                                labelText: 'Live',
                                leadingPath: 'assets/images/live_pink.png',
                                onTap:(){ CustomNavigator.push(context: context, screen: const Live());}),
                            RowSettingsWidget(
                                labelText: 'Content preferences',
                                leadingPath: 'assets/images/contentPreference.png',
                                onTap:(){ CustomNavigator.push(context: context, screen: const ContentPreference());}),
                            RowSettingsWidget(
                                labelText: 'Activity Center',
                                leadingPath: 'assets/images/activityCenter.png',
                                onTap:(){ CustomNavigator.push(context: context, screen: const ActivityCenter());}),
                            RowSettingsWidget(
                                labelText: 'Language',
                                leadingPath: 'assets/images/language.png',
                                showDivider:false,
                                onTap:(){ CustomNavigator.push(context: context, screen: const Language());}),
                          ],
                        ),
                      ),
                      UiHelper.verticalSpace(height: 16),
                      Container(
                        padding: const EdgeInsets.only(left: 14,right: 14,top: 12,bottom: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xffF2F2F2),
                        ),
                        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText14(context,'Support & About',fontWeight:FontWeight.w500, textColor: const Color(0xff404040)),
                            UiHelper.verticalSpace(height: 16),
                            RowSettingsWidget(
                                labelText: 'Report a problem',
                                leadingPath: 'assets/images/reportProblem.png',
                                onTap:(){
                                  CustomNavigator.push(context: context, screen: const ReportAProblem());
                                }),
                            RowSettingsWidget(
                                labelText: 'Support',
                                leadingPath: 'assets/images/support.png',
                                onTap:(){
                                  CustomNavigator.push(context: context, screen: const Support());
                                }),
                            RowSettingsWidget(
                                labelText: 'Terms and Policies',
                                leadingPath: 'assets/images/termsAndPolicies.png',
                                showDivider:false,
                                onTap:(){
                                  CustomNavigator.push(context: context, screen: const TermsAndPolicies());
                                }),
                          ],
                        ),
                      ),
                      UiHelper.verticalSpace(height: 16),
                      Container(
                        padding: const EdgeInsets.only(left: 14,right: 14,top: 12,bottom: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xffF2F2F2),
                        ),
                        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText14(context,'Login',fontWeight:FontWeight.w500, textColor: const Color(0xff404040)),
                            UiHelper.verticalSpace(height: 16),
                            RowSettingsWidget(
                                labelText: 'Log out',
                                leadingPath: 'assets/images/logout.png',
                                onTap: ()async {
                                  final result = await showModalBottomSheet(
                                    isScrollControlled: true,
                                    useRootNavigator: true,
                                    context: context,
                                    builder: (context) => const LogoutDeleteBottom(fromMenu:'logout'),
                                  );
                                  if (result != null) {
                                    setState(() {
                                    });
                                    //      Navigator.pop(context); // Close the bottom sheet
                                  }
                                },),
                            RowSettingsWidget(
                                labelText: 'Delete Account',
                                leadingPath: 'assets/images/delete.png',
                                showDivider:false,
                                onTap:() async {
                                  final result = await showModalBottomSheet(
                                    isScrollControlled: true,
                                    useRootNavigator: true,
                                    context: context,
                                    builder: (context) => const LogoutDeleteBottom(fromMenu:'deleteAccount'),
                                  );
                                  if (result != null) {
                                    setState(() {
                                    });
                                    //      Navigator.pop(context); // Close the bottom sheet
                                  }
                                }),
                          ],
                        ),
                      ),
                      UiHelper.verticalSpace(height: 40),
                    ],
                  ),
                ),
              ],
            ),
      ),
    );
  }
}

class RowSettingsWidget extends StatelessWidget {
  final String leadingPath;
  final String labelText;
  final VoidCallback? onTap;
  final bool showDivider;


  const RowSettingsWidget({
    super.key,
    required this.leadingPath,
    required this.labelText,
    this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 6,),
        MyInkWell(
      /*    onTap: ()async{
            onTap!();
          },*/
          onTap: () async {
            if (onTap != null) {
              await Future.sync(onTap!);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(leadingPath,height: 20,width: 20,),
                  const SizedBox(width: 16),
                  mediumText14(context,labelText,fontWeight:FontWeight.w500,
                      textColor: const Color(0xff404040)),
                ],
              ),
                Image.asset(
                  'assets/images/right_arrow_1.png',
                  height: 20,
                  width: 20,
                ).pOnly(right: 8),
            ],
          ),
        ),
        const SizedBox(height: 6,),
        if(showDivider)
          const Divider(color: Color(0xffDEDEDE),thickness: 1,),
      ],
    );
  }
}



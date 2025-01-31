import 'package:flutter/material.dart';
import 'package:tictoc/screens/settings_policies_and_support/terms_and_policies.dart';
import 'package:tictoc/screens/profile/logout_delete_bottom.dart';
import 'package:tictoc/screens/settings_policies_and_support/settingsAndPrivacy.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class ReportAProblem extends StatefulWidget {
  const ReportAProblem({super.key});

  @override
  State<ReportAProblem> createState() => _ReportAProblemState();
}

class _ReportAProblemState extends State<ReportAProblem> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: 'Report a problem'),
      body: Padding(
        padding: const EdgeInsets.only(left: 18,right: 18),
        child: Column(
          children: [
            customTextFieldWithBorder(
              height: 40,
              hintText: 'Search for an issue',
              controller: searchController,
              hintFontWeight:FontWeight.w500,
              textFontWeight:FontWeight.w500,
              prefixIcon: Image.asset('assets/images/search_black.png', height: 20, width: 20),
              suffixIcon: Image.asset('assets/images/clear.png', color:appBlackColor,height: 18, width: 18),
            ),
            UiHelper.verticalSpace(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    UiHelper.verticalSpace(height: 10),
                    Row( mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 30,right: 30,top: 14,bottom: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xffF2F2F2),
                          ),
                          child: Column( crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/account_recovery.png',height: 35,width: 35,),
                              const SizedBox(height: 4,),
                              smallText12(context, 'Account recovery',textColor: const Color(0xff484848),
                                  fontWeight: FontWeight.w500),
                            ],
                          ),
                        ),
                        UiHelper.horizontalSpace(width: 30),
                        Container(
                          padding: const EdgeInsets.only(left: 30,right: 30,top: 14,bottom: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xffF2F2F2),
                          ),
                          child: Column( crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/security_alerts.png',height: 35,width: 35,),
                              const SizedBox(height: 4,),
                              smallText12(context, 'Security alerts',textColor: const Color(0xff484848),
                                  fontWeight: FontWeight.w500),
                            ],
                          ),
                        ),
                      ],
                    ),
                    UiHelper.verticalSpace(height: 12),
                    Container(
                      padding: const EdgeInsets.only(left: 0,right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xffF2F2F2),
                      ),
                      child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          mediumText14(context,'Topics',fontWeight:FontWeight.w500, textColor: const Color(0xff404040)).pOnly(left: 16,right: 16,top: 20),
                          UiHelper.verticalSpace(height: 16),
                          RowReportWidget(
                            labelText: 'Account and Profile',
                            onTap: (){},
                          ),
                          RowReportWidget(
                            labelText: 'Interaction',
                            onTap: (){},
                          ),
                          RowReportWidget(labelText: 'Feed and playback', onTap: (){},),
                          RowReportWidget(labelText: 'Live', onTap: (){},),
                          RowReportWidget(labelText: 'Account growth', onTap: (){},),
                          RowReportWidget(labelText: 'Creation', onTap: (){},),
                          RowReportWidget(labelText: 'Creator tools', onTap: (){},),
                          RowReportWidget(labelText: 'Search', onTap: (){},),
                          RowReportWidget(labelText: 'Privacy & User safety', onTap: (){},),
                          RowReportWidget(labelText: 'TicToc Balance', onTap: (){},),
                          RowReportWidget(labelText: 'Subscription', onTap: (){},),
                          RowReportWidget(labelText: 'Playback Performance', onTap: (){},),
                          RowReportWidget(labelText: 'Promote', onTap: (){},),
                          RowReportWidget(labelText: 'Suggestions', onTap: (){},),
                          RowReportWidget(labelText: 'Ads', onTap: (){},),
                          RowReportWidget(labelText: 'Report', onTap: (){},showDivider:false),
                          UiHelper.verticalSpace(height: 8),
                        ],
                      ),
                    ),
                    UiHelper.verticalSpace(height: 35),
                    pinkButton(context: context, labelText: 'Chat with us').pOnly(left: 30,right: 30),
                    UiHelper.verticalSpace(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class RowReportWidget extends StatelessWidget {
  final String labelText;
  final VoidCallback? onTap;
  final bool showDivider;


  const RowReportWidget({
    super.key,
    required this.labelText,
    this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8,),
        MyInkWell(
          onTap: ()async{
            onTap!();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              mediumText14(context,labelText,fontWeight:FontWeight.w500,
                  textColor: const Color(0xff404040)).pOnly(left: 16),
              Image.asset(
                'assets/images/down_arrow1.png',
                height: 20,
                width: 20,
              ).pOnly(right: 10),
            ],
          ),
        ),
        const SizedBox(height: 8,),
        if(showDivider)
          const Divider(color: Color(0xffDEDEDE),thickness: 1,),
      ],
    );
  }
}
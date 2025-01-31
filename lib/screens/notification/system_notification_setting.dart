import 'package:flutter/material.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class SystemNotificationSetting extends StatefulWidget {
  const SystemNotificationSetting({super.key});

  @override
  State<SystemNotificationSetting> createState() => _SystemNotificationSettingState();
}

class _SystemNotificationSettingState extends State<SystemNotificationSetting> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: 'Notification Setting',
        appBarBgColor: Color(0xffF2F2F2),),
      body: Padding(
        padding: const EdgeInsets.only(top:20,left: 18,right: 18),
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
                  mediumText14(context, 'Channels',fontWeight:FontWeight.w500, textColor: const Color(0xff404040)),
                  UiHelper.verticalSpace(height: 24),
                  ReusableRowWidget(
                    labelText: 'Ads Support',
                    leadingIcon: Image.asset('assets/images/ads_support.png',height: 20,width: 20,), ),
                  UiHelper.verticalSpace(height: 8),
                  const Divider(color: Color(0xffD9D9D9),),
                  UiHelper.verticalSpace(height: 8),
                  ReusableRowWidget(
                    labelText: 'Creator Marketplace',
                    leadingIcon: Image.asset('assets/images/creater_marketplace.png',height: 20,width: 20,), ),
                  UiHelper.verticalSpace(height: 8),
                  const Divider(color: Color(0xffD9D9D9),),
                  UiHelper.verticalSpace(height: 8),
                  ReusableRowWidget(
                    labelText: 'Series',
                    leadingIcon: Image.asset('assets/images/series.png',height: 20,width: 20,), ),
                  UiHelper.verticalSpace(height: 8),
                  const Divider(color: Color(0xffD9D9D9),),
                  UiHelper.verticalSpace(height: 8),
                  ReusableRowWidget(
                    labelText: 'TicToc',
                    leadingIcon: Image.asset('assets/images/ticTic.png',height: 20,width: 25,), ),
                ],
              ),),
          ],
        ),
      ),
    );
  }
}



class ReusableRowWidget extends StatelessWidget {
  final Widget leadingIcon;
  final String labelText;
  final VoidCallback? onTap;

  const ReusableRowWidget({
    super.key,
    required this.leadingIcon,
    required this.labelText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              leadingIcon, // Use the passed leadingIcon widget here
              const SizedBox(width: 16),
              mediumText14(context,labelText,fontWeight:FontWeight.w500,
                  textColor: const Color(0xff404040)),
            ],
          ),
          Image.asset('assets/images/right_arrow_1.png', height: 20,width: 10).pOnly(right:8),
        ],
      ),
    );
  }
}
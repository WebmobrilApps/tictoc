import 'package:flutter/material.dart';
import 'package:tictoc/screens/settings_policies_and_support/content_preference.dart';
import 'package:tictoc/screens/settings_policies_and_support/security/manage_app_permissions.dart';
import 'package:tictoc/screens/settings_policies_and_support/security/manage_device.dart';
import 'package:tictoc/screens/settings_policies_and_support/security/security_alerts.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/toggle_switch.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class Security extends StatefulWidget {
  const Security({super.key});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  bool isSaveLoginInfo = false;
  final animationDuration = const Duration(milliseconds: 300);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: 'Security',),
      body: Padding(
        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 12,right: 12,top: 12,bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xffF2F2F2),
              ),
              child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mediumText14(context,'Security',fontWeight:FontWeight.w500, textColor: const Color(0xff404040)).pOnly(left:8),
                  UiHelper.verticalSpace(height: 10),
                  RowContentPrefWidget(
                    labelText: 'Security alerts',
                    trailingWidget: Image.asset('assets/images/right_arrow_1.png',height: 20,width: 10,),
                    onTap: (){CustomNavigator.push(context: context, screen: const SecurityAlerts());},
                  ),
                  RowContentPrefWidget(
                    labelText: 'Manage devices',
                    trailingWidget: Image.asset('assets/images/right_arrow_1.png',height: 20,width: 10,),
                    onTap: (){CustomNavigator.push(context: context, screen: const ManageDevice());},
                  ),
                  RowContentPrefWidget(
                      labelText: '2 - step verification',
                      trailingWidget: Row(
                        children: [
                          mediumText14(context, 'Off',textColor: const Color(0xff404040),fontWeight: FontWeight.w500),
                          const SizedBox(width: 12,),
                          Image.asset('assets/images/right_arrow_1.png',height: 20,width: 10,),
                        ],
                      )
                  ),
                  RowContentPrefWidget(
                    labelText: 'Save login info',
                    showDivider: false,
                    trailingWidget: ToggleSwitch(
                      isActive: isSaveLoginInfo,
                      onTap: () {
                        setState(() {
                          isSaveLoginInfo = !isSaveLoginInfo;
                        });
                      },
                    ),
                  ),

                ],
              ),
            ),
            UiHelper.verticalSpace(height: 20),
            Container(
              padding: const EdgeInsets.only(left: 12,right: 12,top: 12,bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xffF2F2F2),
              ),
              child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mediumText14(context,'Permissions',fontWeight:FontWeight.w500, textColor: const Color(0xff404040)).pOnly(left:8),
                  UiHelper.verticalSpace(height: 10),
                  RowContentPrefWidget(
                      labelText: 'Apps and services permissions',
                      trailingWidget: Image.asset('assets/images/right_arrow_1.png',height: 20,width: 10,),
                      onTap: (){CustomNavigator.push(context: context, screen: const ManageAppPermissions());},
                  ),
                  RowContentPrefWidget(
                      labelText: 'Browser setting',
                      showDivider: false,
                      trailingWidget: Image.asset('assets/images/right_arrow_1.png',height: 20,width: 10,)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

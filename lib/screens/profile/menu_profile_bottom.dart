import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/screens/qr/my_qr_code.dart';
import 'package:tictoc/screens/settings_policies_and_support/settingsAndPrivacy.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
class MenuProfileBottom extends StatefulWidget {
  const MenuProfileBottom({super.key});

  @override
  State<MenuProfileBottom> createState() => _MenuProfileBottomState();
}

class _MenuProfileBottomState extends State<MenuProfileBottom> {

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      reverse: true,
      child: IntrinsicHeight(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            bottom: keyboardHeight, // Add padding for the keyboard
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top:16,left: 28, right: 28, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UiHelper.verticalSpace(height: 12),
                MyInkWell(
                    onTap: ()async{

                    },
                    child: Row(
                      children: [
                        Image.asset('assets/images/studio.png',height: 20,width: 20,),
                        UiHelper.horizontalSpace(width: 14),
                        mediumText14(context, 'Tictoc Studio',textColor: const Color(0xff404040), fontWeight: FontWeight.w500),
                      ],
                    )),
                UiHelper.verticalSpace(height: 8),
                const Divider(color: appGreyColor,thickness:1,),
                UiHelper.verticalSpace(height: 8),
                MyInkWell(
                    onTap: ()async{
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const MyQrCode(),
                        withNavBar: false, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Row(
                      children: [
                        Image.asset('assets/images/qr_pink.png',height: 20,width: 20,),
                        UiHelper.horizontalSpace(width: 14),
                        mediumText14(context, 'My Qr Code',textColor: const Color(0xff404040), fontWeight: FontWeight.w500),
                      ],
                    )),
                UiHelper.verticalSpace(height: 8),
                const Divider(color: appGreyColor,thickness:1,),
                UiHelper.verticalSpace(height: 8),
                MyInkWell(
                    onTap: ()async{
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const SettingsAndPrivacy(),
                        withNavBar: false, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                      );

                    },
                    child: Row(
                      children: [
                        Image.asset('assets/images/settings_pink.png',height: 20,width: 20,),
                        UiHelper.horizontalSpace(width: 14),
                        mediumText14(context, 'Privacy Policy',textColor: const Color(0xff404040), fontWeight: FontWeight.w500),
                      ],
                    )),
                UiHelper.verticalSpace(height: 8),
                const Divider(color: appGreyColor,thickness:1,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
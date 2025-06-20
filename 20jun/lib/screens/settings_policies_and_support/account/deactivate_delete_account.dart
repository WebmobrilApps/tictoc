import 'package:flutter/material.dart';
import 'package:tictoc/screens/settings_policies_and_support/content_preference.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class DeactivateDeleteAccount extends StatefulWidget {
  const DeactivateDeleteAccount({super.key});

  @override
  State<DeactivateDeleteAccount> createState() => _DeactivateDeleteAccountState();
}

class _DeactivateDeleteAccountState extends State<DeactivateDeleteAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: ""),
      body: Padding(
        padding: const EdgeInsets.only(top:6,left:22,right: 26),
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            largeText16(context, 'Delete or deactivate?',fontSize: 20,fontWeight: FontWeight.w500),
            UiHelper.verticalSpace(height: 4),
            smallText12(context, 'Lorem ipsum dolor sit amet consectetur. Egestas in massa tincidunt tristique sit cursus. Faucibus et integer vitae nulla at lobortis a dignissim. Sodales metus urna vestibulum a fermentum amet. Dignissim sit tortor aenean donec velit.',
            textColor: const Color(0xff404040)),
            UiHelper.verticalSpace(height: 20),
            MyInkWell(
                onTap: ()async{},
                child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    largeText16(context, 'Deactivate account',fontSize: 20,fontWeight: FontWeight.w500),
                    Image.asset('assets/images/right_arrow_1.png',height: 30,width: 15,)
                  ],
                )),
            UiHelper.verticalSpace(height: 4),
            smallText12(context, 'Lorem ipsum dolor sit amet consectetur. Egestas in massa tincidunt tristique sit cursus. Faucibus et integer vitae nulla at lobortis a dignissim. Sodales metus urna vestibulum a fermentum',
                textColor: const Color(0xff404040)),
            UiHelper.verticalSpace(height: 20),
            MyInkWell(
                onTap: ()async{},
                child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    largeText16(context, 'Delete account permanently',fontSize: 20,fontWeight: FontWeight.w500),
                    Image.asset('assets/images/right_arrow_1.png',height: 30,width: 15,)
                  ],
                )),
            UiHelper.verticalSpace(height: 4),
            smallText12(context, 'Faucibus et integer vitae nulla at lobortis a dignissim. Sodales metus urna vestibulum a fermentum',
                textColor: const Color(0xff404040)),
          ],
        ),
      ),
    );
  }
}
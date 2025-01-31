import 'package:flutter/material.dart';
import 'package:tictoc/screens/settings_policies_and_support/activity_center.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
class LiveEvents extends StatefulWidget {
  const LiveEvents({super.key});

  @override
  State<LiveEvents> createState() => _LiveEventsState();
}

class _LiveEventsState extends State<LiveEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: "LIVE Events"),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              UiHelper.verticalSpace(height: screenHeight*0.25),
            Image.asset('assets/images/live_grey.png',height: 80,width: 80,),
            UiHelper.verticalSpace(height: 12),
            largeText16(context, 'No registered LIVE events',textColor: const Color(0xff86878B),
                fontSize: 18,fontWeight: FontWeight.w500),
            UiHelper.verticalSpace(height: 12),
            largeText16(context, 'Explore and participate in more LIVE Events',textColor: const Color(0xff86878B),
                fontSize: 15,fontWeight: FontWeight.w400),
            ],
          ),
        ),
      ),
    );
  }
}

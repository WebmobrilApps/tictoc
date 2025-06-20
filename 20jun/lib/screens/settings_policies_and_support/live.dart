import 'package:flutter/material.dart';
import 'package:tictoc/screens/settings_policies_and_support/activity_center.dart';
import 'package:tictoc/screens/settings_policies_and_support/live_events.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_navigator.dart';
class Live extends StatefulWidget {
  const Live({super.key});

  @override
  State<Live> createState() => _LiveState();
}

class _LiveState extends State<Live> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: "Live"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RowActivityWidget(labelText: 'Live Events', onTap: (){
                CustomNavigator.push(context: context, screen: const LiveEvents());
              },),
            ],
          ),
        ),
      ),
    );
  }

}
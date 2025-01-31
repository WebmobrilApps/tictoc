import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_appbar.dart';

import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class ManageAppPermissions extends StatefulWidget {
  const ManageAppPermissions({super.key});

  @override
  State<ManageAppPermissions> createState() => _ManageAppPermissionsState();
}

class _ManageAppPermissionsState extends State<ManageAppPermissions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: 'Manage app permissions',),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
          child: Center(
            child: Column(
              children: [
                UiHelper.verticalSpace(height: screenHeight*0.18),
                Image.asset('assets/images/no_apps_auth_yet.png',height: 70,width: 70,),
                UiHelper.verticalSpace(height: 14),
                mediumText14(context,'No apps authorized yet',
                    fontWeight:FontWeight.w500,textAlign: TextAlign.center),
                UiHelper.verticalSpace(height: 6),
                mediumText14(context,'Apps with permission to access your tictoc data\nwill appear here.',
                    fontWeight:FontWeight.w500,textColor:appGreyColor,textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

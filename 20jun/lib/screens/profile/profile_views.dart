import 'package:flutter/material.dart';
import 'package:tictoc/screens/profile/profile_view_settings_bottom.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
class ProfileViews extends StatefulWidget {
  const ProfileViews({super.key});

  @override
  State<ProfileViews> createState() => _ProfileViewsState();
}

class _ProfileViewsState extends State<ProfileViews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(title: 'Profile Views',
          actionWidget:MyInkWell(
            onTap: ()async{
              final result = await showModalBottomSheet<bool>(
                isScrollControlled: true,
                useRootNavigator: true,
                context: context,
                builder: (context) => const ProfileViewSettingsBottom(),
              );
              if (result != null) {
                setState(() {
                //  selectedImage = image;
                });
                //      Navigator.pop(context); // Close the bottom sheet
              }
            },
            child: Container(
                margin: const EdgeInsets.only(right: 5),
                child: Image.asset('assets/images/settings.png', width: 22, height: 22)),
          )),
    body:Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UiHelper.verticalSpace(height: screenHeight*0.16),
          Image.asset('assets/images/profile_history.png', width: 50, height: 50),
          const SizedBox(height: 8,),
          largeText16(context, 'Profile view history will appear here',fontWeight: FontWeight.w500),
          const SizedBox(height: 8,),
          smallText12(context, 'Lorem ipsum dolor sit amet consectetur. Sit convallis amet sapien quisque semper ultrices gravida. Suspendisse cursus ultrices felis vitae risus pellentesque vestibulum.',
              textAlign: TextAlign.center,textColor: const Color(0xff86878B), fontWeight: FontWeight.w500),
        ],
      ),
    ) ,
      );
  }
}



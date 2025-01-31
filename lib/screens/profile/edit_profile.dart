import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tictoc/screens/profile/choose_photo_bottom.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? selectedImage; // Variable to store the selected video
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: 'Edit Profile',appBarBgColor: Color(0xffF2F2F2),),
      body: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiHelper.verticalSpace(height: 24),
            Row( mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyInkWell(
                  onTap: ()async {
                    final image = await showModalBottomSheet<File?>(
                      isScrollControlled: true,
                      useRootNavigator: true,
                      context: context,
                      builder: (context) => const ChoosePhotoBottom(),
                    );
                    if (image != null) {
                      setState(() {
                        selectedImage = image;
                      });
                //      Navigator.pop(context); // Close the bottom sheet
                    }
                  },

                  child: Column(
                    children: [
                      // Image.asset('assets/images/change_photo.png',height: 60,width: 60,),
                      selectedImage != null
                          ?  ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.file(selectedImage!, height: 60, width: 60,fit: BoxFit.fill,))
                          : Image.asset('assets/images/change_photo.png', height: 60, width: 60),
                      const SizedBox(height: 2,),
                      smallText12(context, 'Change Photo',fontSize: 10),
                    ],
                  ),
                ),
                const SizedBox(width: 70,),
                Column(
                  children: [
                    Image.asset('assets/images/change_video.png',height: 60,width: 60,),
                    const SizedBox(height: 2,),
                    smallText12(context, 'Change Video',fontSize: 10),
                  ],
                ),
              ],
            ),
            UiHelper.verticalSpace(height: 24),
            smallText12(context, 'About me',fontWeight: FontWeight.w600),
            UiHelper.verticalSpace(height: 8),
            Container(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 12,bottom: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xffF2F2F2),
              ),
              child: Column(
                children: [
                  const RowCustomWidget(title: 'Name', desc: 'Thiru',),
                  const SizedBox(height: 10,),
                  const RowCustomWidget(title: 'Username', desc: 'thiru@003',),
                  const SizedBox(height: 10,),
                  RowCustomWidget(title: 'TicToc id',
                    desc: 'tictoc.com/@usernametictoc',
                    trailingIcon: Image.asset('assets/images/copy_id.png',height: 12.5, width: 13,
                  ),),
                  const SizedBox(height: 10,),
                  const RowCustomWidget(title: 'Bio', desc: 'Alpha men',),
                  const SizedBox(height: 10,),
                  const RowCustomWidget(title: 'Links', desc: 'Add',),

                ],
              ),),
            UiHelper.verticalSpace(height: 24),
            smallText12(context, 'Social',fontWeight: FontWeight.w600),
            UiHelper.verticalSpace(height: 8),
            Container(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 12,bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xffF2F2F2),
              ),
              child: const Column(
                children: [
                  RowCustomWidget(title: 'Instagram', desc: 'Add Instagram',),
                  SizedBox(height: 10,),
                  RowCustomWidget(title: 'YouTube', desc: 'Add YouTube',),
                ],
              ),),
            UiHelper.verticalSpace(height: 24),
            smallText12(context, 'Change display order',fontWeight: FontWeight.w600),
            UiHelper.verticalSpace(height: 8),
            Container(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 14,bottom: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xffF2F2F2),
              ),
              child:  Column(
                children: [
                  RowCustomWidget(title: 'TicToc Studio', desc: '',
                    trailingIcon:Image.asset('assets/images/menu_grey.png',height: 26,width: 26,),
                  ),
                ],
              ),),
          ],
        ),
      ),
    );
  }
}

class RowCustomWidget extends StatelessWidget {
  final String title;
  final String desc;
  final Widget? trailingIcon; // Pass the widget directly (e.g., Image.asset)
  final VoidCallback? onTap;

  const RowCustomWidget({
    super.key,
    required this.title,
    required this.desc,
    this.trailingIcon, // Optional trailing widget
    this.onTap, // Optional onTap callback
  });

  @override
  Widget build(BuildContext context) {
    return MyInkWell(
      onTap: () async {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 3,
              child: mediumText14(context, title)),
          const SizedBox(width: 12,),
          Expanded(
            flex: 8,
            child: Row( mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(child: smallText12(context, desc,
                    maxLines: 1,overflow: TextOverflow.ellipsis,
                    textColor: const Color(0xff404040))),
                const SizedBox(width: 12),
                trailingIcon ?? // If no icon is provided, show nothing
                    Image.asset(
                      'assets/images/right_arrow.png', // Default image
                      color: const Color(0xff404040),
                      height: 10,
                      width: 6,
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

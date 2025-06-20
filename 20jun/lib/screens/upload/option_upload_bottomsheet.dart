import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';

class OptionUploadBottomSheet extends StatefulWidget {
  const OptionUploadBottomSheet({super.key});

  @override
  State<OptionUploadBottomSheet> createState() => _OptionUploadBottomSheetState();
}

class _OptionUploadBottomSheetState extends State<OptionUploadBottomSheet> {

  final ImagePicker _picker = ImagePicker();
  File? _selectedVideo;

  Future<void> _pickVideo(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickVideo(source: source);
    if (pickedFile != null) {
      setState(() {
        // Create a File instance from the picked video
        _selectedVideo = File(pickedFile.path);
      });

      // Close the bottom sheet and pass the selected video back
      Navigator.pop(context, _selectedVideo);
    }
  }

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
            padding: const EdgeInsets.only(top:18,left: 22, right: 22, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                largeText16(context, 'Choose From',textColor: bgColor,fontSize: 20,fontWeight: FontWeight.w500),
                UiHelper.verticalSpace(height: 28),
                Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyInkWell(
                      onTap: () async {
                        _pickVideo(ImageSource.camera); // Call the camera source
                      },
                      child: Column(
                        children: [
                          Image.asset('assets/images/camera1.png',height: 60,width: 60,),
                          const SizedBox(height: 4,),
                          largeText16(context, 'Camera',textColor: bgColor,fontSize: 18,fontWeight: FontWeight.w400),
                        ],
                      ),
                    ),
                    const SizedBox(width: 100,),
                    MyInkWell(
                      onTap: ()async{
                        _pickVideo(ImageSource.gallery);
                      },
                      child: Column(
                        children: [
                          Image.asset('assets/images/gallery.png',height: 60,width: 60,),
                          const SizedBox(height: 4,),
                          largeText16(context, 'Gallery',textColor: bgColor,fontSize: 18,fontWeight: FontWeight.w400),
                        ],
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

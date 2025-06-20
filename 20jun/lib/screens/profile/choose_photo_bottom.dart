import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
class ChoosePhotoBottom extends StatefulWidget {
  const ChoosePhotoBottom({super.key});

  @override
  State<ChoosePhotoBottom> createState() => _ChoosePhotoBottomState();
}

class _ChoosePhotoBottomState extends State<ChoosePhotoBottom> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  File? _selectedVideo;


  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        // Create a File instance from the picked video
        _selectedImage = File(pickedFile.path);
      });

      // Close the bottom sheet and pass the selected video back
      Navigator.pop(context, _selectedImage);
    }
  }
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
            padding: const EdgeInsets.only(top:15,left: 0, right: 0, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UiHelper.verticalSpace(height: 12),
                MyInkWell(
                    onTap: ()async{
                      _pickImage(ImageSource.camera);
                    },
                    child: largeText16(context, 'Take Photo',textColor: const Color(0xff404040), fontWeight: FontWeight.w500)),
                UiHelper.verticalSpace(height: 10),
                const Divider(color: appGreyColor,thickness:1,),
                UiHelper.verticalSpace(height: 10),
                MyInkWell(
                    onTap: ()async{
                      _pickImage(ImageSource.gallery);
                    },child: largeText16(context, 'Select from Gallery',textColor: const Color(0xff404040), fontWeight: FontWeight.w500)),
                UiHelper.verticalSpace(height: 10),
                const Divider(color: appGreyColor,thickness:1,),
                UiHelper.verticalSpace(height: 10),
                largeText16(context, 'View photo',textColor: const Color(0xff404040), fontWeight: FontWeight.w500),
                UiHelper.verticalSpace(height: 10),
                const Divider(color: appGreyColor,thickness:1,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
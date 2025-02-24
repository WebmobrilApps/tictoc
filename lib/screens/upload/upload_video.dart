import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/screens/auth/forgot_password.dart';
import 'package:tictoc/screens/upload/chewie_video_player.dart';
import 'package:tictoc/screens/upload/option_upload_bottomsheet.dart';
import 'package:tictoc/screens/upload/video_player.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class UploadVideo extends StatefulWidget {
  final PersistentTabController controller;
  const UploadVideo({super.key, required this.controller});


  @override
  State<UploadVideo> createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  File? selectedVideo; // Variable to store the selected video

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: whiteColor, // Green status bar
        statusBarIconBrightness: Brightness.dark, // Light icons for better contrast
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: 'Upload Video',
          onBackPressed: () {
            Navigator.of(context).pop();
           // widget.controller.jumpToTab(0); // Navigate to Home tab directly
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: selectedVideo == null ?
                  MyInkWell(
                    onTap: () async {
                      final video = await showModalBottomSheet<File?>(
                        isScrollControlled: true,
                        useRootNavigator: true,
                        context: context,
                        builder: (context) => const OptionUploadBottomSheet(),
                      );
                      if (video != null) {
                        setState(() {
                          selectedVideo = video;
                        });
                      }
                    },
                    child: Image.asset('assets/images/upload_video.png', height: 180, width: double.infinity, fit: BoxFit.cover,).pOnly(right:18),)
                    : Stack(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 20,right: 18),
                            child: ChewieVideoPlayer(videoFile: selectedVideo)),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                          icon: Icon(Icons.cancel, color: Colors.red,size: 30,),
                          onPressed: () {
                            setState(() {
                              selectedVideo = null;
                            });

                            // Handle like
                          },
                        ),
                        )
                      ],
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18,right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UiHelper.verticalSpace(height: 10),
                    mediumText14(context, 'Lorem ipsum amet consectetur. Quisque dictum lectus amet ornare nam volutpat scelerisque.',textColor: appGreyColor),
                    UiHelper.verticalSpace(height: 10),
                    MyInkWell(
                      onTap: () async {
                        final video = await showModalBottomSheet<File?>(
                          isScrollControlled: true,
                          useRootNavigator: true,
                          context: context,
                          builder: (context) => const OptionUploadBottomSheet(),
                        );
                        if (video != null) {
                          setState(() {
                            selectedVideo = video;
                          });
                        }
                      },
                      child: Container(
                          padding:  const EdgeInsets.only(left:18,right:18,top:8,bottom: 8),
                          decoration:  BoxDecoration(
                            color:const Color(0xffe9eaf0),
                            borderRadius: BorderRadius.circular(0.0),),
                          child: smallText12(context, 'Upload File',textColor: appBlackColor,
                              fontSize: 9,fontWeight: FontWeight.w600)),
                    ),
                    UiHelper.verticalSpace(height: 10),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w500,color: appBlackColor,),
                        children: [
                          const TextSpan(
                            text: "Note:",
                          ),
                          TextSpan(
                            text: "  All files should be at least 720p and less than 4.0 GB.",
                            style: GoogleFonts.poppins(fontSize: 10,fontWeight: FontWeight.w400,color: appGreyColor,),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                //    CustomNavigator.push(context: context, screen: const SignUp());
                              },
                          ),
                        ],
                      ),
                    ),
                    UiHelper.verticalSpace(height: 30),
                    mediumText14(context, 'Add Description',textColor: appGreyColor,fontWeight: FontWeight.w500),
                    UiHelper.verticalSpace(height: 8),
                    Container(
                      // height: 134,
                      // width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11.5),
                        border: Border.all(color:appGreyColor, width: 1.0,
                            style: BorderStyle.solid),
                      ),
                      child: TextFormField(
                        controller: descriptionController,
                        minLines: 4, // Initial number of lines
                        maxLines: null, // Allows the TextFormField to expand dynamically
                        style: const TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: appBlackColor
                        ),
                        decoration: const InputDecoration(
                          hintText: '',
                          hintStyle: TextStyle(
                            color: appGreyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          border:InputBorder.none,
                          focusedBorder:InputBorder.none,
                          enabledBorder:InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        ),

                      ),
                    ),
                    UiHelper.verticalSpace(height: 20),
                    mediumText14(context, 'Add Category',textColor: appGreyColor,fontWeight: FontWeight.w500),
                    UiHelper.verticalSpace(height: 8),
                    TextFormFieldWithLabel(
                      controller: nameController,
                      hintText: '#Categoryname #Namecategory #newvideo',
                      textInputAction:TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      bottomBorderColor:appGreyColor,
                      textFontColor: appBlackColor,
                      cursorColor:Colors.grey,
                      contentPadding : const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    UiHelper.verticalSpace(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(left: 25,right: 25),
                      child: pinkButton(context: context, labelText: 'Upload',
                        /*  onTap: ()async{
                            showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                              //   BottomSheetContent(contest: contest!),
                              // const OTPVerification(fromPage:'signUp'),
                              const OptionUploadBottomSheet(),
                              isScrollControlled: true,
                              useRootNavigator: true,
                            );
                          },*/

                      ),
                    ),
                  ],
                ),
              ),
              UiHelper.verticalSpace(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

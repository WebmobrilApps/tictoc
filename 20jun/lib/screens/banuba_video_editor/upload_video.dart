
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/upload_content_response.dart';
import 'package:tictoc/screens/upload/option_upload_bottomsheet.dart';
import 'package:tictoc/screens/banuba_video_editor/chewieew_vide_player.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';

class UploadVideo extends StatefulWidget {
  final PersistentTabController controller;
  final File? videoFile;
  const UploadVideo({super.key, this.videoFile, required this.controller});

  @override
  State<UploadVideo> createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  File? selectedVideo; // Variable to store the selected video
  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

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
            arrowBeforeWidth:10,
          onBackPressed: () {

            Navigator.of(context).pop();
            // widget.controller.jumpToTab(0); // Navigate to Home tab directly
          },
        ),
        body: BlocConsumer<TicTocCubit, TicTocState>(
          listener: (context, state) {
            if (state.status == TicTocStatus.uploadContentSuccess) {
              UploadContentResponse uploadContentResponse = state.responseData?.response as UploadContentResponse;
              UiHelper.toastMessage(uploadContentResponse.msg ?? '');
              Navigator.of(context).pop();

            }
            if (state.status == TicTocStatus.uploadContentError) {
              print(state.errorData?.message);
              String message = state.errorData?.message ?? state.error ?? "";
              UiHelper.toastMessage(message);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: widget.videoFile != null
                        ? ChewieVideoPlayer(videoFile: widget.videoFile) // Pass video to ChewieVideoPlayer
                        :  Image.asset(
                      'assets/images/upload_video.png',
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18,right: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UiHelper.verticalSpace(height: 12),
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
                        UiHelper.verticalSpace(height: 25),
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
                          controller: categoryController,
                          hintText: '#Categoryname #Namecategory #newvideo',
                          textInputAction:TextInputAction.done,
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
                              isLoading: state.status == TicTocStatus.uploadContentLoading,
                              onTap: (){
                                if(descriptionController.text.isEmpty){
                                  UiHelper.toastMessage('Please enter description');
                                }else if(categoryController.text.isEmpty){
                                  UiHelper.toastMessage('Please enter category');
                                }else{
                                  // Split based on '#' and remove empty entries
                                  List<String> tags = categoryController.text.split('#').where((tag) => tag.trim().isNotEmpty).toList();

                                  print(tags); // Output: [native, work, song]
                                  BlocProvider.of<TicTocCubit>(context).uploadContentCall(widget.videoFile, descriptionController.text, tags);
                                }
                              }

                          ),
                        ),
                      ],
                    ),
                  ),
                  UiHelper.verticalSpace(height: 80),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}


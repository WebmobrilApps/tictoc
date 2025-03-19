import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/get_profile_response.dart';
import 'package:tictoc/screens/profile/choose_photo_bottom.dart';
import 'package:tictoc/screens/profile/widgets/edit_profile_fields.dart';
import 'package:tictoc/screens/profile/widgets/row_edit_profile_widget.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
class EditProfile extends StatefulWidget {
  final GetProfileResponse getProfileResponse;
  const EditProfile({super.key, required this.getProfileResponse});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? selectedImage; // Variable to store the selected video
  @override
  Widget build(BuildContext context) {
    final profileData = widget.getProfileResponse.data; // Shorter reference
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: 'Edit Profile',appBarBgColor: Color(0xffF2F2F2),),
      body: BlocConsumer<TicTocCubit,TicTocState>(
        listener: (context,state){
          if (state.status == TicTocStatus.updateProfileSuccess){
            UiHelper.toastMessage(state.responseData?.response ?? '');
          }
          else if(state.status == TicTocStatus.updateProfileError){
            print(state.errorData?.message);
            String message = state.errorData?.message ?? state.error ?? "";
            UiHelper.toastMessage(message);
          }
        },
        builder: (context,state){
          return  Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,top: 16),
            child: SingleChildScrollView(
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
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xff404040), width: 0.75), // Border color and width
                                borderRadius: BorderRadius.circular(50),),
                              child: selectedImage!= null
                                  ?  ClipOval(
                                  child: Image.file(selectedImage!, height: 60, width: 60,fit: BoxFit.fill,)):
                              profileData?.profilePic== null?Image.asset('assets/images/change_photo.png', height: 60, width: 60):
                              cachedImageWidget(
                                  image:"$BASEURL/${profileData?.profilePic??''}",
                                  borderRadiusValue:50,
                                  height: 60,width: 60),),
                            const SizedBox(height: 2,),
                            smallText12(context, 'Change Photo',fontSize: 10),
                            /*  selectedImage != null
                            ?  ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.file(selectedImage!, height: 60, width: 60,fit: BoxFit.fill,))
                            : Image.asset('assets/images/change_photo.png', height: 60, width: 60),
                        const SizedBox(height: 2,),
                        smallText12(context, 'Change Photo',fontSize: 10),*/
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
                        RowEditProfileWidget(title: 'Name', desc: profileData?.name??'',
                            onTap:() async {
                              final updatedValue = await Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>  EditProfileFields(titleName: 'Name', titleValue: profileData?.name ?? ''),),
                              );
                              print('updatedValue:$updatedValue');
                              if (updatedValue != null) {
                                setState(() {
                                  profileData?.name = updatedValue; // Update UI with new value
                                });}},),
                        const SizedBox(height: 10,),
                        RowEditProfileWidget(title: 'Username', desc: profileData?.username??'',),
                        const SizedBox(height: 10,),
                        RowEditProfileWidget(title: 'TicToc id',
                          desc: profileData?.tictocid??'',
                          trailingIcon: Image.asset('assets/images/copy_id.png',height: 12.5, width: 13,
                          ),),
                        const SizedBox(height: 10,),
                        RowEditProfileWidget(title: 'Bio', desc:  profileData?.bio??'Add',
                          onTap:() async {
                            final updatedValue = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>  EditProfileFields(titleName: 'Bio', titleValue: profileData?.bio ?? ''),),
                            );
                            print('updatedValue:$updatedValue');
                            if (updatedValue != null) {
                              setState(() {
                                profileData?.bio = updatedValue; // Update UI with new value
                              });}},),
                     //   const SizedBox(height: 10,),
                      //  RowEditProfileWidget(title: 'Links', desc: profileData?.link?.map((e) => e.link).join(", ") ?? 'Add', ),
              
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
                        RowEditProfileWidget(title: 'Instagram', desc: 'Add Instagram',),
                        SizedBox(height: 10,),
                        RowEditProfileWidget(title: 'YouTube', desc: 'Add YouTube',),
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
                        RowEditProfileWidget(title: 'TicToc Studio', desc: '',
                          trailingIcon:Image.asset('assets/images/menu_grey.png',height: 26,width: 26,),
                        ),
                      ],
                    ),),
                  UiHelper.verticalSpace(height: 18),
                  Center(child: pinkButton(context: context,  width: 285,
                      isLoading: state.status == TicTocStatus.updateProfileLoading,
                      labelText: 'Update',
                      onTap: (){
                        BlocProvider.of<TicTocCubit>(context).updateProfileCall(
                            selectedImage,
                            profileData?.name??'',
                            jsonEncode(profileData?.link?.map((e) => e.toJson()).toList() ?? []),
                            profileData?.bio??'',);
                      }
                  )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}




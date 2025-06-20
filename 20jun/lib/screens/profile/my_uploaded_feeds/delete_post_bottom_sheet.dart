import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/delete_post_response.dart';
import 'package:tictoc/screens/auth/sign_in.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/shared_preference.dart';
import 'package:tictoc/utils/ui_helper.dart';

class DeletePostBottomSheet extends StatefulWidget {
  final String contentId;
  const DeletePostBottomSheet({super.key, required this.contentId});

  @override
  State<DeletePostBottomSheet> createState() => _DeletePostBottomSheetState();
}

class _DeletePostBottomSheetState extends State<DeletePostBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<TicTocCubit>().state; // 👈 this line is key!
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
            padding: const EdgeInsets.only(top:12,left: 28, right: 28, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UiHelper.verticalSpace(height: 12),
                largeText16(context,'Delete',fontWeight: FontWeight.w600,textColor: const Color(0xff404040)),
                UiHelper.verticalSpace(height: 18),
                mediumText14(context, 'Are you sure you want to Delete this post',
                    textAlign: TextAlign.center,fontWeight: FontWeight.w500,textColor: const Color(0xff404040)),
                UiHelper.verticalSpace(height: 40),
                Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmallPinkButton(label: 'Yes',fontSize:16,fontWeight: FontWeight.w500,
                      isLoading: state.status == TicTocStatus.deletePostLoading,
                      padding :const EdgeInsets.symmetric(horizontal: 38, vertical: 4),
                      borderRadius: const BorderRadius.all(Radius.circular(22.5),),
                      onTap: (){
                     //   Navigator.pop(context, {'deleted': true, 'id': widget.contentId});
                         BlocProvider.of<TicTocCubit>(context).deletePostCall(widget.contentId).whenComplete((){
                          TicTocState state = BlocProvider.of<TicTocCubit>(context).state;
                          if(state.status == TicTocStatus.deletePostSuccess){
                              DeletePostResponse deletePostResponse = state.responseData?.response as DeletePostResponse;
                              UiHelper.toastMessage(deletePostResponse.msg ?? '');
                              Navigator.pop(context, {'deleted': true, 'id': widget.contentId});
                          }
                          if (state.status == TicTocStatus.deletePostError) {
                            UiHelper.toastMessage(state.errorData?.message ?? state.error ?? "");
                            }
                        });
                      },
                    ),
                    const SizedBox(width: 60,),
                    SmallPinkButton(label: 'No',fontSize:16,fontWeight: FontWeight.w500,
                      backgroundColor:Colors.white,textColor:buttonColor,
                      border: Border.all(color: buttonColor, width: 1.0),
                      padding :const EdgeInsets.symmetric(horizontal: 38, vertical: 4),
                      borderRadius: const BorderRadius.all(Radius.circular(22.5),),
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                UiHelper.verticalSpace(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
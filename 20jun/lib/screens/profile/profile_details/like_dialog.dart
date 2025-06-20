import 'package:flutter/material.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';

class LikeDialog extends StatelessWidget {
  final String totalLikes;

  const LikeDialog({
    super.key,
    required this.totalLikes,
  });


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      elevation: 0,
      insetPadding: const EdgeInsets.all(35),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
      titlePadding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 12),
      contentPadding: const EdgeInsets.only(left: 20, right: 20),
      alignment: Alignment.center,
      actionsOverflowButtonSpacing: 6.0,
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UiHelper.verticalSpace(height: 42),
              Image.asset('assets/images/total_likes.png',width: 197,height: 140,),
              UiHelper.verticalSpace(height: 32),
              Center(child: largeText16(context, '$totalLikes Likes', fontSize: 25,textColor: Colors.white, fontWeight: FontWeight.w700)),
              UiHelper.verticalSpace(height: 32),
            ],
          ),
        ),
      ),
      actions: <Widget>[],
    );
  }
}



import 'package:flutter/material.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
class ShareProfile extends StatefulWidget {
  const ShareProfile({super.key});

  @override
  State<ShareProfile> createState() => _ShareProfileState();
}

class _ShareProfileState extends State<ShareProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: CustomAppBar(title: '',
        arrowBeforeWidth:12,
        actionWidget: Image.asset('assets/images/scan.png',height: 40,width: 40,),),
      body: Padding(
        padding: const EdgeInsets.only(top:45,left: 35,right: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              margin:  const EdgeInsets.only(left: 6,right: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xffE9E9E9),
              ),
              child: Column(
                children: [
                  largeText16(context, 'Thiru Sounder',fontWeight: FontWeight.w500,),
                  mediumText14(context, '@thiru003'),
                  UiHelper.verticalSpace(height: 20),
                  Image.asset('assets/images/qr.png',height: 190.48,width: 190.48,),
                  UiHelper.verticalSpace(height: 14),
                  Image.asset('assets/images/tictoc_qr.png',height: 34,width: 34,),
                ],
              ),
            ),
            const SizedBox(height: 35,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset('assets/images/copy_link.png',height: 30,width: 30,),
                    const SizedBox(height: 4,),
                    mediumText14(context, 'Copy Link',textColor: appGreyColor,fontWeight: FontWeight.w500)
                  ],
                ),

                Column(
                  children: [
                    Image.asset('assets/images/save.png',height: 35,width: 35,),
                    const SizedBox(height: 4,),
                    mediumText14(context, 'Save QR Code',textColor: appGreyColor,fontWeight: FontWeight.w500)
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

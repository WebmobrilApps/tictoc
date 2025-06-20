import 'package:flutter/material.dart';
import 'package:tictoc/screens/settings_policies_and_support/common_policy.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class MyQrCode extends StatefulWidget {
  const MyQrCode({super.key});

  @override
  State<MyQrCode> createState() => _MyQrCodeState();
}

class _MyQrCodeState extends State<MyQrCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar:  const CustomAppBar(title: 'My Tictoc QR',fontWeight:FontWeight.w500,
        textColor: Color(0xff404040),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:25,left: 40,right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(  alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/qr_bg.png',height: 360,width:double.infinity,fit: BoxFit.fill,),
                  Positioned( top: 40,
                    child: Stack(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(right:12.0),
                            child: Image.asset('assets/images/qr.png',height: 160,width: 150,)),
                        Positioned(
                            right: 0,
                            top: 160 / 2 - 17, // Align vertically at the cen
                            child: Transform.rotate(
                                angle: 0.1,
                                child: Image.asset('assets/images/tictoc_qr.png',height: 34,width: 34,))),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight*0.2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Image.asset('assets/images/save_qr.png',height: 40,width: 40,),
                      const SizedBox(height: 12,),
                      smallText12(context, 'Save QR Code',textColor: appGreyColor,fontWeight: FontWeight.w500)
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset('assets/images/scan.png',height: 40,width: 40,),
                      const SizedBox(height: 12,),
                      smallText12(context, 'Scan',textColor: appGreyColor,fontWeight: FontWeight.w500)
                    ],
                  ),
                ],
              ).pOnly(left: 12,right: 12),
            ],
          ),
        ),
      ),
    );
  }
}
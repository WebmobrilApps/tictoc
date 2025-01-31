import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/screens/notification/system_notification_setting.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/see_more.dart';
import 'package:tictoc/utils/ui_helper.dart';
class SystemNotification extends StatefulWidget {
  const SystemNotification({super.key});

  @override
  State<SystemNotification> createState() => _SystemNotificationState();
}

class _SystemNotificationState extends State<SystemNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: CustomAppBar(title: 'System notification',
        appBarBgColor: const Color(0xffF2F2F2),
        actionWidget: MyInkWell(
            onTap: ()async{
              CustomNavigator.push(context: context, screen: const SystemNotificationSetting());
            },
            child: Image.asset('assets/images/settings.png',height: 22,width: 22,)),),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:18,left: 18,right: 18),
          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/account_update.png',height: 34,width: 34,),
              smallText12(context, 'Account\nupdates',textColor: const Color(0xff404040)),
              UiHelper.verticalSpace(height: 16),
              Container(
                padding: const EdgeInsets.only(left: 18,right: 18,top: 12,bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xffF2F2F2),
                ),
                child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 12,),
                        Image.asset('assets/images/account_update.png',height: 25,width: 25,),
                        const SizedBox(width: 8,),
                        smallText12(context, 'Account updates',fontWeight:FontWeight.w500,
                            textColor: const Color(0xff404040)),
                        const SizedBox(width: 12,),
                      ],
                    ),
                    const Divider(color: Color(0xffD9D9D9),),
                    UiHelper.verticalSpace(height: 6),
                    mediumText14(context, 'Comment safety tools',fontWeight:FontWeight.w500,
                        textColor: const Color(0xff404040)),
                    UiHelper.verticalSpace(height: 4),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.jost(fontSize: 12,fontWeight: FontWeight.w400,color: const Color(0xff404040),),
                        children: [
                          const TextSpan(
                            text: "Manage triggering comments on your videos with our comment safety tolls.     ",
                          ),
                          TextSpan(
                            text: "11/10",
                            style: GoogleFonts.jost(fontSize: 12,fontWeight: FontWeight.w500,color: appGreyColor,),
                          ),
                        ],
                      ),
                    ),
                    UiHelper.verticalSpace(height: 8),
                    const Divider(color: Color(0xffD9D9D9),),
                    UiHelper.verticalSpace(height: 8),
                    Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        smallText12(context, 'View More',fontWeight:FontWeight.w400,
                            textColor: const Color(0xff404040)),
                        Image.asset('assets/images/right_arrow.png',height: 10,width: 6,color: const Color(0xff404040),)
                      ],
                    ),

                  ],
                ),),
              UiHelper.verticalSpace(height: 16),
              Container(
                padding: const EdgeInsets.only(left: 18,right: 18,top: 12,bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xffF2F2F2),
                ),
                child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 12,),
                        Image.asset('assets/images/account_update.png',height: 25,width: 25,),
                        const SizedBox(width: 8,),
                        smallText12(context, 'Account updates',fontWeight:FontWeight.w500,
                            textColor: const Color(0xff404040)),
                        const SizedBox(width: 12,),
                      ],
                    ),
                    const Divider(color: Color(0xffD9D9D9),),
                    UiHelper.verticalSpace(height: 6),
                    mediumText14(context, 'Upload longer videos',fontWeight:FontWeight.w500,
                        textColor: const Color(0xff404040)),
                    UiHelper.verticalSpace(height: 4),
                    const SeeMoreText(text: 'Upload videos up to 10 minutes long from your device. Make sure you’re using the latest version of TicToc before trying out on you Upload videos up to 10 minutes long from your device. Make sure you’re using the latest version of TicToc before trying out on you'),

                  ],
                ),),
              UiHelper.verticalSpace(height: 16),
              Container(
                padding: const EdgeInsets.only(left: 18,right: 18,top: 12,bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xffF2F2F2),
                ),
                child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 12,),
                        Image.asset('assets/images/account_update.png',height: 25,width: 25,),
                        const SizedBox(width: 8,),
                        smallText12(context, 'Account updates',fontWeight:FontWeight.w500,
                            textColor: const Color(0xff404040)),
                        const SizedBox(width: 12,),
                      ],
                    ),
                    const Divider(color: Color(0xffD9D9D9),),
                    UiHelper.verticalSpace(height: 6),
                    mediumText14(context, 'your email was updated',fontWeight:FontWeight.w500,
                        textColor: const Color(0xff404040)),
                    UiHelper.verticalSpace(height: 4),
                   smallText12(context, 'Lorem ipsum dolor sit amet consectetur. Vitae egestas mauris enim non a. Fringilla blandit malesuada nullam mattis tellus quam imperdiet. Fermentum nullamtincidunt.',
                   textColor: Color(0xff404040)
                   ),
                    UiHelper.verticalSpace(height: 8),
                    const Divider(color: Color(0xffD9D9D9),),
                    UiHelper.verticalSpace(height: 8),
                    Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        smallText12(context, 'View More',fontWeight:FontWeight.w400,
                            textColor: const Color(0xff404040)),
                        Image.asset('assets/images/right_arrow.png',height: 10,width: 6,color: const Color(0xff404040),)
                      ],
                    ),

                  ],
                ),),
              UiHelper.verticalSpace(height: 16),
              Container(
                padding: const EdgeInsets.only(left: 18,right: 18,top: 12,bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xffF2F2F2),
                ),
                child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 12,),
                        Image.asset('assets/images/account_update.png',height: 25,width: 25,),
                        const SizedBox(width: 8,),
                        smallText12(context, 'Account updates',fontWeight:FontWeight.w500,
                            textColor: const Color(0xff404040)),
                        const SizedBox(width: 12,),
                      ],
                    ),
                    const Divider(color: Color(0xffD9D9D9),),
                    UiHelper.verticalSpace(height: 6),
                    mediumText14(context, 'You can now log in with your emil',fontWeight:FontWeight.w500,
                        textColor: const Color(0xff404040)),
                    UiHelper.verticalSpace(height: 4),
                    smallText12(context, 'Lorem ipsum dolor sit amet consectetur. Vitae egestas mauris enim non a. Fringilla blandit malesuada nullam mattis tellus quam imperdiet. Fermentum nullamtincidunt.',
                        textColor: const Color(0xff404040)
                    ),
                    UiHelper.verticalSpace(height: 8),
                    const Divider(color: Color(0xffD9D9D9),),
                    UiHelper.verticalSpace(height: 8),
                    Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        smallText12(context, 'View More',fontWeight:FontWeight.w400,
                            textColor: const Color(0xff404040)),
                        Image.asset('assets/images/right_arrow.png',height: 10,width: 6,color: const Color(0xff404040),)
                      ],
                    ),

                  ],
                ),),
              UiHelper.verticalSpace(height: 30),
            ],
          ),
        ),
      ) ,
    );
  }
}

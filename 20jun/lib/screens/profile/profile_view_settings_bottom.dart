import 'package:flutter/material.dart';
import 'package:tictoc/screens/auth/forgot_password.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class ProfileViewSettingsBottom extends StatefulWidget {
  const ProfileViewSettingsBottom({super.key});

  @override
  State<ProfileViewSettingsBottom> createState() => _ProfileViewSettingsBottomState();
}

class _ProfileViewSettingsBottomState extends State<ProfileViewSettingsBottom> {
  bool isHideHistory = false;
  final animationDuration = const Duration(milliseconds: 300);
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UiHelper.verticalSpace(height: 24),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 30,),
                child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    largeText16(context, 'Profile view',textColor: const Color(0xff404040), fontWeight: FontWeight.w500),
                    MyInkWell(
                        onTap: ()async{
                          Navigator.of(context).pop();
                        },
                        child: Image.asset('assets/images/clear.png',color:const Color(0xff404040),height: 20,width: 20,))
                  ],
                ),
              ),
              UiHelper.verticalSpace(height: 8),
              const Divider(color: blackColor,thickness:0.4).pOnly(left: 18,right: 18),
              UiHelper.verticalSpace(height: 18),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30,),
                child: Column(
                  children: [
                    Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        mediumText14(context, 'Profile view history',textColor: const Color(0xff404040),
                            fontWeight: FontWeight.w500),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              isHideHistory = !isHideHistory;
                            });
                            /* BlocProvider.of<OnlyAsianCubit>(context).showActiveUserStatusCall1(isHideHistory==true?AppConstants.onlineNow:AppConstants.offlineNow);
                          loader(context);*/
                          },
                          child: AnimatedContainer(
                            height: 20,
                            width: 45,
                            decoration:
                            isHideHistory ?
                            BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: const Color(0xffD9D9D9), width: 1.5),
                              color: const Color(0xffD9D9D9),
                            ):
                            BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: const Color(0xffFFC0CC),width: 0.0),
                              color: const Color(0xffFFC0CC),
                            ),
                            duration: animationDuration,
                            child: AnimatedAlign(
                              alignment: isHideHistory ?
                              Alignment.centerLeft: Alignment.centerRight,
                              duration: animationDuration,
                              child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: isHideHistory?
                                   const BoxDecoration(
                                    color: whiteColor,
                                    shape: BoxShape.circle,
                                  ):
                                  const BoxDecoration(
                                    color:  Color(0xffFE2C55),
                                    shape: BoxShape.circle,
                                  )
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12,),
                    smallText12(context, 'Lorem ipsum dolor sit amet consectetur. Ligula velit ac ipsum tellus metus et aenean est in. A est pellentesque turpis aliquam eratsollicitudin. Ut sed praesent laoreet pharetra sed. Arcu tristique id namet. Elit feugiatac quis. Nunc tristique amet sed dictum sed. Tincidunt tortoreu viverra eget accumsan ipsum ultrices laoreet. Sapien idnunc aliquam ligulami. Sed etiam iaculis neque felis aliquet quis. Nulla nisl vulputate erat est. ',
                        textColor: const Color(0xff404040),fontSize: 10,),
                  ],
                ),
              ),
              UiHelper.verticalSpace(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
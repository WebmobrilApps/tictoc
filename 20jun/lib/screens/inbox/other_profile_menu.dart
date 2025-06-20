import 'package:flutter/material.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
class OtherProfileMenu extends StatefulWidget {
  const OtherProfileMenu({super.key});

  @override
  State<OtherProfileMenu> createState() => _OtherProfileMenuState();
}

class _OtherProfileMenuState extends State<OtherProfileMenu> {
  bool isMuteNotification = true;
  bool isPinToTop = true;
  bool isBlock = true;
  final animationDuration = const Duration(milliseconds: 300);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const CustomAppBar(title: 'Details',
        appBarBgColor:  Color(0xffF2F2F2),fontSize: 18,fontWeight: FontWeight.w500,),
      body: Padding(
        padding: const EdgeInsets.only(left: 22,right: 26,top: 18),
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: MyInkWell(
                    onTap:()async{
                      //   Navigator.of(context).pop();
                   //   CustomNavigator.push(context: context, screen: OtherProfileDetails(userId:suggestedData.pkUser.toString()));
                    },
                    child: Row(
                      children: [
                        Image.asset('assets/images/inbox2.png', height: 50, width: 50,),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              mediumText14(context,'DisaSmith', maxLines: 1,overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w500),
                              smallText12(context, '@disasmith356',  maxLines: 1,overflow: TextOverflow.ellipsis,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Image.asset('assets/images/right_arrow.png', height: 11, width: 6),
                const SizedBox(width: 10,),
              ],
            ),
            UiHelper.verticalSpace(height: 24),
            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                mediumText14(context, 'Mute notification',fontWeight: FontWeight.w500,
                    textColor: const Color(0xff484848)),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      isMuteNotification = !isMuteNotification;
                    });
                    /* BlocProvider.of<OnlyAsianCubit>(context).showActiveUserStatusCall1(isMuteNotification==true?AppConstants.onlineNow:AppConstants.offlineNow);
                          loader(context);*/
                  },
                  child: AnimatedContainer(
                    height: 28,
                    width: 54,
                    decoration:
                    isMuteNotification ?
                    BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xffD9D9D9), width: 2.5),
                      color: const Color(0xffD9D9D9),
                    ):
                    BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xff009966),width: 2.5),
                      color: const Color(0xff009966),
                    ),
                    duration: animationDuration,
                    child: AnimatedAlign(
                      alignment: isMuteNotification ?
                      Alignment.centerLeft: Alignment.centerRight,
                      duration: animationDuration,
                      child: Container(
                          height: 24,
                          width: 24,
                          decoration: isMuteNotification?
                          const BoxDecoration(
                            color:  AppColors.whiteColor,
                            shape: BoxShape.circle,
                          ):
                          const BoxDecoration(
                            color: AppColors.whiteColor,
                            shape: BoxShape.circle,
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
            UiHelper.verticalSpace(height: 12),
            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                mediumText14(context, 'Pin to top',fontWeight: FontWeight.w500,
                    textColor: const Color(0xff484848)),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      isPinToTop = !isPinToTop;
                    });
                    /* BlocProvider.of<OnlyAsianCubit>(context).showActiveUserStatusCall1(isPinToTop==true?AppConstants.onlineNow:AppConstants.offlineNow);
                          loader(context);*/
                  },
                  child: AnimatedContainer(
                    height: 28,
                    width: 54,
                    decoration:
                    isPinToTop ?
                    BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xffD9D9D9), width: 2.5),
                      color: const Color(0xffD9D9D9),
                    ):
                    BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xff009966),width: 2.5),
                      color: const Color(0xff009966),
                    ),
                    duration: animationDuration,
                    child: AnimatedAlign(
                      alignment: isPinToTop ?
                      Alignment.centerLeft: Alignment.centerRight,
                      duration: animationDuration,
                      child: Container(
                          height: 24,
                          width: 24,
                          decoration: isPinToTop?
                          const BoxDecoration(
                            color:  AppColors.whiteColor,
                            shape: BoxShape.circle,
                          ):
                          const BoxDecoration(
                            color: AppColors.whiteColor,
                            shape: BoxShape.circle,
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
            UiHelper.verticalSpace(height: 12),
            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                mediumText14(context, 'Block',fontWeight: FontWeight.w500,
                    textColor: const Color(0xffE0002C)),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      isBlock = !isBlock;
                    });
                    /* BlocProvider.of<OnlyAsianCubit>(context).showActiveUserStatusCall1(isBlock==true?AppConstants.onlineNow:AppConstants.offlineNow);
                          loader(context);*/
                  },
                  child: AnimatedContainer(
                    height: 28,
                    width: 54,
                    decoration:
                    isBlock ?
                    BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xffD9D9D9), width: 2.5),
                      color: const Color(0xffD9D9D9),
                    ):
                    BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xff009966),width: 2.5),
                      color: const Color(0xff009966),
                    ),
                    duration: animationDuration,
                    child: AnimatedAlign(
                      alignment: isBlock ?
                      Alignment.centerLeft: Alignment.centerRight,
                      duration: animationDuration,
                      child: Container(
                          height: 24,
                          width: 24,
                          decoration: isBlock?
                          const BoxDecoration(
                            color:  AppColors.whiteColor,
                            shape: BoxShape.circle,
                          ):
                          const BoxDecoration(
                            color: AppColors.whiteColor,
                            shape: BoxShape.circle,
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
            UiHelper.verticalSpace(height: 12),
            mediumText14(context, 'Report',fontWeight: FontWeight.w500,
                textColor: const Color(0xffE0002C)),

          ],
        ),
      ),
    );
  }
}
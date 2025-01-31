import 'package:flutter/material.dart';
import 'package:tictoc/screens/auth/forgot_password.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:velocity_x/velocity_x.dart';
class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  bool isHideHistory = false;
  final animationDuration = const Duration(milliseconds: 300);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: 'Language'),
      body: Padding(
        padding: const EdgeInsets.only(top:10,left: 16,right: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 16,bottom: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xffF2F2F2),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12,right: 12),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            mediumText14(context, 'App Language',fontWeight: FontWeight.w500),
                            Row(
                              children: [
                                mediumText14(context, 'English',fontWeight: FontWeight.w500),
                                const SizedBox(width: 12,),
                                Image.asset('assets/images/right_arrow_1.png',height: 20,width: 10,),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        smallText12(context, 'Select your default app language',
                            textColor: const Color(0xff484848),
                            fontWeight: FontWeight.w400),
                        const SizedBox(height: 8,),
                      ],
                    ),
                  ),
                  const Divider(color: Color(0xffDEDEDE),thickness: 1,),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 12,right: 12),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            mediumText14(context, 'Preferred language',fontWeight: FontWeight.w500, textColor: const Color(0xff404040)),
                            Row(
                              children: [
                                mediumText14(context, 'English',fontWeight: FontWeight.w500),
                                const SizedBox(width: 12,),
                                Image.asset('assets/images/right_arrow_1.png',height: 20,width: 10,),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        smallText12(context, 'This will help us customize your viewing experience.',
                            textColor: const Color(0xff484848),
                            fontWeight: FontWeight.w400),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                ],
              ),
            ),
            const SizedBox(height: 24,),
            Container(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 16,bottom: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xffF2F2F2),
              ),
              child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mediumText14(context, 'Translations',fontWeight: FontWeight.w500,
                      textColor: const Color(0xff404040)).pOnly(left:4),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 12,right: 12),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            mediumText14(context, 'Translation language',fontWeight: FontWeight.w500, textColor: const Color(0xff404040)),
                            Row(
                              children: [
                                mediumText14(context, 'English',fontWeight: FontWeight.w500),
                                const SizedBox(width: 12,),
                                Image.asset('assets/images/right_arrow_1.png',height: 20,width: 10,),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        smallText12(context, 'language you’d like to have videos translated into.',
                            textColor: const Color(0xff484848),
                            fontWeight: FontWeight.w400),
                        const SizedBox(height: 8,),
                      ],
                    ),
                  ),
                  const Divider(color: Color(0xffDEDEDE),thickness: 1,),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 12,right: 12),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            mediumText14(context, 'Always show translation',fontWeight: FontWeight.w500,textColor: const Color(0xff404040)),
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
                                  border: Border.all(color: const Color(0xffD9D9D9), width: 0.0),
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
                                        color:Color(0xffADADAD),
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
                        const SizedBox(height: 10,),
                        smallText12(context, 'Lorem ipsum dolor sit amet consectetur. Vitae egestas mauris enim non a. Fringilla blandit malesuada nullam mattis tellus quam imperdiet.',
                            textColor: const Color(0xff404040),
                            fontWeight: FontWeight.w400),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6,),
                  const Divider(color: Color(0xffDEDEDE),thickness: 1,),
                  const SizedBox(height: 8,),
                  Padding(
                    padding: const EdgeInsets.only(left: 12,right: 12),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            mediumText14(context, 'Do not translate',fontWeight: FontWeight.w500,textColor: const Color(0xff404040)),
                            Image.asset('assets/images/right_arrow_1.png',height: 20,width: 10,),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        smallText12(context, 'Lorem ipsum dolor sit amet consectetur. Vitae egestas mauris enim nona.',
                            textColor: const Color(0xff404040),
                            fontWeight: FontWeight.w400),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

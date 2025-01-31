import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
class SoundScreen extends StatefulWidget {
  const SoundScreen({super.key});

  @override
  State<SoundScreen> createState() => _SoundScreenState();
}

class _SoundScreenState extends State<SoundScreen> {
  final List soundScreenData = [
    {"image":"assets/images/soundScreen1.png","likeCount":"203.2K"},
    {"image":"assets/images/soundScreen2.png","likeCount":"102.2K"},
    {"image":"assets/images/soundScreen3.png","likeCount":"328.2K"},
    {"image":"assets/images/soundScreen4.png","likeCount":"983.0K"},
    {"image":"assets/images/soundScreen5.png","likeCount":"324.11K"},
    {"image":"assets/images/soundScreen2.png","likeCount":"663.09K"},
    {"image":"assets/images/soundScreen1.png","likeCount":"203.2K"},
    {"image":"assets/images/soundScreen3.png","likeCount":"328.2K"},
    {"image":"assets/images/soundScreen4.png","likeCount":"983.0K"},
    {"image":"assets/images/soundScreen5.png","likeCount":"324.11K"},
    {"image":"assets/images/soundScreen1.png","likeCount":"203.2K"},
    {"image":"assets/images/soundScreen2.png","likeCount":"102.2K"},
    {"image":"assets/images/soundScreen3.png","likeCount":"328.2K"},
    {"image":"assets/images/soundScreen4.png","likeCount":"983.0K"},
    {"image":"assets/images/soundScreen5.png","likeCount":"324.11K"},
    {"image":"assets/images/soundScreen2.png","likeCount":"663.09K"},
    {"image":"assets/images/soundScreen1.png","likeCount":"203.2K"},
    {"image":"assets/images/soundScreen3.png","likeCount":"328.2K"},
    {"image":"assets/images/soundScreen4.png","likeCount":"983.0K"},
    {"image":"assets/images/soundScreen5.png","likeCount":"324.11K"},
  ];
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: whiteColor, // Green status bar
        statusBarIconBrightness: Brightness.dark, // Light icons for better contrast
      ),
      child: Scaffold(
      //  backgroundColor: whiteColor,
        backgroundColor: whiteColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 14,right: 14,top: 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UiHelper.verticalSpace(height: screenHeight*0.07),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyInkWell(
                            onTap:()async{
                              Navigator.of(context).pop();
                            },
                            child: Image.asset('assets/images/back_arrow_black.png',height: 28,width: 28,)),
                        MyInkWell(
                            onTap:()async{
                              Share.share('Check out this TicToc App');
                            },child: Image.asset('assets/images/share1.png',height: 30,width: 30,)),
                      ],
                    ),
                    UiHelper.verticalSpace(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset('assets/images/explore5.png',height: 76,width: 70,)),
                        UiHelper.horizontalSpace(width: 12),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              mediumText14(context, 'Leo lectus at phasellus dignissim nibh posuere fusce a consectetur. Cursus mauris ',
                                  maxLines: 3,overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w500,textColor: const Color(0xff0B0B0B)),
                              mediumText14(context, 'Egestas dui tempor ut cursus',textColor: const Color(0xff484848))
                            ],
                          ),
                        ),

                      ],
                    ),
                    UiHelper.verticalSpace(height: 18),
                    Row(
                      children: [
                        Image.asset('assets/images/play_grey.png',height: 14,width: 14,),
                        UiHelper.horizontalSpace(width: 6),
                        smallText12(context, '202.2K',textColor: const Color(0xffADADAD)),
                        UiHelper.horizontalSpace(width: 6),
                        Flexible(child: smallText12(context, 'Montes fames volutpat fusce in hj hh lorem ontes fames volutpat fusce in hj hh lorem',
                            maxLines: 1,overflow: TextOverflow.ellipsis, textColor: const Color(0xff484848))),
                        UiHelper.horizontalSpace(width: 6),
                        smallText12(context, '75 posts',
                            maxLines: 1,overflow: TextOverflow.ellipsis, textColor: const Color(0xff484848))
                      ],
                    ),
                    UiHelper.verticalSpace(height: 22),
                    pinkButton(context: context,
                        labelText: 'Add to favorites',
                        fontWeight:FontWeight.w700,fontSize: 14,
                        imageWidget:Image.asset('assets/images/bookmark2.png',height: 20,width: 20.58,),
                        fontFamily:"Jost",
                        labelImageGap:9,
                        borderRadiusValue: 6),
                    UiHelper.verticalSpace(height: 18),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: soundScreenData.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                        mainAxisExtent: 165
                    ),
                    itemBuilder: (BuildContext context, int index){
                      return Stack(
                        children: [
                          Image.asset(soundScreenData[index]['image']),
                          Positioned(child: index==0?
                          Container(
                            padding:  const EdgeInsets.only(left:8,right:8,top:4,bottom: 4),
                            decoration:  BoxDecoration(
                              color:buttonColor,
                              borderRadius: BorderRadius.circular(2.5),),
                            child: smallText12(context, 'Original',textColor: Colors.white,fontSize: 11,fontWeight: FontWeight.w700),):const SizedBox()),
                      Positioned(
                        bottom:0,
                        child:Container(
                        padding:  const EdgeInsets.only(left:8,right:8,top:4,bottom: 4),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.0),
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.2),
                            ],),),
                        child: Row(
                          children: [
                            Image.asset('assets/images/like_notselected.png',color:Colors.white,height: 16.38,width: 16.38,),
                            const SizedBox(width: 6,),
                            smallText12(context, soundScreenData[index]['likeCount'],textColor: Colors.white,fontSize: 11,fontWeight: FontWeight.w700),
                          ],
                        ),),),
                        ],
                      );
                    },
                  ),
                ),
              ),
         //     UiHelper.verticalSpace(height: screenHeight*0.04),

            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20), // Raise the buttons slightly
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pinkButton(context: context,
                  buttonColor: whiteColor,
                  labelText: 'Add to Story',
                  imageWidget: Image.asset('assets/images/music.png', height: 22, width: 22),
                  textColor:appBlackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  borderRadiusValue:36,
                  height:39,width: 157),
              const SizedBox(width: 12,),
              pinkButton(context: context,
                  labelText: 'Use Sound',
                  imageWidget: Image.asset('assets/images/camera.png', height: 20, width: 20),
                  textColor:whiteColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  borderRadiusValue:36,
                  height:39,width: 157),

            ],
          ),
        ),
      ),
    );
  }
}

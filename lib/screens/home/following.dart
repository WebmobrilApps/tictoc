import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tictoc/screens/auth/bottom_Password_reset_success.dart';
import 'package:tictoc/screens/home/sound_screen.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class Following extends StatefulWidget {
  const Following({super.key});

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  final List storiesData = [
    {"storyImage":"assets/images/profile2.png", "name":"Thiru", "isLive":true},
    {"storyImage":"assets/images/profile3.png", "name":"Ram", "isLive":true},
    {"storyImage":"assets/images/profile4.png", "name":"Mohan", "isLive":false},
    {"storyImage":"assets/images/profile5.png", "name":"Lokesh", "isLive":false},
    {"storyImage":"assets/images/profile2.png", "name":"Thiru", "isLive":true},
    {"storyImage":"assets/images/profile3.png", "name":"Ram", "isLive":true},
    {"storyImage":"assets/images/profile4.png", "name":"Mohan", "isLive":false},
    {"storyImage":"assets/images/profile5.png", "name":"Lokesh", "isLive":false},
    {"storyImage":"assets/images/profile2.png", "name":"Thiru", "isLive":true},
    {"storyImage":"assets/images/profile3.png", "name":"Ram", "isLive":true},
    {"storyImage":"assets/images/profile4.png", "name":"Mohan", "isLive":false},
    {"storyImage":"assets/images/profile5.png", "name":"Lokesh", "isLive":false},
  ];

  final List reelsData = [
    {"reelsImage":"assets/images/reels1.png","active":"10h ago", "name":"DisaSmith", "msgCount":"56","likeCount":"1.2K",},
    {"reelsImage":"assets/images/reels2.png","active":"2h ago", "name":"Thiru", "msgCount":"56","likeCount":"1.2K",},
    {"reelsImage":"assets/images/reels3.png","active":"5min ago", "name":"Ram", "msgCount":"56","likeCount":"1.2K",},
    {"reelsImage":"assets/images/reels4.png","active":"18h ago", "name":"Tamil", "msgCount":"56","likeCount":"1.2K",},
    {"reelsImage":"assets/images/reels5.png","active":"10min ago", "name":"Durai", "msgCount":"56","likeCount":"1.2K",},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          UiHelper.verticalSpace(height: screenHeight * 0.011),
      //    UiHelper.verticalSpace(height: screenHeight * 0.14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 8,),
              Column(
                children: [
                  Stack(alignment: Alignment.centerRight,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Image.asset('assets/images/profile1.png',height: 61.58,width: 61.58,)),
                      Positioned(
                        bottom: 0,
                        child:Image.asset('assets/images/create.png',height: 24,width: 24,),),
                    ],
                  ),
                  const SizedBox(height: 4),
                  smallText12(context, 'Create',fontSize:11.16,textColor: whiteColor,fontWeight: FontWeight.w500)
                ],
              ),
              UiHelper.horizontalSpace(width: 12),
              Expanded(
                child: ConstrainedBox(
                  constraints:  BoxConstraints(maxHeight: screenHeight*0.12), // Dynamically constrain height
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: storiesData.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  child: Image.asset(storiesData[index]['storyImage'], height: 61.58, width: 61.58,),
                                ),
                                Positioned(
                                    child: storiesData[index]['isLive']==true?
                                    Container(
                                        padding:  const EdgeInsets.only(left:6,right:6,top:4,bottom: 4),
                                        decoration:  BoxDecoration(
                                          color:buttonColor,
                                          borderRadius: BorderRadius.circular(2.5),),
                                        child: smallText12(context, 'Live',textColor: whiteColor,fontSize: 8,fontWeight: FontWeight.w700)):const SizedBox()),
                              ],
                            ),
                            const SizedBox(height: 4),
                            smallText12(context,  storiesData[index]['name'],fontSize:11.16,textColor: whiteColor,fontWeight: FontWeight.w500)
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              UiHelper.horizontalSpace(width: 10),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: reelsData.length,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return    Stack(
                    //  alignment: Alignment.center,
                    children: [
                      Image.asset(reelsData[index]['reelsImage'],
                        fit: BoxFit.cover,
                        width: double.infinity,height:screenHeight*0.69),
                      Positioned(
              
                        //top: 160, left: 150,
                          top: screenHeight * 0.23,
                          left: screenWidth * 0.35,
                          child: Image.asset('assets/images/play.png', width: 81.6,height:81.6,)),
                      Positioned(
                        //  top: 160, right:16,
                        //  top: index==0?screenHeight * 0.23:screenHeight * 0.28,
                        //bottom: index==0?45:30,
                          right: 0,
                          bottom:0,
                          child: Container(
                            padding:  EdgeInsets.only(bottom: index==reelsData.length-1?65:45,right: 16),
                         /*   decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.0),
                                  Colors.black.withOpacity(0.1),
                                  Colors.black.withOpacity(0.1),
                                  Colors.black.withOpacity(0.2),
                                ],),),*/
                            child: Column(
                              children: [
                                Stack( alignment: Alignment.bottomCenter,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(bottom: 11),
                                        child: Image.asset('assets/images/profile6.png', width: 49,height:49,)),
                                    Positioned(bottom: 0,
                                        right: 13,
                                        child: Image.asset('assets/images/plus.png', width: 20.47,height:21.74,)),
                                  ],
                                ),
                                UiHelper.verticalSpace(height: 14),
                                Image.asset('assets/images/like_heart.png',height: 33.6,width: 33.6,),
                                mediumText14(context, '1.2K',textColor: whiteColor,fontWeight: FontWeight.w600),
                                UiHelper.verticalSpace(height: 14),
                                Image.asset('assets/images/chat.png',height: 33.6,width: 33.6,),
                                mediumText14(context, '45',textColor: whiteColor,fontWeight: FontWeight.w600),
                                UiHelper.verticalSpace(height: 14),
              
                                MyInkWell(
                                    onTap: ()async{
                                      print('bookmark');
                                      Share.share('Check out this awesome Flutter package!');
                                    },child: Image.asset('assets/images/bookmark.png',height: 25.2,width:26,)),
                                UiHelper.verticalSpace(height: 14),
                                MyInkWell(
                                    onTap: ()async{
                                      print('bookmark');
                                      Share.share('Check out this awesome Flutter package!');
                                    },child: Image.asset('assets/images/share.png',height: 33.6,width:33.6,),),
                                UiHelper.verticalSpace(height: 14),
                                IconButton(
                                    padding: const EdgeInsets.all(0.0),
                                    onPressed: () {
                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: const SoundScreen(),
                                        withNavBar: false, // OPTIONAL VALUE. True by default.
                                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                      );
                                    },
                                    icon: Image.asset('assets/images/profile7.png',height: 46.0,width:46.0,)),
                              ],
                            ),
                          )),
                      Positioned(
                        bottom: index==reelsData.length-1?25:8,
                        left: 0,
                        right: 66, // Add right padding to avoid mingling with other widgets
                        child: Container(
                          padding:  EdgeInsets.only(left: 20,bottom: 15),
                       /*   decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.2),
                                Colors.black.withOpacity(0.5),
                              ],),),*/
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                              //  crossAxisAlignment: CrossAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/profile6.png', width: 35, height: 35).pOnly(bottom: 8),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: largeText16(
                                      context,reelsData[index]['name'],
                                      textColor: whiteColor,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis, // Ensure truncation
                                      maxLines: 1, // Limit to one line
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Image.asset('assets/images/tick.png', width: 15, height: 15),
                                  const SizedBox(width: 6),
                                  smallText12(context,reelsData[index]['active'], textColor: const Color(0xffADADAD)),
                                ],
                              ),
                              SizedBox(
                                width: screenWidth * 0.71, // Restrict width
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Montes fames volutpat fusce nisl in id lacus viverra mauris.  ',
                                          style: GoogleFonts.jost(fontSize: 12,fontWeight: FontWeight.w400)
                                      ),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: buttonColor,
                                            borderRadius: BorderRadius.circular(2.5),
                                          ),
                                          child: smallText12(
                                            context,
                                            'Follow',
                                            textColor: whiteColor,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              UiHelper.verticalSpace(height: 8),
                              Row(
                                children: [
                                  smallText12(context, '#Tamil #Thiru #Ram',textColor: whiteColor,fontWeight: FontWeight.w600),
                                  UiHelper.horizontalSpace(width: 8),
                                  mediumText14(context, 'See Translation',textColor: whiteColor,fontWeight: FontWeight.w600),
                                ],
                              ),
                              const SizedBox(height: 30,),
                            ],
                          ),),
                      ),
                  /*    Positioned(
                        bottom: 70,
                        left: 20,
                        right: 20, // Add right padding to avoid mingling with other widgets
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset('assets/images/profile6.png', width: 35, height: 35),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: largeText16(
                                    context,reelsData[index]['name'],
                                    textColor: whiteColor,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis, // Ensure truncation
                                    maxLines: 1, // Limit to one line
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Image.asset('assets/images/tick.png', width: 15, height: 15),
                                const SizedBox(width: 6),
                                smallText12(context,reelsData[index]['active'], textColor: const Color(0xffADADAD)),
                              ],
                            ),
                            UiHelper.verticalSpace(height: 6),
                            SizedBox(
                              width: screenWidth * 0.71, // Restrict width
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Montes fames volutpat fusce nisl in id lacus viverra mauris. ',
                                        style: GoogleFonts.jost(fontSize: 12,fontWeight: FontWeight.w400)
                                    ),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: buttonColor,
                                          borderRadius: BorderRadius.circular(2.5),
                                        ),
                                        child: smallText12(
                                          context,
                                          'Follow',
                                          textColor: whiteColor,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            UiHelper.verticalSpace(height: 8),
                            Row(
                              children: [
                                smallText12(context, '#Tamil #Thiru #Ram',textColor: whiteColor,fontWeight: FontWeight.w600),
                                UiHelper.horizontalSpace(width: 8),
                                mediumText14(context, 'See Translation',textColor: whiteColor,fontWeight: FontWeight.w600),
                              ],
                            ),
                          ],
                        ),
                      ),*/
              
                    ],
                  );
                },
              ),
            ),
          ),


        ],
      ),
    );
  }
}

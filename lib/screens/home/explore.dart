import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/screens/home/explore_detail.dart';
import 'package:tictoc/screens/home/sound_screen.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  final List exploreData = [
    {"exploreImage":"assets/images/explore1.png","tag":"#dance #Sing #Play #Ram #groupdance #dance #Sing #Play #Ram #groupdance", "name":"DisaSmith", "msgCount":"56","likeCount":"1.2K",},
    {"exploreImage":"assets/images/explore2.png","tag":"#dance #Sing #Play #Ram", "name":"Thiru", "msgCount":"56","likeCount":"1.2K",},
    {"exploreImage":"assets/images/explore3.png","tag":"#dance #Sing #Play #Ram #groupdance #dance #Sing #Play #Ram #groupdance",  "name":"Ram", "msgCount":"56","likeCount":"1.2K",},
    {"exploreImage":"assets/images/explore4.png","tag":"#dance #Sing #Play #Ram #groupdance #dance #Sing #Play #Ram #groupdance",  "name":"Tamil", "msgCount":"56","likeCount":"1.2K",},
    {"exploreImage":"assets/images/reels5.png","tag":"#dance #Sing #Play #Ram #groupdance #dance #Sing #Play #Ram #groupdance",  "name":"Durai", "msgCount":"56","likeCount":"1.2K",},
    {"exploreImage":"assets/images/reels1.png","tag":"#dance #Sing #Play #Ram",  "name":"Durai", "msgCount":"56","likeCount":"1.2K",},
    {"exploreImage":"assets/images/reels2.png","tag":"#dance #Sing #Play #Ram #groupdance #dance #Sing #Play #Ram #groupdance",  "name":"Durai", "msgCount":"56","likeCount":"1.2K",},
    {"exploreImage":"assets/images/reels3.png","tag":"#dance #Sing #Play #Ram",  "name":"Durai", "msgCount":"56","likeCount":"1.2K",},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body:   SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 14,right: 10,bottom: 80),
          child: MasonryGridView.builder(
            itemCount: exploreData.length,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate:const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 14,bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyInkWell(
                      onTap: ()async{
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const ExploreDetail(),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(7.0),
                          child: Image.asset(exploreData[index]['exploreImage'])),
                    ),
                    const SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       Flexible(
                         child: MyInkWell(
                           onTap: ()async{
                             PersistentNavBarNavigator.pushNewScreen(
                               context,
                               screen: const ExploreDetail(),
                               withNavBar: false, // OPTIONAL VALUE. True by default.
                               pageTransitionAnimation: PageTransitionAnimation.cupertino,
                             );
                           },
                           child: Row(
                              children: [
                                Image.asset('assets/images/profile6.png',height: 24,width: 24,),
                                const SizedBox(width: 4,),
                                Flexible(child: smallText12(context,exploreData[index]['name'],maxLines:1,  overflow: TextOverflow.ellipsis,textColor: whiteColor )),
                              ],
                            ),
                         ),
                       ),
                        Row(
                          children: [
                            Image.asset('assets/images/like_notselected.png',height: 16,width: 16,),
                            const SizedBox(width: 4,),
                            smallText12(context,exploreData[index]['likeCount'],textColor: whiteColor ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4,),
                    smallText12(context, 'dancevideo.tictocapp',fontWeight:FontWeight.w500,textColor: const Color(0xff484848)),
                    smallText12(context, exploreData[index]['tag'],
                        fontWeight:FontWeight.w500,maxLines:2, overflow: TextOverflow.ellipsis,textColor: const Color(0xffADADAD))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

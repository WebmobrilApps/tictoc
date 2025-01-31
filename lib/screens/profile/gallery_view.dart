import 'package:flutter/material.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_widgets.dart';
class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:4,left: 18,right: 18),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              itemCount: soundScreenData.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 4.0,
                  mainAxisExtent: 185
              ),
              itemBuilder: (BuildContext context, int index){
                return Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(3.33),
                        child: Image.asset(soundScreenData[index]['image'])),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        Image.asset('assets/images/play_grey.png',height: 10,width: 10,),
                        const SizedBox(width: 6,),
                        smallText12(context, soundScreenData[index]['likeCount'],textColor: appGreyColor,
                            fontSize: 8,fontWeight: FontWeight.w600),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 75,),
        ],
      ),
    );
  }
}

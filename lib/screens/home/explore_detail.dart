import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
class ExploreDetail extends StatefulWidget {
  const ExploreDetail({super.key});

  @override
  State<ExploreDetail> createState() => _ExploreDetailState();
}

class _ExploreDetailState extends State<ExploreDetail> {
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 22,right: 22),
              child: Column(
                children: [
                  UiHelper.verticalSpace(height: screenHeight*0.08),
                  Row(
                    children: <Widget>[
                      MyInkWell(
                          onTap:()async{
                            Navigator.of(context).pop();
                          },
                          child: Image.asset('assets/images/back_arrow_black.png',height: 28,width: 28,)),
                      UiHelper.horizontalSpace(width: 12),
                      Image.asset('assets/images/profile6.png',height: 46,width: 46,),
                      Expanded( // add this
                        child: Padding(
                          padding: const EdgeInsets.all(8.0), // give some padding
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min, // set it to min
                            children: <Widget>[
                              largeText16(context, 'Thiru' ,
                                  maxLines: 1,overflow: TextOverflow.ellipsis,
                                  textColor:appBlackColor,fontWeight: FontWeight.w500),
                              Row(
                                children: [
                                  Image.asset('assets/images/like_notselected.png',color:appBlackColor,height: 18,width: 18,),
                                  UiHelper.horizontalSpace(width: 4),
                                  smallText12(context, '202.2K',fontSize:10,textColor:appBlackColor,fontWeight: FontWeight.w500),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const SmallPinkButton(label: 'Follow',fontSize:12),
                          UiHelper.horizontalSpace(width: 7),
                          Image.asset('assets/images/search_black.png',height: 26,width: 26,),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            UiHelper.verticalSpace(height: 6),
            Image.asset('assets/images/reels4.png',height: screenHeight*0.628,width: double.infinity,fit: BoxFit.cover,),
            UiHelper.verticalSpace(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 26,right: 26,bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mediumText14(context, 'DanceVideo.TicTocApp',fontWeight: FontWeight.w500),
                  mediumText14(context, '#tictocapp #dancevideo #dance #tictocapp #dancevideo #dance #groupdance #tictocapp #dancevideo #dance #groupdance#groupdance  #dancevideo #dance #groupdance #tictocapp #dancevideo #dance #groupdance#groupdance',
                      maxLines: 3,overflow: TextOverflow.ellipsis,
                      fontSize:13,textColor:appGreyColor,fontWeight: FontWeight.w500),
                  UiHelper.verticalSpace(height: 14),
                  Row(
                    children: [
                      Flexible(
                        child: customMultipleTextField(hintText: 'Add Comment...',
                            controller: commentController,
                            inputBgColor:const Color(0xffD9D9D9),
                            hintFontColor: const Color(0xff424242),
                            hintFontSize: 10,
                        ),
                      ),
                      UiHelper.horizontalSpace(width: 8),
                      Column(
                        children: [
                          Image.asset('assets/images/like_heart.png',height: 23.69,width: 23.69,),
                          const SizedBox(height: 4,),
                          Text('1.2K',style: GoogleFonts.robotoSlab(fontSize:8.46,color:const Color(0xff505050),fontWeight: FontWeight.w500),)
                        ],
                      ),
                      UiHelper.horizontalSpace(width: 8),
                      Column(
                        children: [
                          Image.asset('assets/images/message.png',height: 23.69,width: 23.69,),
                          const SizedBox(height: 4,),
                          Text('45',style: GoogleFonts.robotoSlab(fontSize:8.46,color:const Color(0xff505050),fontWeight: FontWeight.w500),)
                        ],
                      ),
                      UiHelper.horizontalSpace(width: 8),
                      Column(
                        children: [
                          Image.asset('assets/images/bookmark_black.png',height: 23.69,width: 23.69,),
                          const SizedBox(height: 4,),
                          Text('96',style: GoogleFonts.robotoSlab(fontSize:8.46,color:const Color(0xff505050),fontWeight: FontWeight.w500),)
                        ],
                      ),
                      UiHelper.horizontalSpace(width: 8),
                      Column(
                        children: [
                          Image.asset('assets/images/share_black.png',height: 23.69,width: 23.69,),
                          const SizedBox(height: 4,),
                          Text('457',style: GoogleFonts.robotoSlab(fontSize:8.46,color:const Color(0xff505050),fontWeight: FontWeight.w500),)
                        ],
                      )

                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

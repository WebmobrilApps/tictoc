import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/screens/home/following/widgets/comment_following.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:tictoc/model/explore_response.dart' as dfrContent;

class ExploreDetail extends StatefulWidget {
  final dfrContent.Data reelsData; // <-- Receive the Data object
  const ExploreDetail({super.key, required this.reelsData});

  @override
  State<ExploreDetail> createState() => _ExploreDetailState();
}

class _ExploreDetailState extends State<ExploreDetail> {
  TextEditingController commentController = TextEditingController();
  late dfrContent.Data reelsData;
  @override
  void initState() {
    super.initState();
    reelsData = widget.reelsData;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: BlocConsumer<TicTocCubit,TicTocState>(
        listener: (context,state){
          print("state.status:${state.status}");
          if (state.status == TicTocStatus.sendCommentSuccess){
            commentController.clear();
          }
        },
        builder: (context,state){
          return SingleChildScrollView(
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
                          cachedImageWidget(
                              image:"$BASEURL/${reelsData.profilePic??''}",
                              borderRadiusValue:50,
                              hasProfileImg:true,
                              height: 46,width: 46),
                          Expanded( // add this
                            child: Padding(
                              padding: const EdgeInsets.all(8.0), // give some padding
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min, // set it to min
                                children: <Widget>[
                                  largeText16(context, reelsData.name??'' ,
                                      maxLines: 1,overflow: TextOverflow.ellipsis,
                                      textColor:appBlackColor,fontWeight: FontWeight.w500),
                                  Row(
                                    children: [
                                      Image.asset(reelsData.isLiked==0?'assets/images/like_notselected_black.png':'assets/images/like_heart.png',height: 18,width: 18,),
                                      UiHelper.horizontalSpace(width: 4),
                                      smallText12(context, reelsData.likeCount.toString(),fontSize:10,textColor:appBlackColor,fontWeight: FontWeight.w500),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              SmallPinkButton(label: 'Follow',fontSize:12,
                                onTap: ()async{
                                  UiHelper.toastMessage('Not implemented api pending');
                                },
                              ),
                              UiHelper.horizontalSpace(width: 7),
                              //  Image.asset('assets/images/search_black.png',height: 26,width: 26,),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                UiHelper.verticalSpace(height: 6),
                cachedImageWidget(
                  image: reelsData.url??'',borderRadiusValue: 0,
                  height: screenHeight*0.628,width: double.infinity,fit: BoxFit.cover,),
                //  Image.asset('assets/images/reels4.png',height: screenHeight*0.628,width: double.infinity,fit: BoxFit.cover,),
                UiHelper.verticalSpace(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 26,right: 26,bottom: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      mediumText14(context, reelsData.descr??'',fontWeight: FontWeight.w500),
                      mediumText14(context,   reelsData.tags!.map((tag) => tag.startsWith('#') ? tag : '#$tag').join(' '),
                          textColor: appGreyColor, maxLines: 3,overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w500),
                      /*   mediumText14(context, '#tictocapp #dancevideo #dance #tictocapp #dancevideo #dance #groupdance #tictocapp #dancevideo #dance #groupdance#groupdance  #dancevideo #dance #groupdance #tictocapp #dancevideo #dance #groupdance#groupdance',
                      maxLines: 3,overflow: TextOverflow.ellipsis,
                      fontSize:13,textColor:appGreyColor,fontWeight: FontWeight.w500),*/
                      UiHelper.verticalSpace(height: 14),
                      Row(
                        children: [
                          Flexible(
                            child: customMultipleTextField1(
                              height: 40,
                              hintText: 'Add Comment...',
                              hintFontWeight: FontWeight.w500,
                              controller: commentController,
                              inputBgColor:const Color(0xffD9D9D9),
                              hintFontColor: const Color(0xff424242),
                              hintFontSize: 10,
                              contentPadding:
                              const EdgeInsets.only(left: 18, right: 18, top: 12, bottom: 12),
                              suffixIcons: [
                                MyInkWell(
                                    onTap: ()async{
                                      if(commentController.text.isEmpty){
                                        UiHelper.toastMessage('Please enter comment');
                                      }else{
                                        Map<String, dynamic> commentDetails = {
                                          "pk_videos": reelsData.videoId,
                                          "comment": commentController.text,
                                        };
                                        print('commentDetails:$commentDetails');
                                        BlocProvider.of<TicTocCubit>(context).sendCommentCall(commentDetails);
                                      }
                                    },
                                    child: state.status==TicTocStatus.sendCommentLoading?const SizedBox(height:25,width:25,child: CircularProgressIndicator(color: buttonColor,strokeWidth: 3.0,)):
                                    Image.asset('assets/images/share_grey.png', height: 22, width: 22)),
                              ],
                            ),
                          ),
                          UiHelper.horizontalSpace(width: 8),
                          MyInkWell(
                            onTap: ()async{
                              Map<String, dynamic> hitLikeDetails = {
                                "pk_videos": reelsData.videoId,
                              };
                              print('hitLikeDetails:$hitLikeDetails');
                              BlocProvider.of<TicTocCubit>(context).hitLikeProfileCall(hitLikeDetails).whenComplete((){
                                setState(() {
                                  if (reelsData.isLiked == 0) {
                                    reelsData.isLiked = 1;
                                    reelsData.likeCount = (reelsData.likeCount ?? 0) + 1;
                                  } else {
                                    reelsData.isLiked = 0;
                                    reelsData.likeCount = (reelsData.likeCount ?? 1) - 1;
                                  }
                                });
                              });
                            },
                            child: Column(
                              children: [
                                Image.asset(reelsData.isLiked==0?'assets/images/like_notselected_black.png':'assets/images/like_heart.png',height: 23.69,width: 23.69,),
                                const SizedBox(height: 4,),
                                Text(reelsData.likeCount.toString(), style: GoogleFonts.robotoSlab(fontSize:8.46,color:const Color(0xff505050),fontWeight: FontWeight.w500),)
                              ],
                            ),
                          ),
                          UiHelper.horizontalSpace(width: 8),
                          MyInkWell(
                            onTap: () async{
                              final result = await showModalBottomSheet<int>(
                                context: context,
                                backgroundColor: Colors.transparent,
                                useRootNavigator: true,
                                isScrollControlled: true,
                                isDismissible: false, // ❌ disable tap-outside
                                enableDrag: false,    // ❌ disable swipe down to dismiss
                                builder: (context) {
                                  return CommentBottomSheetWrapper(
                                    videoId: widget.reelsData.videoId.toString() ?? '',
                                  );
                                },
                              );


                              //waiting for api to give the comment count
                              // 👇 if user added a comment, update count
                              if (result != null) {
                                setState(() {
                                  //   reelsData.commentCount = result;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                Image.asset('assets/images/message.png',height: 23.69,width: 23.69,),
                                const SizedBox(height: 16,),
                             //   const SizedBox(height: 4,),
                              //  Text('45',style: GoogleFonts.robotoSlab(fontSize:8.46,color:const Color(0xff505050),fontWeight: FontWeight.w500),)
                              ],
                            ),
                          ),
                          UiHelper.horizontalSpace(width: 8),
                          MyInkWell(
                            onTap: ()async{
                              Map<String, dynamic> bookmarkDetails = {
                                "content_id": reelsData.videoId,
                              };
                              print('bookmarkDetails:$bookmarkDetails');
                              BlocProvider.of<TicTocCubit>(context).bookmarkExploreCall(bookmarkDetails).whenComplete((){
                                setState(() {
                                  if (reelsData.isSaved == 0) {
                                    reelsData.isSaved = 1;
                                 //   reelsData.saveCount = (reelsData.saveCount ?? 0) + 1;
                                  } else {
                                    reelsData.isSaved = 0;
                                 //   reelsData.saveCount = (reelsData.saveCount ?? 1) - 1;
                                  }
                                });
                              });
                            },
                            child: Column(
                              children: [

                               // Image.asset(reelsData.isSaved==0?'assets/images/bookmark_black.png':'assets/images/bookmark_filled.png',height: 23.69,width: 23.69,),
                                state.status==TicTocStatus.bookmarkExploreLoading?
                                const SizedBox(width: 16, height: 16,
                                  child: Center(child: CircularProgressIndicator(color:buttonColor,strokeWidth:2.0)),):reelsData.isSaved==0?Image.asset('assets/images/bookmark_black.png',height: 23.69,width: 23.69,):
                                Image.asset('assets/images/bookmark_filled.png',height: 23.69,width: 23.69,color: buttonColor,),
                                const SizedBox(height: 16,),
                             //   const SizedBox(height: 4,),
                              //  Text('96',style: GoogleFonts.robotoSlab(fontSize:8.46,color:const Color(0xff505050),fontWeight: FontWeight.w500),)
                              ],
                            ),
                          ),
                          UiHelper.horizontalSpace(width: 8),
                          MyInkWell(
                            onTap: ()async{UiHelper.toastMessage('Pending');},
                            child: Column(
                              children: [
                                Image.asset('assets/images/share_black.png',height: 23.69,width: 23.69,),
                                const SizedBox(height: 4,),
                                Text('457',style: GoogleFonts.robotoSlab(fontSize:8.46,color:const Color(0xff505050),fontWeight: FontWeight.w500),)
                              ],
                            ),
                          )

                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

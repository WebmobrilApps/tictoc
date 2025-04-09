import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/following_feed_response.dart';
import 'package:tictoc/screens/home/following/widgets/bottom_icons_following.dart';
import 'package:tictoc/screens/home/following/widgets/side_icons_following.dart';
import 'package:tictoc/utils/empty_list_found.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_loader.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/error_display.dart';
import 'package:tictoc/utils/ui_helper.dart';
class FollowingFeed extends StatefulWidget {
  const FollowingFeed({super.key});

  @override
  State<FollowingFeed> createState() => _FollowingFeedState();
}

class _FollowingFeedState extends State<FollowingFeed> {
  bool showLoader = true;
  FollowingFeedResponse followingFeedResponse = FollowingFeedResponse();
  final TextEditingController commentController = TextEditingController();

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
  @override
  void initState() {
    super.initState();
    _getFollowingFeed(); // Initial API call
  }
  Future<void> _getFollowingFeed() async {
    await BlocProvider.of<TicTocCubit>(context).followingFeedCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: BlocConsumer<TicTocCubit,TicTocState>(
        listener: (context,state){
          print("sate.status:${state.status}");
          if(state.status == TicTocStatus.followingFeedSuccess){
            showLoader = false;
            followingFeedResponse = state.responseData?.response as FollowingFeedResponse;
          }
        },
        builder: (context,state){
          if (showLoader) {
            return const CustomLoader();
          }
          if (state.status == TicTocStatus.followingFeedError) {
            return CustomErrorWidget(
              errorMessage: state.errorData?.message ?? state.error,
              statusCode: state.errorData?.code,
              onRetry: _getFollowingFeed,
              onRefresh: _refreshPage,
            );
          }
          return   RefreshIndicator(
            onRefresh: _refreshPage,
            color: Colors.grey, // You can customize this
            child: Column(
              children: [
                UiHelper.verticalSpace(height: screenHeight * 0.011),
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
                followingFeedResponse.data!.isEmpty?
                const EmptyListFollowing(
                  message: 'You are not following any one. So there is no feed',
                  topPadding: 200,
                  textColor: Colors.white,
                ):
                Expanded(
                  child:
                  PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount:  followingFeedResponse.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      final followingData = followingFeedResponse.data![index];
                      return Stack(
                        children: [
                          cachedImageFullHeight(
                            image:followingData.url??'',
                            borderRadiusValue:0,
                            height: double.infinity,
                          //  fit: BoxFit.cover
                          ),
                        /*  Positioned(
                            top: screenHeight * 0.20,
                            left: screenWidth * 0.35,
                            child: Image.asset(
                              'assets/images/play.png',
                              width: 81.6,
                              height: 81.6,
                            ),
                          ),*/
                          SideIconsFollowing(fromPage: 'FollowingTab',reelsData: followingData,),
                          BottomIconsFollowing(fromPage: 'FollowingTab', reelsData: followingData,),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _refreshPage() async{
    setState(() {
      showLoader = true; // Show the loader
    });
    await _getFollowingFeed();
  }
}
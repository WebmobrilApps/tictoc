import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/explore_response.dart';
import 'package:tictoc/screens/home/explore_detail.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_loader.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/error_display.dart';
import 'package:tictoc/utils/ui_helper.dart';
class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  bool showLoader = true;
  ExploreResponse exploreResponse = ExploreResponse();
  @override
  void initState() {
    super.initState();
    _getExplore(); // Initial API call
  }
  Future<void> _getExplore() async {
    await BlocProvider.of<TicTocCubit>(context).exploreCall("1", "50");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: BlocConsumer<TicTocCubit,TicTocState>(
        listener: (context,state){
          print("sate.status:${state.status}");
          if(state.status == TicTocStatus.exploreSuccess){
            showLoader = false;
            exploreResponse = state.responseData?.response as ExploreResponse;
          }

        },
        builder: (context,state){
          //  if (state.status == TicTocStatus.suggestedAccountLoading) {
          if (showLoader) {
            return const CustomLoader();
          }
          if (state.status == TicTocStatus.exploreError) {
            return CustomErrorWidget(
              errorMessage: state.errorData?.message ?? state.error,
              statusCode: state.errorData?.code,
              onRetry: _getExplore,
              onRefresh: _refreshPage,
            );
          }
          return   RefreshIndicator(
            onRefresh: _refreshPage,
            color: Colors.grey, // You can customize this
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(), // Important for pull-to-refresh
              child: Padding(
                padding: const EdgeInsets.only(left: 14,right: 10,bottom: 80),
                child: MasonryGridView.builder(
                  itemCount: exploreResponse.data?.length,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate:const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final exploreData = exploreResponse.data![index];
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
                            child: cachedImageFullHeight(
                                image:exploreData.url??'',
                                borderRadiusValue:7,),
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
                                      Flexible(child: smallText12(context,exploreData.name??'',maxLines:1,  overflow: TextOverflow.ellipsis,textColor: whiteColor )),
                                    ],
                                  ),
                                ),
                              ),
                              MyInkWell(
                                onTap: ()async{
                                  final isCurrentlyLiked = exploreData.isLiked == 1;
                                  Map<String, dynamic> hitLikeDetails = {
                                    "pk_videos": exploreData.videoId,
                                  };
                                  BlocProvider.of<TicTocCubit>(context).hitLikeFollowingReelsCall(hitLikeDetails).whenComplete((){
                                    TicTocState state = BlocProvider.of<TicTocCubit>(context).state;
                                    if(state.status == TicTocStatus.hitLikeFollowingReelsSuccess){
                                      setState(() {
                                        exploreData.isLiked = isCurrentlyLiked ? 0 : 1;
                                        if (isCurrentlyLiked) {
                                          exploreData.likeCount = (exploreData.likeCount ?? 1) - 1;
                                        } else {
                                          exploreData.likeCount = (exploreData.likeCount ?? 0) + 1;
                                        }
                                      });
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    Image.asset(exploreData.isLiked==0?'assets/images/like_notselected.png':'assets/images/like_heart.png',height: 16,width: 16),
                                    const SizedBox(width: 4,),
                                    smallText12(context,exploreData.likeCount.toString(),textColor: whiteColor ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                         const SizedBox(height: 4,),
                       //   smallText12(context, 'dancevideo.tictocapp',fontWeight:FontWeight.w500,textColor: const Color(0xff484848)),
                          Wrap(
                            spacing: 4.0, // space between tags
                            runSpacing: 2.0, // space between lines if wrapped
                            children: exploreData.tags!.map((tag) {
                              final formattedTag = tag.startsWith('#') ? tag : '#$tag';
                              return smallText12(context,formattedTag,
                                  fontWeight:FontWeight.w500,maxLines:2, overflow: TextOverflow.ellipsis,textColor: const Color(0xffADADAD));
                            }).toList(),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
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
    await _getExplore();
  }
}

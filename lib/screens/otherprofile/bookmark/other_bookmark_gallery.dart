import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/model/get_other_profile_response.dart' as dfrOtherProfile;
import 'package:tictoc/model/get_other_user_content_response.dart';
import 'package:tictoc/screens/otherprofile/other_detailed_feed.dart';
import 'package:tictoc/screens/profile/profile.dart';
import 'package:tictoc/utils/empty_list_found.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_loader.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/error_display.dart';
import 'package:tictoc/utils/ui_helper.dart';

class OtherBookmarkGallery extends StatefulWidget {
  final String? otherUserID;
  final dfrOtherProfile.GetOtherProfileResponse getOtherProfileResponse;
  const OtherBookmarkGallery({super.key, this.otherUserID, required this.getOtherProfileResponse});

  @override
  State<OtherBookmarkGallery> createState() => _OtherBookmarkGalleryState();
}

class _OtherBookmarkGalleryState extends State<OtherBookmarkGallery> {
  GetOtherUserContentResponse getOtherUserContentResponse = GetOtherUserContentResponse();
  bool showLoader = true;

  bool isLoadingMore = false;
  bool hasMore = true;
  int currentPage = 1;
  final int limit = 9;
  final ScrollController _scrollController = ScrollController();



  @override
  void initState() {
    getOtherSavedContentApi();
    _scrollController.addListener(_onScroll);
    super.initState();
  }
  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 && !isLoadingMore && hasMore) {
      _loadMore();
    }
  }
  Future<void> getOtherSavedContentApi({bool isLoadMore = false}) async {
    if (isLoadMore) {
      setState(() => isLoadingMore = true);
      currentPage++;
    } else {
      currentPage = 1;
      setState(() {
        showLoader = true;
        hasMore = true;
      });
    }

    await BlocProvider.of<TicTocCubit>(context).getOtherBookmarkContentCall(widget.otherUserID??'',currentPage.toString(), limit.toString());
  }
 /* Future<void> getOtherSavedContentApi() async {
    await BlocProvider.of<TicTocCubit>(context).getOtherBookmarkContentCall(widget.otherUserID??'',"1","10");
  }*/
  // Load more content
  Future<void> _loadMore() async {
    await getOtherSavedContentApi(isLoadMore: true);
  }



  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: BlocConsumer<TicTocCubit,TicTocState>(
        listener: (context,state){
          print("sate.status:${state.status}");
        /*  if(state.status == TicTocStatus.getOtherBookmarkContentSuccess){
            showLoader = false;
            getOtherUserContentResponse = state.responseData?.response as GetOtherUserContentResponse;
          }*/

          if (state.status == TicTocStatus.getOtherBookmarkContentSuccess) {
            final response = state.responseData?.response as GetOtherUserContentResponse;
            final newData = response.data ?? [];

            setState(() {
              if (currentPage == 1) {
                getOtherUserContentResponse.data = newData;
              } else {
                getOtherUserContentResponse.data?.addAll(newData);
              }

              showLoader = false;
              isLoadingMore = false;
              hasMore = (getOtherUserContentResponse.data?.length ?? 0) < (response.total ??0);
            });
          }

          if (state.status == TicTocStatus.getOtherBookmarkContentError) {
            UiHelper.toastMessage(state.errorData?.message ?? state.error ?? "");
          }
        },
        builder: (context,state){
          //  if (state.status == TicTocStatus.suggestedAccountLoading) {
          if (showLoader) {
            return const CustomLoader();
          }
          if (state.status == TicTocStatus.getOtherBookmarkContentError) {
            return CustomErrorWidget(
              errorMessage: state.errorData?.message ?? state.error,
              statusCode: state.errorData?.code,
              onRetry: getOtherSavedContentApi,
              onRefresh: refreshPage,
            );
          }
          return  Padding(
            padding: const EdgeInsets.only(left: 18,right: 18),
            child: RefreshIndicator(
              onRefresh: refreshPage,
              child:  ListView(
                controller: _scrollController, // 💥 Attach the scroll controller
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(), // Enables pull-to-refresh
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:4,left: 18,right: 18),
                    child: getOtherUserContentResponse.data!.isEmpty?
                    EmptyListFound(message: widget.otherUserID==""?'You haven’t saved any posts yet.':'Not saved any posts yet.'
                      ,topHeight: 140,):
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: getOtherUserContentResponse.data?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 4.0,
                          mainAxisExtent: 185
                      ),
                      itemBuilder: (BuildContext context, int index){
                        final item = getOtherUserContentResponse.data![index];
                        return MyInkWell(
                          onTap: ()async{
                            print('Reel Details: ${jsonEncode(item.toJson())}');
                            final result = await PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: OtherDetailedFeed(
                                reelsData: item,
                              ),
                              withNavBar: false,
                              pageTransitionAnimation: PageTransitionAnimation.cupertino,
                            );
                          },
                          child: Column(
                            children: [
                              cachedImageWidget(
                                  image:"${item.url}",
                                  borderRadiusValue:3.3,
                                  height: 140,width: 100),
                              const SizedBox(height: 5,),
                              Row(
                                children: [
                                  Image.asset('assets/images/play_grey.png',height: 10,width: 10,),
                                  const SizedBox(width: 6,),
                                  smallText12(context, item.likeCount.toString(),textColor: appGreyColor,
                                      fontSize: 8,fontWeight: FontWeight.w600),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  if (isLoadingMore) const CustomLoader(size:30),
                  UiHelper.verticalSpace(height: screenHeight*0.09),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Refresh the page
  Future<void> refreshPage() async {
    setState(() {
      showLoader = true;
      hasMore = true;
    });
    await getOtherSavedContentApi();
  }

}
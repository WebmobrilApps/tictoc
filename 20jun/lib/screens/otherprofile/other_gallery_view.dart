import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/get_other_profile_response.dart' as dfrOtherProfile;
import 'package:tictoc/model/get_other_user_content_response.dart' as dfrOtherContent;
import 'package:tictoc/screens/otherprofile/other_detailed_feed.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_loader.dart';
import 'package:tictoc/utils/empty_list_found.dart';
import 'package:tictoc/utils/custom_widgets.dart';

class OtherGalleryView extends StatefulWidget {
  final String userId;
  final dfrOtherContent.GetOtherUserContentResponse getOtherUserContentResponse;
  final bool showLoader;

  const OtherGalleryView({super.key,required this.userId, required this.getOtherUserContentResponse,required this.showLoader});

  @override
  State<OtherGalleryView> createState() => _OtherGalleryViewState();
}

class _OtherGalleryViewState extends State<OtherGalleryView> {
  List<dfrOtherContent.Data> contentData = [];
  bool showLoader = true;
  bool isLoadingMore = false;
  bool hasMore = true;
  int currentPage = 1;
  final int limit = 9;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    showLoader = widget.showLoader;
    contentData = List.from(widget.getOtherUserContentResponse.data!); // safe copy
    _scrollController.addListener(_onScroll);
  }
  // Fetch more content when the user scrolls to the bottom
  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 && !isLoadingMore && hasMore) {
      _loadMore();
    }
  }

  // API call to fetch content
  Future<void> _getOtherUserContent({bool isLoadMore = false}) async {
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
    await BlocProvider.of<TicTocCubit>(context).getOtherUserContentCall(widget.userId,currentPage.toString(), limit.toString());
  }

  // Load more content
  Future<void> _loadMore() async {
    await _getOtherUserContent(isLoadMore: true);
  }

  // Refresh the page
  Future<void> refreshPage() async {
    setState(() {
      showLoader = true;
      hasMore = true;
    });
    await _getOtherUserContent();
  }
  @override
  Widget build(BuildContext context) {
    // List<dfrContent.Data>? contentData = widget.getUserContentResponse.data; // Extract API data

    return BlocConsumer<TicTocCubit, TicTocState>(
      listener: (context, state) {
        if (state.status == TicTocStatus.getOtherUserContentSuccess) {
          final response = state.responseData?.response as dfrOtherContent.GetOtherUserContentResponse;
          final newData = response.data ?? [];

          setState(() {
            if (currentPage == 1) {
              contentData = newData;
            } else {
              contentData.addAll(newData);
            }
            showLoader = false;
            isLoadingMore = false;
            hasMore = contentData.length < (response.total ?? 0);
            print('hasMore:$hasMore');
          });
        }
      },
      builder: (context, state) {
        return widget.showLoader==true?const CustomLoader():
        RefreshIndicator(
          onRefresh: refreshPage,
          child: ListView(
            controller: _scrollController, // 💥 Attach the scroll controller
            padding: EdgeInsets.zero,
            physics: const AlwaysScrollableScrollPhysics(), // Enables pull-to-refresh
            children: [
              Padding(
                padding: const EdgeInsets.only(top:4,left: 18,right: 18,bottom: 70),
                child: Column(
                  children: [
                    contentData.isEmpty?
                    const EmptyListFound(message: 'Not uploaded any posts yet.',topHeight:140):
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: contentData.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 4.0,
                          mainAxisExtent: 185
                      ),
                      itemBuilder: (BuildContext context, int index){
                        final item = contentData[index];
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
                    if (isLoadingMore) const CustomLoader(size:30),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

  }
}

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/model/get_user_content_response.dart';
import 'package:tictoc/screens/profile/bookmark/my_bm_det_reel.dart';
import 'package:tictoc/screens/profile/feeds/detailed_feed.dart';
import 'package:tictoc/screens/profile/profile.dart';
import 'package:tictoc/utils/empty_list_found.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/get_profile_response.dart' as dfrProfile;
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_loader.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/error_display.dart';
import 'package:tictoc/utils/ui_helper.dart';
class MyBookmarkGallery extends StatefulWidget {
  final String? otherUserID;
  final dfrProfile.GetProfileResponse getProfileResponse;

  const MyBookmarkGallery({super.key, this.otherUserID, required this.getProfileResponse});

  @override
  State<MyBookmarkGallery> createState() => _MyBookmarkGalleryState();
}

class _MyBookmarkGalleryState extends State<MyBookmarkGallery> {
  TextEditingController searchController = TextEditingController();
//  GetBookmarkedResponse getBookmarkedResponse = GetBookmarkedResponse();
  GetUserContentResponse getUserContentResponse = GetUserContentResponse();
  int selectedIndex = -1;
  bool showLoader = true;

  @override
  void initState() {
    _getSavedContentApi();
    super.initState();
  }


  Future<void> _getSavedContentApi() async {
    await BlocProvider.of<TicTocCubit>(context).getBookmarkContentCall("1","50");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: BlocConsumer<TicTocCubit,TicTocState>(
        listener: (context,state){
          print("sate.status:${state.status}");
          if(state.status == TicTocStatus.getBookmarkContentSuccess){
            showLoader = false;
            getUserContentResponse = state.responseData?.response as GetUserContentResponse;
          }
          if (state.status == TicTocStatus.getBookmarkContentError) {
            UiHelper.toastMessage(state.errorData?.message ?? state.error ?? "");
          }
        },
        builder: (context,state){
          //  if (state.status == TicTocStatus.suggestedAccountLoading) {
          if (showLoader) {
            return const CustomLoader();
          }
          if (state.status == TicTocStatus.getBookmarkContentError) {
            return CustomErrorWidget(
              errorMessage: state.errorData?.message ?? state.error,
              statusCode: state.errorData?.code,
              onRetry: _getSavedContentApi,
              onRefresh: _refreshPage,
            );
          }
          return  Padding(
            padding: const EdgeInsets.only(left: 18,right: 18),
            child: RefreshIndicator(
              onRefresh: _refreshPage,
              child:  ListView(
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(), // Enables pull-to-refresh
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:4,left: 18,right: 18),
                    child: getUserContentResponse.data!.isEmpty?
                    EmptyListFound(message: widget.otherUserID==""?'You haven’t saved any posts yet.':'Not saved any posts yet.'
                      ,topHeight: 140,):
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: getUserContentResponse.data?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 4.0,
                          mainAxisExtent: 185
                      ),
                      itemBuilder: (BuildContext context, int index){
                        final item = getUserContentResponse.data![index];
                        return MyInkWell(
                          onTap: ()async{
                            print('Updated Profile: ${jsonEncode(item.toJson())}');
                          /*  final result = await PersistentNavBarNavigator.pushNewScreen(
                              context,
                            //  screen: DetailedFeed(
                              screen: MyBmDetReel(
                                reelsData: item,
                                getProfileResponse: widget.getProfileResponse,
                              ),
                              withNavBar: false,
                              pageTransitionAnimation: PageTransitionAnimation.cupertino,
                            );
                            if (result != null && result['deleted'] == true) {
                              profileKey.currentState?.refreshPage();
                            }*/
                             final result = await PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: MyBmDetReel(
                                reelsData: item,
                              ),
                              withNavBar: false,
                              pageTransitionAnimation: PageTransitionAnimation.cupertino,
                            );
                            if (result != null && result['unBookmarked'] == true) {
                              setState(() {
                                getUserContentResponse.data?.removeWhere((element) =>
                                element.pkVideos.toString() == result['id'].toString());
                              });
                            }

                            /*if (result != null && result['deleted'] == true) {
                              setState(() {
                                contentData.removeWhere((element) => element.pkVideos.toString() == result['id'].toString());
                              });
                            }*/
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

                  UiHelper.verticalSpace(height: screenHeight*0.09),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _refreshPage() async{
    setState(() {
      searchController.clear();
      showLoader = true; // Show the loader
    });
    await _getSavedContentApi();
  }
}
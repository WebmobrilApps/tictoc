import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/other_user_following_response.dart';
import 'package:tictoc/screens/otherprofile/other_profile.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_loader.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/error_display.dart';
import 'package:tictoc/utils/empty_list_found.dart';
import 'package:tictoc/utils/ui_helper.dart';


class OtherUserFollowingList extends StatefulWidget {
  final String otherUserId;
  const OtherUserFollowingList({super.key, required this.otherUserId});

  @override
  State<OtherUserFollowingList> createState() => _OtherUserFollowingListState();
}

class _OtherUserFollowingListState extends State<OtherUserFollowingList> {
  OtherUserFollowingListResponse otherUserFollowingListResponse = OtherUserFollowingListResponse(data: []);
  int selectedIndex = -1;

  bool showLoader = true;
  int currentPage = 1;
  final int limit = 14;
  bool isLoadingMore = false;
  bool hasMore = true;
  int totalItems = 0;

  final ScrollController _scrollController = ScrollController();



  @override
  void initState() {
    getOtherFollowingListApi();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
        !isLoadingMore && hasMore) {
      _loadMore();
    }
  }
  Future<void> getOtherFollowingListApi({bool isLoadMore = false}) async {
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
    await BlocProvider.of<TicTocCubit>(context).otherUserFollowingListCall(widget.otherUserId,currentPage.toString(), limit.toString());
  }
  Future<void> _loadMore() async {
    await getOtherFollowingListApi(isLoadMore: true);
  }
  Future<void> _refreshPage() async {
    setState(() {
      showLoader = true;
      hasMore = true;
    });
    await getOtherFollowingListApi();
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Following List'),
      body: BlocConsumer<TicTocCubit,TicTocState>(
        listener: (context,state){
          print("sate.status:${state.status}");
          if (state.status == TicTocStatus.otherUserFollowingListSuccess) {
            final response = state.responseData?.response as OtherUserFollowingListResponse;
            final newData = response.data ?? [];

            setState(() {
              totalItems = response.total ?? 0;

              if (currentPage == 1) {
                otherUserFollowingListResponse.data = newData;
              } else {
                otherUserFollowingListResponse.data?.addAll(newData);
              }

              showLoader = false;
              isLoadingMore = false;

              hasMore = (otherUserFollowingListResponse.data?.length ?? 0) < totalItems;
            });
          }
        },
        builder: (context,state){
          if (showLoader) {
            return const CustomLoader();
          }
          if (state.status == TicTocStatus.otherUserFollowingListError) {
            return CustomErrorWidget(
              errorMessage: state.errorData?.message ?? state.error,
              statusCode: state.errorData?.code,
              onRetry: getOtherFollowingListApi,
              onRefresh: _refreshPage,
            );
          }
          return  RefreshIndicator(
            onRefresh: _refreshPage,
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(top:4,left: 18,right: 18),
                child: Column(
                  children: [
                    const SizedBox(height: 12,),
                    otherUserFollowingListResponse.data!.isEmpty?
                    const EmptyListFound(message: 'There is no Following list'):
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: otherUserFollowingListResponse.data?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        final followingData = otherUserFollowingListResponse.data![index];
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: MyInkWell(
                                    onTap:()async{
                                      // CustomNavigator.push(context: context, screen: ChatScreen(userId:followingData.pkUser.toString()));
                                      if(myUserID.toString() != followingData.userId.toString()){
                                        CustomNavigator.push(context: context, screen: OtherProfile(userId:followingData.userId.toString()));
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        cachedImageWidget(
                                            image:"$BASEURL/${followingData.profilePic??''}", hasProfileImg:true,
                                            borderRadiusValue:50,
                                            height: 45,width: 45),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              mediumText14(context,followingData.name??'',
                                                  maxLines: 1,overflow: TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w500),
                                              //    smallText12(context, followingData.isFollowing==0?'Follows you':'Following',  maxLines: 1,overflow: TextOverflow.ellipsis,),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                followingData.isFollowing==amNotFollowing?
                                Row(
                                  children: [
                                    const SizedBox(width: 6,),
                                    SmallPinkButton(label: 'Follow',fontSize:10,padding:const EdgeInsets.only(left:10,right:10,top:4,bottom: 4),
                                      isLoading:selectedIndex==index&&state.status == TicTocStatus.inOtherFollowingListFollowUserLoading,
                                      onTap: (){
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      /*  Map<String, dynamic> followUserMap = {
                                          "follower_id": followingData.userId,
                                          "following_id": myUserID,
                                        };*/
                                        Map<String, dynamic> followUserMap = {
                                          "follower_id": myUserID,
                                          "following_id": followingData.userId,
                                        };
                                        // BlocProvider.of<TicTocCubit>(context).followUserCall(followUserMap);
                                        BlocProvider.of<TicTocCubit>(context).inOtherFollowingListFollowCall(followUserMap).then((_) {
                                          TicTocState state = BlocProvider.of<TicTocCubit>(context).state;
                                          if(state.status == TicTocStatus.inOtherFollowingListFollowUserError){
                                            print(state.errorData?.message);
                                            String message = state.errorData?.message ?? state.error ?? "";
                                            UiHelper.toastMessage(message);
                                          }
                                          if(state.status == TicTocStatus.inOtherFollowingListFollowUserSuccess){
                                            setState(() {
                                              followingData.isFollowing = 1; // Update the status
                                              selectedIndex = -1; // Reset selected index
                                            });
                                          }
                                        });
                                      },
                                    ),
                                    const SizedBox(width: 6,),
                                    Image.asset('assets/images/clear.png',height: 18, width: 18,)
                                  ],
                                ):
                                const SmallPinkButton(label: 'Following',fontSize:10,backgroundColor:Color(0xffD9D9D9),textColor:Color(0xff484848),
                                  padding:  EdgeInsets.only(left:10,right:10,top:4,bottom: 4),),

                             /*   const SmallPinkButton(label: 'Following',fontSize:10,backgroundColor:Color(0xffD9D9D9),textColor:Color(0xff484848),
                                  padding:  EdgeInsets.only(left:10,right:10,top:4,bottom: 4),),*/

                              ],
                            ),
                            const SizedBox(height: 14,),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 2,),
                    if (isLoadingMore) const CustomLoader(size: 30),
                    const SizedBox(height: 12,),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

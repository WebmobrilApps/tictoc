import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/follower_list_response.dart';
import 'package:tictoc/screens/inbox/chat_screen.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_loader.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/error_display.dart';
import 'package:tictoc/utils/empty_list_found.dart';
import 'package:tictoc/utils/ui_helper.dart';
class Followers extends StatefulWidget {
  const Followers({super.key});

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  FollowerListResponse followerListResponse = FollowerListResponse();
  int selectedIndex = -1;
  @override
  void initState() {
    getFollowersListApi();
    super.initState();
  }

  Future<void> getFollowersListApi() async {
    await BlocProvider.of<TicTocCubit>(context).followerListCall("1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Follower'),
      body: BlocConsumer<TicTocCubit,TicTocState>(
        listener: (context,state){
          print("sate.status:${state.status}");
          if(state.status == TicTocStatus.followerListSuccess){
            Loader.hide();
            followerListResponse = state.responseData?.response as FollowerListResponse;
          }
          if(state.status == TicTocStatus.followUserSuccess){
            Loader.hide();
            UiHelper.toastMessage(state.responseData?.response ?? '');
          }
          if (state.status == TicTocStatus.followUserError){
            Loader.hide();
            print(state.errorData?.message);
            String message = state.errorData?.message ?? state.error ?? "";
            UiHelper.toastMessage(message);
          }
        },
        builder: (context,state){
          if (state.status == TicTocStatus.followerListLoading) {
            return const CustomLoader();
          }
          if (state.status == TicTocStatus.followerListError) {
            return CustomErrorWidget(
              errorMessage: state.errorData?.message ?? state.error,
              statusCode: state.errorData?.code,
              onRetry: getFollowersListApi,
              onRefresh: _refreshPage,
            );
          }
          return  RefreshIndicator(
            onRefresh: _refreshPage,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(top:4,left: 18,right: 18),
                child: Column(
                  children: [
                    const SizedBox(height: 12,),
                    followerListResponse.data!.isEmpty?
                    const EmptyListFound(message: 'There is no follower list'):
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: followerListResponse.data?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        final followersData = followerListResponse.data![index];
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: MyInkWell(
                                    onTap:()async{
                                      CustomNavigator.push(context: context, screen:  ChatScreen(userId:followersData.userId.toString()));
                                    },
                                    child: Row(
                                      children: [
                                        cachedImageWidget(
                                            image:"$BASEURL/${followersData.profilePic??''}",
                                            borderRadiusValue:50, hasProfileImg:true,
                                            height: 45,width: 45),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              mediumText14(context,followersData.name??'',
                                                  maxLines: 1,overflow: TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w500),
                                              smallText12(context, followersData.isFollowing==0?'Follows you':'Following',  maxLines: 1,overflow: TextOverflow.ellipsis,),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                followersData.isFollowing==amNotFollowing?
                                  Row(
                                    children: [
                                      const SizedBox(width: 6,),
                                      SmallPinkButton(label: 'Follow Back',fontSize:10,padding:const EdgeInsets.only(left:10,right:10,top:4,bottom: 4),
                                      isLoading:selectedIndex==index&&state.status == TicTocStatus.followUserLoading,
                                      onTap: (){
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                        Map<String, dynamic> followUserMap = {
                                          "follower_id": userID,
                                          "following_id": followersData.followerId,
                                        };
                                       // BlocProvider.of<TicTocCubit>(context).followUserCall(followUserMap);
                                        BlocProvider.of<TicTocCubit>(context).followUserCall(followUserMap).then((_) {
                                          setState(() {
                                            followerListResponse.data![index].isFollowing = 1; // Update the status
                                            selectedIndex = -1; // Reset selected index
                                          });
                                        }).catchError((error) {
                                          // Handle error (optional)
                                          print("Error following user: $error");
                                        });
                                       },
                                      ),
                                      const SizedBox(width: 6,),
                                      Image.asset('assets/images/clear.png',height: 18, width: 18,)
                                    ],
                                  ):
                                  const SmallPinkButton(label: 'Following',fontSize:10,backgroundColor:Color(0xffD9D9D9),textColor:Color(0xff484848),
                                   padding:  EdgeInsets.only(left:10,right:10,top:4,bottom: 4),),

                              ],
                            ),
                            const SizedBox(height: 14,)

                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 2,),
                  ],
                ),
              ),
            ),
          );


        },
      ),
    );
  }
  Future<void> _refreshPage() async{
    await getFollowersListApi();
  }
}

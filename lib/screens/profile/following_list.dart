import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/following_list_response.dart';
import 'package:tictoc/screens/inbox/chat_screen.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_loader.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/error_display.dart';
import 'package:tictoc/utils/empty_list_found.dart';


class FollowingList extends StatefulWidget {
  const FollowingList({super.key});

  @override
  State<FollowingList> createState() => _FollowingListState();
}

class _FollowingListState extends State<FollowingList> {
  final List inboxData = [
    {"storyImage":"assets/images/inbox1.png", "name":"Thiru", "followStatus":"Following", "message":"lorem ipsum"},
    {"storyImage":"assets/images/inbox2.png", "name":"DisaSmith", "followStatus":"Follow Back", "message":"Follows you"},
    {"storyImage":"assets/images/inbox3.png", "name":"Suriya", "followStatus":"Following", "message":"lorem ipsum"},
    {"storyImage":"assets/images/inbox1.png", "name":"Angel", "followStatus":"Following","message":"Following"},
    {"storyImage":"assets/images/inbox2.png", "name":"Bengamine", "followStatus":"Follow Back", "message":"lorem ipsum"},
    {"storyImage":"assets/images/inbox3.png", "name":"Tokyo", "followStatus":"Following","message":"lorem ipsum"},
    {"storyImage":"assets/images/inbox1.png", "name":"Thiru", "followStatus":"Follow Back", "message":"lorem ipsum"},
    {"storyImage":"assets/images/inbox2.png", "name":"DisaSmith", "followStatus":"Follow Back", "message":"Follows you"},
    {"storyImage":"assets/images/inbox3.png", "name":"Suriya", "followStatus":"Follow Back", "message":"lorem ipsum"},
    {"storyImage":"assets/images/inbox1.png", "name":"Angel", "followStatus":"Following","message":"Following"},
    {"storyImage":"assets/images/inbox2.png", "name":"Bengamine", "followStatus":"Following", "message":"lorem ipsum"},
    {"storyImage":"assets/images/inbox3.png", "name":"Tokyo", "followStatus":"Follow Back","message":"lorem ipsum"},
  ];
  FollowingListResponse followingListResponse = FollowingListResponse();
  int selectedIndex = -1;
  @override
  void initState() {
    getFollowingListApi();
    super.initState();
  }

  Future<void> getFollowingListApi() async {
    await BlocProvider.of<TicTocCubit>(context).followingListCall("1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Following List'),
      body: BlocConsumer<TicTocCubit,TicTocState>(
        listener: (context,state){
          print("sate.status:${state.status}");
          if(state.status == TicTocStatus.followingListSuccess){
            Loader.hide();
            followingListResponse = state.responseData?.response as FollowingListResponse;
          }
        },
        builder: (context,state){
          if (state.status == TicTocStatus.followingListLoading) {
            return const CustomLoader();
          }
          if (state.status == TicTocStatus.followingListError) {
            return CustomErrorWidget(
              errorMessage: state.errorData?.message ?? state.error,
              statusCode: state.errorData?.code,
              onRetry: getFollowingListApi,
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
                    followingListResponse.data!.isEmpty?
                    const EmptyListFound(message: 'There is no Following list'):
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: followingListResponse.data?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        final followingData = followingListResponse.data![index];
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: MyInkWell(
                                    onTap:()async{
                                      CustomNavigator.push(context: context, screen: ChatScreen(userId:followingData.pkUser.toString()));
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

                                const SmallPinkButton(label: 'Following',fontSize:10,backgroundColor:Color(0xffD9D9D9),textColor:Color(0xff484848),
                                  padding:  EdgeInsets.only(left:10,right:10,top:4,bottom: 4),),

                              ],
                            ),
                            if(index+1 != inboxData.length)const SizedBox(height: 14,),

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
    await getFollowingListApi();
  }
}

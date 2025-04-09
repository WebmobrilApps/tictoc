import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/suggested_account_response.dart';
import 'package:tictoc/screens/friends/widgets/suggested_item.dart';
import 'package:tictoc/screens/otherprofile/other_profile.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_loader.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/empty_list_found.dart';
import 'package:tictoc/utils/error_display.dart';
import 'package:tictoc/utils/ui_helper.dart';
class Friends extends StatefulWidget {
  const Friends({super.key});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  TextEditingController searchController = TextEditingController();
  SuggestedAccountResponse suggestedAccountResponse = SuggestedAccountResponse();
  int selectedIndex = -1;
  bool showLoader = true;
  Timer? _debounce; // To debounce search requests

  @override
  void initState() {
    super.initState();
    _getSuggestedAccount(); // Initial API call

    // Add listener to searchController
    searchController.addListener(() {
      _onSearchChanged();
    });
  }

  // Debounced function to handle search input
  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchController.text.trim().length >= 3) {
        _getSuggestedAccount();
      }
    });
  }

  Future<void> _getSuggestedAccount() async {
 //   await BlocProvider.of<TicTocCubit>(context).suggestedAccountCall("", "1");
    await BlocProvider.of<TicTocCubit>(context).suggestedAccountCall(searchController.text, "1");
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel(); // Cancel debounce timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: whiteColor, // Green status bar
        statusBarIconBrightness: Brightness.dark, // Light icons for better contrast
      ),
      child: Scaffold(
        backgroundColor: appBgColor,
        body: BlocConsumer<TicTocCubit,TicTocState>(
          listener: (context,state){
            print("sate.status:${state.status}");
            if(state.status == TicTocStatus.suggestedAccountSuccess){
              showLoader = false;
              suggestedAccountResponse = state.responseData?.response as SuggestedAccountResponse;
            }
            if(state.status == TicTocStatus.followUserSuccess){
              UiHelper.toastMessage(state.responseData?.response ?? '');
            }
            if (state.status == TicTocStatus.followUserError){
              print(state.errorData?.message);
              String message = state.errorData?.message ?? state.error ?? "";
              UiHelper.toastMessage(message);
            }
          },
          builder: (context,state){
          //  if (state.status == TicTocStatus.suggestedAccountLoading) {
            if (showLoader) {
              return const CustomLoader();
            }
            if (state.status == TicTocStatus.suggestedAccountError) {
              return CustomErrorWidget(
                errorMessage: state.errorData?.message ?? state.error,
                statusCode: state.errorData?.code,
                onRetry: _getSuggestedAccount,
                onRefresh: _refreshPage,
              );
            }
            return  Padding(
              padding: const EdgeInsets.only(left: 18,right: 18),
              child: Column(
                children: [
                  UiHelper.verticalSpace(height: screenHeight*0.08),
                  Row(
                    children: [
                      Expanded(
                        child: customTextFieldWithBorder(
                          height: 42,
                          hintText: 'Find Friends',
                          controller: searchController,
                          hintFontColor: const Color(0XFF0B0B0B),
                          hintFontSize: 15,
                          textFontSize: 15,
                          bgColor:const Color(0XFFF2F2F2),
                          borderRadiusValue: 10,
                          borderColor:const Color(0XFFF2F2F2),
                          prefixIcon: Image.asset('assets/images/search_black.png',color: const Color(0xff0B0B0B), height: 20, width: 20),
                          suffixIcon: MyInkWell(
                              onTap: () async {
                                searchController.clear();
                                _getSuggestedAccount(); // Reset API call
                              },
                              child: Image.asset('assets/images/clear.png', color:appBlackColor,height: 20, width: 20)),
                        ),
                      ),
                      const SizedBox(width: 12,),
                      Image.asset('assets/images/scan.png', height: 24, width: 24),
                    ],
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _refreshPage,
                      child:  ListView(
                        padding: EdgeInsets.zero,
                        physics: const AlwaysScrollableScrollPhysics(), // Enables pull-to-refresh
                        children: [
                          UiHelper.verticalSpace(height: 24),
                          SuggestedItem(
                            imagePath: 'assets/images/invite_friends.png',
                            title: 'Invite friends',
                            subtitle: 'Stay connected on TikTok',
                            buttonLabel: 'Invite',
                            onTap: () {
                              Share.share('Check out this awesome Flutter package!');
                            },
                          ),
                          SuggestedItem(
                            imagePath: 'assets/images/contacts.png',
                            title: 'Contacts',
                            subtitle: 'Find your contacts',
                            buttonLabel: 'Find',
                            onTap: () {
                              // Add your logic for finding contacts here
                            },
                          ),
                          SuggestedItem(
                            imagePath: 'assets/images/facebook.png',
                            title: 'Facebook Friends',
                            subtitle: 'Find friends on Facebook',
                            buttonLabel: 'Find',
                            onTap: () {
                              // Add your logic for finding Facebook friends here
                            },
                          ),
                          UiHelper.verticalSpace(height: 10),
                          mediumText14(context, 'Suggested accounts',textColor: const Color(0xff484848),fontWeight: FontWeight.w500),
                          UiHelper.verticalSpace(height: 12),
                          suggestedAccountResponse.data!.isEmpty?
                          const EmptyListFound(message: 'There is no suggestion list',topHeight:130):
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: suggestedAccountResponse.data?.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              final suggestedData = suggestedAccountResponse.data![index];
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            MyInkWell(
                                                onTap:()async{
                                                  final result = await PersistentNavBarNavigator.pushNewScreen(
                                                    context,
                                                    screen: OtherProfile(userId: suggestedData.pkUser.toString()),
                                                    withNavBar: false,
                                                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                                  );

                                                  if (result == true) {
                                                    // User followed/unfollowed in OtherProfile → Refresh the list or update UI
                                                    _getSuggestedAccount(); // or update single item if preferred
                                                  }
                                                 /* PersistentNavBarNavigator.pushNewScreen(
                                                    context,
                                                    screen:  OtherProfile(userId:suggestedData.pkUser.toString()),
                                                    withNavBar: false, // OPTIONAL VALUE. True by default.
                                                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                                  );*/
                                                },
                                                child: cachedImageWidget(
                                                    image:"$BASEURL/${suggestedData.profilePic??''}",
                                                    borderRadiusValue:50,
                                                    hasProfileImg:true,
                                                    height: 50,width: 50),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  mediumText14(context,capsFirstChar(suggestedData.name.toString()),
                                                      maxLines: 1,overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w500),
                                                  smallText12(context, suggestedData.followingStatus==amNotFollowing?'follows you':'Following',  maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SmallPinkButton(label: suggestedAccountResponse.data![index].followingStatus==0?'Follow':'UnFollow',
                                            fontSize:12,
                                         //   width: 80,
                                            isLoading:selectedIndex==index&&state.status == TicTocStatus.followUserLoading || selectedIndex==index&&state.status == TicTocStatus.unFollowUserLoading,
                                            onTap:(){
                                              setState(() {
                                                selectedIndex = index;
                                              });
                                              if(suggestedAccountResponse.data![index].followingStatus==0){
                                                Map<String, dynamic> followUserMap = {
                                                  "follower_id": userID,
                                                  "following_id": suggestedData.pkUser,
                                                };
                                                BlocProvider.of<TicTocCubit>(context).followUserCall(followUserMap).then((_) {
                                                  setState(() {
                                                    suggestedAccountResponse.data![index].followingStatus = 1; // Update the status
                                                    selectedIndex = -1; // Reset selected index
                                                  });
                                                  //  _getSuggestedAccount();
                                                }).catchError((error) {
                                                  // Handle error (optional)
                                                  print("Error following user: $error");
                                                });
                                              }else{
                                                BlocProvider.of<TicTocCubit>(context).unFollowUserCall(suggestedData.pkUser??0).then((_) {
                                                  setState(() {
                                                    suggestedAccountResponse.data![index].followingStatus = 0; // Update the status
                                                    selectedIndex = -1; // Reset selected index
                                                  });
                                                  //  _getSuggestedAccount();
                                                }).catchError((error) {
                                                  // Handle error (optional)
                                                  print("Error following user: $error");
                                                });
                                              }

                                            },
                                          ),
                                          const SizedBox(width: 6,),
                                          Image.asset('assets/images/clear.png',height: 20, width: 20),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                ],
                              );
                            },
                          ),
                          UiHelper.verticalSpace(height: screenHeight*0.09),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _refreshPage() async{
    setState(() {
      searchController.clear();
      showLoader = true; // Show the loader
    });
    await _getSuggestedAccount();
  }
}

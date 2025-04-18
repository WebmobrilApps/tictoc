import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/get_other_profile_response.dart';
import 'package:tictoc/model/get_other_user_content_response.dart';
import 'package:tictoc/screens/otherprofile/bookmark/other_bookmark_gallery.dart';
import 'package:tictoc/screens/otherprofile/other_gallery_view.dart';
import 'package:tictoc/screens/otherprofile/other_profile_appbar.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_loader.dart';
import 'package:tictoc/utils/error_display.dart';
import 'package:tictoc/utils/ui_helper.dart';

class OtherProfile extends StatefulWidget {
  final String userId;
  const OtherProfile({super.key, required this.userId});

  @override
  State<OtherProfile> createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> with SingleTickerProviderStateMixin {

  bool showLoader = true;
  int limit = 9;
  late int? originalFollowStatus;

  late TabController _tabController;
  GetOtherUserContentResponse getOtherUserContentResponse = GetOtherUserContentResponse();
  GetOtherProfileResponse getOtherProfileResponse = GetOtherProfileResponse();
  @override
  void initState() {
    _getOtherProfileAPi();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0); // 3 tabs, "Following" as default
    _tabController.addListener(_handleTabChange);
    super.initState();
  }
  void _handleTabChange() {
    if (_tabController.indexIsChanging) return;
    setState(() {
      showLoader = true;
    });
    if (_tabController.index == 0) {
      BlocProvider.of<TicTocCubit>(context).getOtherUserContentCall(widget.userId,"1", limit.toString());
    }
  }

  Future<void> _getOtherProfileAPi() async {
    await BlocProvider.of<TicTocCubit>(context).otherProfileCall(widget.userId);
  }
  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange); // Clean up listener
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final currentStatus = getOtherProfileResponse.data?.isFollowing;
        print('currentStatus:$currentStatus');
        print('originalFollowStatus:$originalFollowStatus');
        if (currentStatus != originalFollowStatus) {
          Navigator.pop(context, currentStatus);
        } else {
          Navigator.pop(context, null);
        }
        return true; // Allow back navigation
      },

      child: Scaffold(
          backgroundColor: whiteColor,
          body: BlocConsumer<TicTocCubit,TicTocState>(
            listener: (context,state){
              print("sate.status:${state.status}");
              if(state.status == TicTocStatus.getOtherProfileSuccess){
                getOtherProfileResponse = state.responseData?.response as GetOtherProfileResponse;
                originalFollowStatus = getOtherProfileResponse.data?.isFollowing;

                BlocProvider.of<TicTocCubit>(context).getOtherUserContentCall(widget.userId,"1",limit.toString());
              }
              if(state.status == TicTocStatus.getOtherUserContentSuccess){
                showLoader = false;
                getOtherUserContentResponse = state.responseData?.response as GetOtherUserContentResponse;
              }
            },
            builder: (context,state){
              if (state.status == TicTocStatus.getOtherProfileLoading) {
                return const CustomLoader();
              }
              if (state.status == TicTocStatus.getOtherProfileError) {
                return CustomErrorWidget(
                  errorMessage: state.errorData?.message ?? state.error,
                  statusCode: state.errorData?.code,
                  onRetry: refreshPage,
                  onRefresh: refreshPage,
                );
              }
              return  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UiHelper.verticalSpace(height: screenHeight*0.070),
                  OtherProfileAppBar(getOtherProfileResponse: getOtherProfileResponse,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UiHelper.horizontalSpace(width: 18),
                      Expanded(
                        child: TabBar(
                          controller: _tabController,
                          indicatorColor: const Color(0xff484848),
                          indicatorWeight: 2.0,
                          indicator:  UnderlineTabIndicator(
                            borderSide: const BorderSide(width: 3.0, color: Color(0xff484848)),
                            insets: const EdgeInsets.only(bottom: 6),
                            borderRadius:BorderRadius.circular(0.0), // Adjust if needed
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey,
                          labelStyle: GoogleFonts.jost(color: appGreyColor,fontSize: 16,fontWeight: FontWeight.w600),
                          unselectedLabelStyle: GoogleFonts.jost(color: appGreyColor,fontSize: 12,fontWeight: FontWeight.w600),
                          dividerColor:Colors.transparent,
                          padding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          tabs: [
                            Tab(icon:Image.asset('assets/images/gridicons_posts.png',width: 25,height: 21.32,)),
                            Tab(icon:Image.asset('assets/images/bookmark_grey.png',width: 25,height: 21.32,)),
                          ],
                        ),
                      ),
                      UiHelper.horizontalSpace(width: 18),
                    ],
                  ),
                  const Divider(color: Color(0xffADADAD),thickness: 1.5,),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children:  [
                        showLoader ? const CustomLoader() :
                        OtherGalleryView(userId:widget.userId,getOtherUserContentResponse:getOtherUserContentResponse, showLoader:showLoader),
                        OtherBookmarkGallery(otherUserID:widget.userId,getOtherProfileResponse: getOtherProfileResponse,),
                      ],
                    ),
                  ),
                ],
              );
            },
          )
      ),
    );
  }
  Future<void> refreshPage() async{
    setState(() {
      showLoader = true;
    });
    await _getOtherProfileAPi();
  }
}
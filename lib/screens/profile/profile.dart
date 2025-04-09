import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/get_profile_response.dart';
import 'package:tictoc/model/get_user_content_response.dart';
import 'package:tictoc/screens/profile/bookmark/bookmarked_reels.dart';
import 'package:tictoc/screens/profile/feeds/gallery_view.dart';
import 'package:tictoc/screens/profile/widgets/profile_appbar.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_loader.dart';
import 'package:tictoc/utils/error_display.dart';
import 'package:tictoc/utils/ui_helper.dart';
class Profile extends StatefulWidget {
  final PersistentTabController controller;
  const Profile({super.key, required this.controller});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  GetProfileResponse getProfileResponse = GetProfileResponse();
  GetUserContentResponse getUserContentResponse = GetUserContentResponse();

  @override
  void initState() {
    _getProfileAPi();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0); // 3 tabs, "Following" as default
    super.initState();
  }

  Future<void> _getProfileAPi() async {
    await BlocProvider.of<TicTocCubit>(context).getProfileCall();
  }


  @override
  void dispose() {
    _tabController.dispose();
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
            if(state.status == TicTocStatus.getProfileSuccess){
              Loader.hide();
              getProfileResponse = state.responseData?.response as GetProfileResponse;
              BlocProvider.of<TicTocCubit>(context).getUserContentCall("1", "50");
            }
            if(state.status == TicTocStatus.getUserContentSuccess){
              Loader.hide();
              getUserContentResponse = state.responseData?.response as GetUserContentResponse;
            }
          },
          builder: (context,state){
            if (state.status == TicTocStatus.getProfileLoading) {
              return const CustomLoader();
            }
            if (state.status == TicTocStatus.getProfileError) {
              return CustomErrorWidget(
                errorMessage: state.errorData?.message ?? state.error,
                statusCode: state.errorData?.code,
                onRetry: _refreshPage,
                onRefresh: _refreshPage,
              );
            }
            return  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UiHelper.verticalSpace(height: screenHeight*0.075),
                RefreshIndicator( // Ensures pull to refresh works
                  onRefresh: _refreshPage, // Calls API on pull down
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(), // Allows pull down even if content is small
                    child: Column(
                      children: [
                        ProfileAppBar(getProfileResponse: getProfileResponse,),
                        ProfileInfo(getProfileResponse: getProfileResponse, controller: widget.controller),
                        const SizedBox(height: 6,),
                      ],
                    ),
                  ),
                ),
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
                      state.status == TicTocStatus.getUserContentLoading ? const CustomLoader() :
                      GalleryView(getUserContentResponse:getUserContentResponse,getProfileResponse: getProfileResponse,),
                      const BookmarkedReels(),
                     // Center(child: largeText16(context, 'Bookmark')),
                    ],
                  ),
                ),
              ],
            );


          },
        ),
      ),
    );
  }
  Future<void> _refreshPage() async{
    await _getProfileAPi();
  }
}

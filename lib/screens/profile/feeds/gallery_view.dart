import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/model/get_profile_response.dart' as dfrProfile;
import 'package:tictoc/model/get_user_content_response.dart'as dfrContent;
import 'package:tictoc/screens/profile/feeds/detailed_feed.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/empty_list_found.dart';
import 'package:tictoc/utils/custom_widgets.dart';
class GalleryView extends StatefulWidget {
  final dfrContent.GetUserContentResponse getUserContentResponse;
  final dfrProfile.GetProfileResponse getProfileResponse;
  const GalleryView({super.key, required this.getUserContentResponse, required this.getProfileResponse});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  List<dfrContent.Data> contentData = [];
  @override
  void initState() {
    super.initState();
    contentData = List.from(widget.getUserContentResponse.data!); // safe copy
  }
  @override
  Widget build(BuildContext context) {
   // List<dfrContent.Data>? contentData = widget.getUserContentResponse.data; // Extract API data


    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:4,left: 18,right: 18),
            child: contentData.isEmpty?
            const EmptyListFound(message: 'You haven’t uploaded any posts yet.',topHeight:140):
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
                    print('Updated Profile: ${jsonEncode(item.toJson())}');
                    final result = await PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: DetailedFeed(
                        reelsData: item,
                        getProfileResponse: widget.getProfileResponse,
                      ),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    );

                    if (result != null && result['deleted'] == true) {
                      setState(() {
                        contentData.removeWhere((element) => element.pkVideos.toString() == result['id'].toString());
                      });
                    }
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
          const SizedBox(height: 75,),
        ],
      ),
    );
  }
}

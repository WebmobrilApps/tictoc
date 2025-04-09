import 'package:flutter/material.dart';
import 'package:tictoc/model/get_other_profile_response.dart' as dfrOtherProfile;
import 'package:tictoc/model/get_other_user_content_response.dart' as dfrOtherContent;
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/empty_list_found.dart';
import 'package:tictoc/utils/custom_widgets.dart';

class OtherGalleryView extends StatefulWidget {
  final dfrOtherContent.GetOtherUserContentResponse getOtherUserContentResponse;
  final dfrOtherProfile.GetOtherProfileResponse getOtherProfileResponse;
  const OtherGalleryView({super.key, required this.getOtherUserContentResponse, required this.getOtherProfileResponse});

  @override
  State<OtherGalleryView> createState() => _OtherGalleryViewState();
}

class _OtherGalleryViewState extends State<OtherGalleryView> {
  List<dfrOtherContent.Data> contentData = [];
  @override
  void initState() {
    super.initState();
    contentData = List.from(widget.getOtherUserContentResponse.data!); // safe copy
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
                   /* print('Updated Profile: ${jsonEncode(item.toJson())}');
                    final result = await PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: OtherDetailedFeed(
                        reelsData: item,
                        getOtherProfileResponse: widget.getOtherProfileResponse,
                      ),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    );

                    if (result != null && result['deleted'] == true) {
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
          const SizedBox(height: 75,),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tictoc/model/get_user_content_response.dart'as dfrContent;
import 'package:tictoc/model/get_other_profile_response.dart' as dfrOtherProfile;
import 'package:tictoc/screens/otherprofile/other_bottom_details.dart';
import 'package:tictoc/screens/otherprofile/other_side_icon.dart';
import 'package:tictoc/screens/profile/feeds/bottom_details_profile.dart';

class OtherDetailedFeed extends StatefulWidget {
  final dfrContent.Data reelsData; // <-- Receive the Data object
  final dfrOtherProfile.GetOtherProfileResponse getOtherProfileResponse;
  const OtherDetailedFeed({super.key, required this.reelsData, required this.getOtherProfileResponse });

  @override
  State<OtherDetailedFeed> createState() => _OtherDetailedFeedState();
}

class _OtherDetailedFeedState extends State<OtherDetailedFeed> {
  @override
  Widget build(BuildContext context) {
    final userData = widget.getOtherProfileResponse.data;
    return Scaffold(
      backgroundColor: Colors.black, // for better full-screen effect
      body: Stack(
        children: [
          Center(
            child: CachedNetworkImage(
              imageUrl: widget.reelsData.url ?? '',
              fit: BoxFit.fitHeight,
              width: double.infinity,
              height: double.infinity,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Center(child: Icon(Icons.error, color: Colors.white)),
            ),
          ),
          Positioned(
            top: 60,left: 10,
            child: IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: Image.asset(
                "assets/images/back_arrow_black.png",color: Colors.white,
                height: 28, // Adjust these sizes if needed
                width: 28,
              ),
            ),
          ),
          OtherSideIcon(getOtherProfileResponse:widget.getOtherProfileResponse, reelsData: widget.reelsData,),
          OtherBottomDetails(getOtherProfileResponse:widget.getOtherProfileResponse, reelsData: widget.reelsData,),
        ],
      ),
    );
  }
}

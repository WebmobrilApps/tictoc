import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tictoc/model/get_other_user_content_response.dart' as dfrOtherContent;
import 'package:tictoc/screens/otherprofile/widgets/bottom_details_other.dart';
import 'package:tictoc/screens/otherprofile/widgets/side_icon_other.dart';

class OtherDetailedFeed extends StatefulWidget {
  final dfrOtherContent.Data reelsData; // <-- Receive the Data object
  const OtherDetailedFeed({super.key, required this.reelsData,});

  @override
  State<OtherDetailedFeed> createState() => _OtherDetailedFeedState();
}

class _OtherDetailedFeedState extends State<OtherDetailedFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // for better full-screen effect
      body: Stack(
        children: [
          Center(
            child: CachedNetworkImage(
              imageUrl: widget.reelsData.url ?? '',
            //  fit: BoxFit.fitHeight,
              fit: BoxFit.cover,
              width: double.infinity,
           //   height: double.infinity,
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
          SideIconOther(reelsData: widget.reelsData,),
          BottomDetailsOther(reelsData: widget.reelsData,),
        ],
      ),
    );
  }
}

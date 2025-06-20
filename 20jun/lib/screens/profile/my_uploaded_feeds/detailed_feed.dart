import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tictoc/model/get_user_content_response.dart'as dfrContent;
import 'package:tictoc/screens/profile/my_uploaded_feeds/bottom_details_profile.dart';
import 'package:tictoc/screens/profile/my_uploaded_feeds/side_icon_profile.dart';
class DetailedFeed extends StatefulWidget {
  final dfrContent.Data reelsData; // <-- Receive the Data object
  const DetailedFeed({super.key, required this.reelsData });

  @override
  State<DetailedFeed> createState() => _DetailedFeedState();
}

class _DetailedFeedState extends State<DetailedFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // for better full-screen effect
      body: Stack(
        children: [
          Center(
            child: CachedNetworkImage(
              imageUrl: widget.reelsData.url ?? '',
              fit: BoxFit.cover,
              width: double.infinity,
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
          SideIconProfile(reelsData: widget.reelsData,),
          BottomDetailsProfile(reelsData: widget.reelsData,),
        ],
      ),
    );
  }
}

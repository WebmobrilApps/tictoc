
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/for_you_feed_response.dart';
import 'package:tictoc/utils/custom_loader.dart';
import 'package:tictoc/utils/error_display.dart';

import 'widgets/video_reel.dart';

// List of video URLs
final List<String> videoUrls = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
  'https://www.exit109.com/~dnn/clips/RW20seconds_1.mp4',
 // 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4',
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
  'https://www.exit109.com/~dnn/clips/RW20seconds_1.mp4',
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
];


class ForYou extends StatefulWidget {
  const ForYou({super.key});

  @override
  State<ForYou> createState() => _ForYouState();
}

class _ForYouState extends State<ForYou> {
  ForYouFeedResponse forYouFeedResponse = ForYouFeedResponse();

  @override
  void initState() {
    _forYouFeedAPI();
    super.initState();
  }

  Future<void> _forYouFeedAPI() async {
    await BlocProvider.of<TicTocCubit>(context).forYouFeedCall("1", "10");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<TicTocCubit,TicTocState>(
        listener: (context,state){
          print("sate.status:${state.status}");
          if(state.status == TicTocStatus.forYouFeedSuccess){
            Loader.hide();
            forYouFeedResponse = state.responseData?.response as ForYouFeedResponse;
          }
        },
        builder: (context,state){
          if (state.status == TicTocStatus.forYouFeedLoading) {
            return const CustomLoader();
          }
          if (state.status == TicTocStatus.forYouFeedError) {
            return CustomErrorWidget(
              errorMessage: state.errorData?.message ?? state.error,
              statusCode: state.errorData?.code,
              onRetry: _forYouFeedAPI,
              onRefresh: _refreshPage,
            );
          }
          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: videoUrls.length,
            itemBuilder: (context, index) {
              return VideoReel(
                videoUrl: videoUrls[index],
              );
            },
          );


        },
      ),
    );
  }

  Future<void> _refreshPage() async{
    await _forYouFeedAPI();
  }
}



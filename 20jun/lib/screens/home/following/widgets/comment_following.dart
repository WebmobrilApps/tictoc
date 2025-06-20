import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/screens/home/following/widgets/comment_header.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_loader.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/empty_list_found.dart';
import 'package:tictoc/utils/error_display.dart';
import 'package:tictoc/utils/time_rule.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:tictoc/model/get_comments_response.dart';


class CommentBottomSheetWrapper extends StatefulWidget {
  final String videoId;
  const CommentBottomSheetWrapper({super.key, required this.videoId});

  @override
  State<CommentBottomSheetWrapper> createState() => _CommentBottomSheetWrapperState();
}

class _CommentBottomSheetWrapperState extends State<CommentBottomSheetWrapper> {
  final TextEditingController commentController = TextEditingController();
  GetCommentsResponse getCommentsResponse = GetCommentsResponse();

  bool showLoader = true;
  int _commentCount = 0;

  int currentPage = 1;
  final int limit = 10;
  bool hasMore = true;
  bool isLoadingMore = false;
  bool showNoMoreMessage = false;

  final ScrollController _scrollController = ScrollController(); // new



  @override
  void initState() {
    super.initState();
    _getAllCommentsApi();
    _scrollController.addListener(_onScroll);

  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100 &&
        !isLoadingMore && hasMore) {
      _loadMore();
    }
  }

  Future<void> _getAllCommentsApi({bool isLoadMore = false}) async {
    if (isLoadMore) {
      setState(() => isLoadingMore = true);
      currentPage++;
    } else {
      currentPage = 1;
    //  showLoader = true;
      hasMore = true;
    }

    await BlocProvider.of<TicTocCubit>(context)
        .getCommentsCall(widget.videoId, currentPage.toString(), limit.toString());
  }

  Future<void> _loadMore() async {
    await _getAllCommentsApi(isLoadMore: true);
  }




  /* Future<void> _getAllCommentsApi() async {
    BlocProvider.of<TicTocCubit>(context).getCommentsCall(widget.videoId, "1", "100");
  }*/
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets, // 👈 keyboard-aware padding
        child: DraggableScrollableSheet(
          initialChildSize: 0.65, // Starts at 50% screen height
          minChildSize: 0.65,     // Minimum height
          maxChildSize: 0.95,    // Full screen when scrolled
          expand: false,
          builder: (context, scrollController) {
            return BlocConsumer<TicTocCubit, TicTocState>(
              listener: (context, state) {
                if (state.status == TicTocStatus.getCommentsSuccess) {
                  final response = state.responseData?.response as GetCommentsResponse;
                  final newData = response.data ?? [];

                  setState(() {
                    if (currentPage == 1) {
                      getCommentsResponse.data = newData;
                    } else {
                      getCommentsResponse.data?.addAll(newData);
                    }

                    _commentCount = response.total ?? 0;
                    showLoader = false;
                    isLoadingMore = false;
                    hasMore = (getCommentsResponse.data?.length ?? 0) < (response.total ?? 0);
                  });

                  if (!hasMore && currentPage > 1) {
                    setState(() {
                      showNoMoreMessage = true;
                    });

                    Future.delayed(const Duration(seconds: 2), () {
                      if (mounted) {
                        setState(() {
                          showNoMoreMessage = false;
                        });
                      }
                    });
                  }


                }

                if (state.status == TicTocStatus.sendCommentSuccess) {
                  commentController.clear();
                  _refreshPage();
                }
              },
              builder: (context,state){
                if (showLoader) return const CustomLoader();
                if (state.status == TicTocStatus.getCommentsError) {
                  return CustomErrorWidget(
                    errorMessage: state.errorData?.message ?? state.error,
                    statusCode: state.errorData?.code,
                    onRetry: _refreshPage,
                    onRefresh: _refreshPage,
                  );
                }
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(80)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      CommentHeader(
                        onClose: () => Navigator.of(context).pop(_commentCount),
                      ),
                      Expanded(
                        child: getCommentsResponse.data!.isEmpty
                            ? const SingleChildScrollView(
                          child: EmptyListFound(message: 'No Comments available for this post',topHeight: 120,),
                        )
                            : ListView.builder(
                      //    controller: scrollController, // 👈 pass this
                          controller: _scrollController, // 👈 pass this
                          padding: EdgeInsets.zero,
                          itemCount: getCommentsResponse.data?.length,
                          itemBuilder: (context, index) {
                            final comment = getCommentsResponse.data![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  cachedImageWidget(
                                      image:"$BASEURL/${comment.profilePic??''}",
                                      borderRadiusValue:50,
                                      hasProfileImg:true,
                                      height: 50,width: 50),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        mediumText14(context,comment.name ?? '',fontWeight: FontWeight.bold),
                                        smallText12(context,'@${comment.username}',fontSize: 8),
                                        const SizedBox(height: 6),
                                        mediumText14(context,comment.comment ?? '',fontSize: 12),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  smallText12(context,TimeRule.timeAgo(comment.createdAt ?? ''),fontSize: 10),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      UiHelper.verticalSpace(height: 10),
                      if (isLoadingMore) const CustomLoader(size:30),
                  //    if (!hasMore && currentPage > 1)
                      if (showNoMoreMessage)
                        smallText12(context, 'No more comments', textColor: Colors.grey),
                      UiHelper.verticalSpace(height: 10),
                      customMultipleTextField1(
                        height: 50,
                        hintText: 'Type your comments',
                        hintFontWeight: FontWeight.w500,
                        controller: commentController,
                        inputBgColor: Colors.white,
                        hintFontColor: appGreyColor,
                        hintFontSize: 16,
                        contentPadding:
                        const EdgeInsets.only(left: 18, right: 18, top: 12, bottom: 12),
                        suffixIcons: [
                          MyInkWell(
                              onTap: ()async{
                                if(commentController.text.isEmpty){
                                  UiHelper.toastMessage('Please enter comment');
                                }else{
                                  Map<String, dynamic> commentDetails = {
                                    "pk_videos": widget.videoId,
                                    "comment": commentController.text,
                                  };
                                  print('commentDetails:$commentDetails');
                                  BlocProvider.of<TicTocCubit>(context).sendCommentCall(commentDetails);
                                }
                              },
                              child: state.status==TicTocStatus.sendCommentLoading?const SizedBox(height:20,width:20,child: CircularProgressIndicator(color: buttonColor,strokeWidth: 3.0,)):
                              Image.asset('assets/images/share_grey.png', height: 22, width: 22)),
                        ],
                      ),
                      UiHelper.verticalSpace(height: 18),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _refreshPage() async{
    await _getAllCommentsApi();
  }

}



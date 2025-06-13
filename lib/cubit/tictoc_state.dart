
//part of 'spotsball_cubit.dart';

part of 'tictoc_cubit.dart';

enum TicTocStatus {
  initial,

  signUpLoading,
  signUpSuccess,
  signUpError,

  registerVerifyOTPLoading,
  registerVerifyOTPSuccess,
  registerVerifyOTPError,

  resendVerifyOTPLoading,
  resendVerifyOTPSuccess,
  resendVerifyOTPError,

  signInLoading,
  signInSuccess,
  signInError,

  guestLoginLoading,
  guestLoginSuccess,
  guestLoginError,

  forgotPasswordLoading,
  forgotPasswordSuccess,
  forgotPasswordError,

  forgotOtpVerifyLoading,
  forgotOtpVerifySuccess,
  forgotOtpVerifyError,

  resetPasswordLoading,
  resetPasswordSuccess,
  resetPasswordError,

  userInterestLoading,
  userInterestSuccess,
  userInterestError,

  getProfileLoading,
  getProfileSuccess,
  getProfileError,

  updateProfileLoading,
  updateProfileSuccess,
  updateProfileError,

  suggestedAccountLoading,
  suggestedAccountSuccess,
  suggestedAccountError,

  followerListLoading,
  followerListSuccess,
  followerListError,

  followUserLoading,
  followUserSuccess,
  followUserError,

  inOtherFollowingListFollowUserLoading,
  inOtherFollowingListFollowUserSuccess,
  inOtherFollowingListFollowUserError,

  unFollowUserLoading,
  unFollowUserSuccess,
  unFollowUserError,

  followingListLoading,
  followingListSuccess,
  followingListError,

  otherUserFollowingListLoading,
  otherUserFollowingListSuccess,
  otherUserFollowingListError,

  forYouFeedLoading,
  forYouFeedSuccess,
  forYouFeedError,

  uploadContentLoading,
  uploadContentSuccess,
  uploadContentError,

  getUserContentLoading,
  getUserContentSuccess,
  getUserContentError,

  getOtherUserContentLoading,
  getOtherUserContentSuccess,
  getOtherUserContentError,

  deletePostLoading,
  deletePostSuccess,
  deletePostError,

  getOtherProfileLoading,
  getOtherProfileSuccess,
  getOtherProfileError,

  exploreLoading,
  exploreSuccess,
  exploreError,

  followingFeedLoading,
  followingFeedSuccess,
  followingFeedError,

  hitLikeFollowingReelsLoading,
  hitLikeFollowingReelsSuccess,
  hitLikeFollowingReelsError,

  hitLikeProfileLoading,
  hitLikeProfileSuccess,
  hitLikeProfileError,

  hitLikeOtherProfileLoading,
  hitLikeOtherProfileSuccess,
  hitLikeOtherProfileError,

  bookmarkFollowingLoading,
  bookmarkFollowingSuccess,
  bookmarkFollowingError,

  bookmarkProfileLoading,
  bookmarkProfileSuccess,
  bookmarkProfileError,

  bookmarkExploreLoading,
  bookmarkExploreSuccess,
  bookmarkExploreError,

  bookmarkOtherProfileLoading,
  bookmarkOtherProfileSuccess,
  bookmarkOtherProfileError,

  getBookmarkContentLoading,
  getBookmarkContentSuccess,
  getBookmarkContentError,

  getOtherBookmarkContentLoading,
  getOtherBookmarkContentSuccess,
  getOtherBookmarkContentError,

  getCommentsLoading,
  getCommentsSuccess,
  getCommentsError,

  sendCommentLoading,
  sendCommentSuccess,
  sendCommentError,

  otherUserFollowersLoading,
  otherUserFollowersSuccess,
  otherUserFollowersError,

  changePasswordLoading,
  changePasswordSuccess,
  changePasswordError,

  leaveReasonLoading,
  leaveReasonSuccess,
  leaveReasonError,

  guestLogoutLoading,
  guestLogoutSuccess,
  guestLogoutError,










}


class TicTocState extends Equatable {
  final TicTocStatus status;
  final ResponseData? responseData;
  final ErrorData? errorData;
  final String? error;

  const TicTocState({
    this.status = TicTocStatus.initial,
    this.responseData,
    this.errorData,
    this.error,

  });

  @override
  List<Object?> get props => [
    status,
    responseData,
    errorData,
    error,

  ];

  TicTocState copyWith({
    TicTocStatus? status,
    ResponseData? responseData,
    ErrorData? errorData,
    String? error,
    String? message,
  }) {
    return TicTocState(
      status: status ?? this.status,
      responseData: responseData ?? this.responseData,
      errorData: errorData ?? this.errorData,
      error: error ?? this.error,

    );
  }
}



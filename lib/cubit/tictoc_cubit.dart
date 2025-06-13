
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictoc/repository/response_status.dart';
import 'package:tictoc/repository/tictoc_repository.dart';


part 'tictoc_state.dart';





class TicTocCubit extends Cubit<TicTocState> {
  final TicTocRepository repository;

  TicTocCubit(this.repository) : super(const TicTocState());


  Future<void> signUpCall(Map<String,dynamic> signUpDetails) async{
    emit(state.copyWith(status: TicTocStatus.signUpLoading));
    try{
      ResponseData responseData = await repository.signUp(signUpDetails);
      emit(state.copyWith(status: TicTocStatus.signUpSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.signUpError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.signUpError,error: e.toString(),errorData: null));
    }
  }
  Future<void> registerOTPVerifyCall(String otp,String token) async{
    emit(state.copyWith(status: TicTocStatus.registerVerifyOTPLoading));
    try{
      ResponseData responseData = await repository.registerOTPVerify(otp,token);
      emit(state.copyWith(status: TicTocStatus.registerVerifyOTPSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.registerVerifyOTPError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.registerVerifyOTPError,error: e.toString(),errorData: null));
    }
  }
  Future<void> signInCall(Map<String,dynamic> signInDetails) async {
    emit(state.copyWith(status: TicTocStatus.signInLoading));
    try {
      ResponseData response = await repository.signIn(signInDetails);
      emit(state.copyWith(status: TicTocStatus.signInSuccess, responseData: response));
    }
    on ErrorData catch (errorData) {
      emit(state.copyWith(status: TicTocStatus.signInError, errorData: errorData, error: null));
    }
    catch (e) {
      emit(state.copyWith(status: TicTocStatus.signInError, error: e.toString(), errorData: null));
    }
  }


  Future<void> guestLoginCall(Map<String,dynamic> signInDetails) async {
    emit(state.copyWith(status: TicTocStatus.guestLoginLoading));
    try {
      ResponseData response = await repository.guestLogin(signInDetails);
      emit(state.copyWith(status: TicTocStatus.guestLoginSuccess, responseData: response));
    }
    on ErrorData catch (errorData) {
      emit(state.copyWith(status: TicTocStatus.guestLoginError, errorData: errorData, error: null));
    }
    catch (e) {
      emit(state.copyWith(status: TicTocStatus.guestLoginError, error: e.toString(), errorData: null));
    }
  }

  Future<void> forgotPasswordCall(String emailOrPhone) async {
    emit(state.copyWith(status: TicTocStatus.forgotPasswordLoading));
    try {
      ResponseData response = await repository.forgotPassword(emailOrPhone);
      emit(state.copyWith(status: TicTocStatus.forgotPasswordSuccess, responseData: response));
    }
    on ErrorData catch (errorData) {
      emit(state.copyWith(status: TicTocStatus.forgotPasswordError, errorData: errorData, error: null));
    }
    catch (e) {
      emit(state.copyWith(status: TicTocStatus.forgotPasswordError, error: e.toString(), errorData: null));
    }
  }

  Future<void> resendVerifyOTPCall(String token) async{
    emit(state.copyWith(status: TicTocStatus.resendVerifyOTPLoading));
    try{
      ResponseData responseData = await repository.resendVerifyOtp(token);
      emit(state.copyWith(status: TicTocStatus.resendVerifyOTPSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.resendVerifyOTPError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.resendVerifyOTPError,error: e.toString(),errorData: null));
    }
  }

  Future<void> resetPasswordCall(String token,String newPassword,String confirmPassword) async{
    emit(state.copyWith(status: TicTocStatus.resetPasswordLoading));
    try{
      ResponseData responseData = await repository.resetPassword(token, newPassword, confirmPassword);
      emit(state.copyWith(status: TicTocStatus.resetPasswordSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.resetPasswordError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.resetPasswordError,error: e.toString(),errorData: null));
    }
  }
  Future<void> userInterestCall(Map<String,dynamic> interestList, String tmpToken) async{
    emit(state.copyWith(status: TicTocStatus.userInterestLoading));
    try{
      ResponseData responseData = await repository.userInterest(interestList,tmpToken);
      emit(state.copyWith(status: TicTocStatus.userInterestSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.userInterestError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.userInterestError,error: e.toString(),errorData: null));
    }
  }
  Future<void> getProfileCall() async{
    emit(state.copyWith(status: TicTocStatus.getProfileLoading));
    try{
      ResponseData responseData = await repository.getProfile();
      emit(state.copyWith(status: TicTocStatus.getProfileSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.getProfileError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.getProfileError,error: e.toString(),errorData: null));
    }
  }
  Future<void> updateProfileCall(File? image, String name,String bio, String username,) async{
    emit(state.copyWith(status: TicTocStatus.updateProfileLoading));
    try{
      ResponseData responseData = await repository.updateProfile(image, name, bio, username);
      emit(state.copyWith(status: TicTocStatus.updateProfileSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.updateProfileError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.updateProfileError,error: e.toString(),errorData: null));
    }
  }
  Future<void> suggestedAccountCall(String searchKey, String page, String limit) async{
   // emit(state.copyWith(status: TicTocStatus.suggestedAccountLoading));
    try{
      ResponseData responseData = await repository.suggestedAccount(searchKey, page,limit);
      emit(state.copyWith(status: TicTocStatus.suggestedAccountSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.suggestedAccountError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.suggestedAccountError,error: e.toString(),errorData: null));
    }
  }
  Future<void> followerListCall(String pageNumber, String limit) async{
  //  emit(state.copyWith(status: TicTocStatus. followerListLoading));
    try{
      ResponseData responseData = await repository.followerList(pageNumber,limit);
      emit(state.copyWith(status: TicTocStatus. followerListSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus. followerListError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.followerListError,error: e.toString(),errorData: null));
    }
  }

  Future<void> otherUserFollowerListCall(String userId, String pageNumber, String limit) async{
    //  emit(state.copyWith(status: TicTocStatus. followerListLoading));
    try{
      ResponseData responseData = await repository.otherUserFollowerList(userId, pageNumber, limit);
      emit(state.copyWith(status: TicTocStatus. followerListSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus. followerListError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.followerListError,error: e.toString(),errorData: null));
    }
  }

  Future<void> followUserCall(Map<String,dynamic> followUserMap) async{
    emit(state.copyWith(status: TicTocStatus.followUserLoading));
    try{
      ResponseData responseData = await repository.followUser(followUserMap);
      emit(state.copyWith(status: TicTocStatus.followUserSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.followUserError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.followUserError,error: e.toString(),errorData: null));
    }
  }

  Future<void> inOtherFollowingListFollowCall(Map<String,dynamic> followUserMap) async{
    emit(state.copyWith(status: TicTocStatus.inOtherFollowingListFollowUserLoading));
    try{
      ResponseData responseData = await repository.followUser(followUserMap);
      emit(state.copyWith(status: TicTocStatus.inOtherFollowingListFollowUserSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.inOtherFollowingListFollowUserError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.inOtherFollowingListFollowUserError,error: e.toString(),errorData: null));
    }
  }

  Future<void> unFollowUserCall(int otherUserID) async{
    emit(state.copyWith(status: TicTocStatus.unFollowUserLoading));
    try{
      ResponseData responseData = await repository.unFollowUser(otherUserID);
      emit(state.copyWith(status: TicTocStatus.unFollowUserSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.unFollowUserError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.unFollowUserError,error: e.toString(),errorData: null));
    }
  }

  Future<void> followingListCall(String pageNumber, String limit) async{
  //  emit(state.copyWith(status: TicTocStatus.followingListLoading));
    try{
      ResponseData responseData = await repository.followingList(pageNumber,limit);
      emit(state.copyWith(status: TicTocStatus.followingListSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.followingListError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.followingListError,error: e.toString(),errorData: null));
    }
  }

  Future<void> otherUserFollowingListCall(String otherUserId, String pageNumber, String limit) async{
    //  emit(state.copyWith(status: TicTocStatus.otherUserFollowingListLoading));
    try{
      ResponseData responseData = await repository.otherUserFollowingList(otherUserId, pageNumber, limit);
      emit(state.copyWith(status: TicTocStatus.otherUserFollowingListSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.otherUserFollowingListError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.otherUserFollowingListError,error: e.toString(),errorData: null));
    }
  }

  Future<void> forYouFeedCall(String page,String limit) async {
    emit(state.copyWith(status: TicTocStatus.forYouFeedLoading));
    try{
      ResponseData responseData = await repository.forYouFeed(page, limit);
      emit(state.copyWith(status: TicTocStatus.forYouFeedSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.forYouFeedError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.forYouFeedError,error: e.toString(),errorData: null));
    }
  }

  Future<void> uploadContentCall(File? image, String descr, List<dynamic> tags) async {
    emit(state.copyWith(status: TicTocStatus.uploadContentLoading));
    try{
      ResponseData responseData = await repository.updateContent(image, descr, tags);
      emit(state.copyWith(status: TicTocStatus.uploadContentSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.uploadContentError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.uploadContentError,error: e.toString(),errorData: null));
    }
  }

  Future<void> getUserContentCall(String pageNumber,String limit) async {
    emit(state.copyWith(status: TicTocStatus.getUserContentLoading));
    try{
      ResponseData responseData = await repository.getUserContent(pageNumber, limit);
      emit(state.copyWith(status: TicTocStatus.getUserContentSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.getUserContentError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.getUserContentError,error: e.toString(),errorData: null));
    }
  }

  Future<void> getOtherUserContentCall(String userId, String pageNumber,String limit) async {
    emit(state.copyWith(status: TicTocStatus.getOtherUserContentLoading));
    try{
      ResponseData responseData = await repository.getOtherUserContent(userId,pageNumber,limit);
      emit(state.copyWith(status: TicTocStatus.getOtherUserContentSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.getOtherUserContentError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.getOtherUserContentError,error: e.toString(),errorData: null));
    }
  }

  Future<void> deletePostCall(String contentId) async {
    emit(state.copyWith(status: TicTocStatus.deletePostLoading));
    try{
      ResponseData responseData = await repository.deletePost(contentId);
      emit(state.copyWith(status: TicTocStatus.deletePostSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.deletePostError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.deletePostError,error: e.toString(),errorData: null));
    }
  }

  Future<void> otherProfileCall(String userId) async {
    emit(state.copyWith(status: TicTocStatus.getOtherProfileLoading));
    try{
      ResponseData responseData = await repository.otherProfile(userId);
      emit(state.copyWith(status: TicTocStatus.getOtherProfileSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.getOtherProfileError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.getOtherProfileError,error: e.toString(),errorData: null));
    }
  }

  Future<void> exploreCall(String pageNumber,String limit) async {
  //  emit(state.copyWith(status: TicTocStatus.exploreLoading));
    try{
      ResponseData responseData = await repository.explore(pageNumber, limit);
      emit(state.copyWith(status: TicTocStatus.exploreSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.exploreError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.exploreError,error: e.toString(),errorData: null));
    }
  }

  Future<void> followingFeedCall(String pageNumber,String limit) async {
    //  emit(state.copyWith(status: TicTocStatus.followingFeedLoading));
    try{
      ResponseData responseData = await repository.followingFeed(pageNumber, limit);
      emit(state.copyWith(status: TicTocStatus.followingFeedSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.followingFeedError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.followingFeedError,error: e.toString(),errorData: null));
    }
  }

  Future<void> hitLikeFollowingReelsCall(Map<String, dynamic> hitLikeDetails) async {
    emit(state.copyWith(status: TicTocStatus.hitLikeFollowingReelsLoading));
    try{
      ResponseData responseData = await repository.hitLikeDetailsReels(hitLikeDetails);
      emit(state.copyWith(status: TicTocStatus.hitLikeFollowingReelsSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.hitLikeFollowingReelsError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.hitLikeFollowingReelsError,error: e.toString(),errorData: null));
    }
  }
  Future<void> hitLikeProfileCall(Map<String, dynamic> hitLikeDetails) async {
    emit(state.copyWith(status: TicTocStatus.hitLikeProfileLoading));
    try{
      ResponseData responseData = await repository.hitLikeDetailsReels(hitLikeDetails);
      emit(state.copyWith(status: TicTocStatus.hitLikeProfileSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.hitLikeProfileError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.hitLikeProfileError,error: e.toString(),errorData: null));
    }
  }
  Future<void> hitLikeOtherProfileCall(Map<String, dynamic> hitLikeDetails) async {
    emit(state.copyWith(status: TicTocStatus.hitLikeOtherProfileLoading));
    try{
      ResponseData responseData = await repository.hitLikeDetailsReels(hitLikeDetails);
      emit(state.copyWith(status: TicTocStatus.hitLikeOtherProfileSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.hitLikeOtherProfileError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.hitLikeOtherProfileError,error: e.toString(),errorData: null));
    }
  }
  Future<void> bookmarkFollowingCall(Map<String, dynamic> bookmarkDetails) async {
    emit(state.copyWith(status: TicTocStatus.bookmarkFollowingLoading));
    try{
      ResponseData responseData = await repository.bookmarkFollowing(bookmarkDetails);
      emit(state.copyWith(status: TicTocStatus.bookmarkFollowingSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.bookmarkFollowingError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.bookmarkFollowingError,error: e.toString(),errorData: null));
    }
  }

  Future<void> bookmarkProfileCall(Map<String, dynamic> bookmarkDetails) async {
    emit(state.copyWith(status: TicTocStatus.bookmarkProfileLoading));
    try{
      ResponseData responseData = await repository.bookmarkFollowing(bookmarkDetails);
      emit(state.copyWith(status: TicTocStatus.bookmarkProfileSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.bookmarkProfileError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.bookmarkProfileError,error: e.toString(),errorData: null));
    }
  }

  Future<void> bookmarkExploreCall(Map<String, dynamic> bookmarkDetails) async {
    emit(state.copyWith(status: TicTocStatus.bookmarkExploreLoading));
    try{
      ResponseData responseData = await repository.bookmarkFollowing(bookmarkDetails);
      emit(state.copyWith(status: TicTocStatus.bookmarkExploreSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.bookmarkExploreError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.bookmarkExploreError,error: e.toString(),errorData: null));
    }
  }

  Future<void> bookmarkOtherProfileCall(Map<String, dynamic> bookmarkDetails) async {
    emit(state.copyWith(status: TicTocStatus.bookmarkOtherProfileLoading));
    try{
      ResponseData responseData = await repository.bookmarkFollowing(bookmarkDetails);
      emit(state.copyWith(status: TicTocStatus.bookmarkOtherProfileSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.bookmarkOtherProfileError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.bookmarkOtherProfileError,error: e.toString(),errorData: null));
    }
  }

  Future<void> getBookmarkContentCall(String pageNumber,String limit) async {
    emit(state.copyWith(status: TicTocStatus.getBookmarkContentLoading));
    try{
      ResponseData responseData = await repository.getBookmarkContent(pageNumber, limit);
      emit(state.copyWith(status: TicTocStatus.getBookmarkContentSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.getBookmarkContentError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.getBookmarkContentError,error: e.toString(),errorData: null));
    }
  }
  Future<void> getOtherBookmarkContentCall(String userID,String pageNumber,String limit) async {
    emit(state.copyWith(status: TicTocStatus.getOtherBookmarkContentLoading));
    try{
      ResponseData responseData = await repository.getOtherBookmarkContent(userID,pageNumber,limit);
      emit(state.copyWith(status: TicTocStatus.getOtherBookmarkContentSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.getOtherBookmarkContentError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.getOtherBookmarkContentError,error: e.toString(),errorData: null));
    }
  }

  Future<void> sendCommentCall(Map<String, dynamic> commentDetails) async {
    emit(state.copyWith(status: TicTocStatus.sendCommentLoading));
    try{
      ResponseData responseData = await repository.sendComment(commentDetails);
      emit(state.copyWith(status: TicTocStatus.sendCommentSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.sendCommentError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.sendCommentError,error: e.toString(),errorData: null));
    }
  }

  Future<void> getCommentsCall(String contentId,String pageNumber,String limit) async {
  //  emit(state.copyWith(status: TicTocStatus.getCommentsLoading));
    try{
      ResponseData responseData = await repository.getComments(contentId,pageNumber, limit);
      emit(state.copyWith(status: TicTocStatus.getCommentsSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.getCommentsError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.getCommentsError,error: e.toString(),errorData: null));
    }
  }

  Future<void> changePasswordCall(Map<String, dynamic> passwordDetails) async {
      emit(state.copyWith(status: TicTocStatus.changePasswordLoading));
    try{
      ResponseData responseData = await repository.changePassword(passwordDetails);
      emit(state.copyWith(status: TicTocStatus.changePasswordSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.changePasswordError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.changePasswordError,error: e.toString(),errorData: null));
    }
  }

  Future<void> leaveReasonCall() async {
    emit(state.copyWith(status: TicTocStatus.leaveReasonLoading));
    try{
      ResponseData responseData = await repository.leaveReason();
      emit(state.copyWith(status: TicTocStatus.leaveReasonSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.leaveReasonError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.leaveReasonError,error: e.toString(),errorData: null));
    }
  }

  Future<void> guestLogoutCall(Map<String, dynamic> logoutDetails) async {
    emit(state.copyWith(status: TicTocStatus.guestLogoutLoading));
    try{
      ResponseData responseData = await repository.guestLogout(logoutDetails);
      emit(state.copyWith(status: TicTocStatus.guestLogoutSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: TicTocStatus.guestLogoutError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: TicTocStatus.guestLogoutError,error: e.toString(),errorData: null));
    }
  }


/*
  Future<void> getProfileCall() async {
    emit(state.copyWith(status: TicTocStatus.getProfileLoading));

    try {
      ResponseData responseData = await repository.getProfile();
      emit(state.copyWith(status: TicTocStatus.getProfileSuccess, responseData: responseData));
    }
    on ErrorData catch (errorData) {
      print('Error Message: ${errorData.message}');
      print('Error Status Code: ${errorData.code}');
      emit(state.copyWith(status: TicTocStatus.getProfileError, errorData: errorData, error: null));
    }
    catch (e) {
      print('Unhandled Error: $e');
      emit(state.copyWith(status: TicTocStatus.getProfileError, error: e.toString(), errorData: null));
    }
  }*/

/*  Future<void> registerOTPVerifyCall(String otp,String token) async{
    emit(state.copyWith(status: SpotsBallStatus.registerVerifyOTPLoading));
    try{
      ResponseData responseData = await repository.registerOTPVerify(otp,token);
      emit(state.copyWith(status: SpotsBallStatus.registerVerifyOTPSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: SpotsBallStatus.registerVerifyOTPError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: SpotsBallStatus.registerVerifyOTPError,error: e.toString(),errorData: null));
    }
  }







  Future<void> resendForgotPasswordCall(String emailOrPhone) async {
    emit(state.copyWith(status: SpotsBallStatus.resendForgotPasswordLoading));
    try {
      ResponseData response = await repository.forgotPassword(emailOrPhone);
      emit(state.copyWith(status: SpotsBallStatus.resendForgotPasswordSuccess, responseData: response));
    }
    on ErrorData catch (errorData) {
      emit(state.copyWith(status: SpotsBallStatus.resendForgotPasswordError, errorData: errorData, error: null));
    }
    catch (e) {
      emit(state.copyWith(status: SpotsBallStatus.resendForgotPasswordError, error: e.toString(), errorData: null));
    }
  }

  Future<void> forgotOtpVerifyCall(String otp,String token) async{
    emit(state.copyWith(status: SpotsBallStatus.forgotOtpVerifyLoading));
    try{
      ResponseData responseData = await repository.forgotOtpVerify(otp,token);
      emit(state.copyWith(status: SpotsBallStatus.forgotOtpVerifySuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: SpotsBallStatus.forgotOtpVerifyError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: SpotsBallStatus.forgotOtpVerifyError,error: e.toString(),errorData: null));
    }
  }




  Future<void> getProfileCall() async{
    emit(state.copyWith(status: SpotsBallStatus.getProfileLoading));
    try{
      ResponseData responseData = await repository.getProfile();
      emit(state.copyWith(status: SpotsBallStatus.getProfileSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: SpotsBallStatus.getProfileError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: SpotsBallStatus.getProfileError,error: e.toString(),errorData: null));
    }
  }*/



}

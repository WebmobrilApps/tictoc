import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tictoc/model/delete_post_response.dart';
import 'package:tictoc/model/explore_response.dart';
import 'package:tictoc/model/follower_list_response.dart';
import 'package:tictoc/model/following_feed_response.dart';
import 'package:tictoc/model/following_list_response.dart';
import 'package:tictoc/model/for_you_feed_response.dart';
import 'package:tictoc/model/forgot_password_response.dart';
import 'package:tictoc/model/get_comments_response.dart';
import 'package:tictoc/model/get_other_profile_response.dart';
import 'package:tictoc/model/get_other_user_content_response.dart';
import 'package:tictoc/model/get_profile_response.dart';
import 'package:tictoc/model/get_user_content_response.dart';
import 'package:tictoc/model/guest_login_response.dart';
import 'package:tictoc/model/leave_reason_response.dart';
import 'package:tictoc/model/other_user_following_response.dart';
import 'package:tictoc/model/resend_verify_otp_response.dart';
import 'package:tictoc/model/sign_in_response.dart';
import 'package:tictoc/model/sign_up_response.dart';
import 'package:tictoc/model/suggested_account_response.dart';
import 'package:tictoc/model/update_profile_response.dart';
import 'package:tictoc/model/upload_content_response.dart';
import 'package:tictoc/model/verify_otp_response.dart';
import 'package:tictoc/repository/api_service.dart';
import 'package:tictoc/repository/response_status.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/shared_preference.dart';

class TicTocRepository {
  String? token;

  TicTocRepository() {
    token = PreferenceManager.getStringValue(key: TOKEN);
  }

  String getToken() {
    //  print('token321:$token');
    return token = PreferenceManager.getStringValue(key: TOKEN) ?? '';
  }

  // Sign up
  Future<ResponseData> signUp(Map<String, dynamic> signUpDetails) async {
    try {
      final response = await ApiService().sendRequest.post(
        "/user/register",
        data: signUpDetails,
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: SignUpResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      throw ErrorData(
        //  message: e.response!.data['message'], code: e.response!.statusCode);
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> registerOTPVerify(String otp, String token) async {
    print('otp:$otp');
    print('token:$token');
    try {
      final response = await ApiService(token: token).sendRequest.post(
        "/user/verify-otp",
        data: {"otp": otp},
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: VerifyOtpResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> signIn(Map<String, dynamic> signInDetails) async {
    try {
      final response = await ApiService().sendRequest.post(
        "/user/login",
        data: signInDetails,
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: SignInResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> guestLogin(Map<String, dynamic> signInDetails) async {
    try {
      final response = await ApiService().sendRequest.post(
        "/guest/login",
        data: signInDetails,
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: GuestLoginResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> forgotPassword(String emailOrPhone) async {
    try {
      final response = await ApiService().sendRequest.post(
        "/user/forget-password",
        data: {"username": emailOrPhone},
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: ForgotPasswordResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }
  // Resend Verify Otp
  Future<ResponseData> resendVerifyOtp(String token) async {
    try {
      final response = await ApiService(token: token).sendRequest.get("/user/resend-otp");
      return ResponseData(
          statusCode: response.statusCode,
          response: ResendVerifyOtpResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }
  Future<ResponseData> resetPassword(
      String tmpToken, String newPassword, String confirmPassword) async {
    print('token:resetPassword:$token');
    try {
      final response = await ApiService(token: tmpToken).sendRequest.post(
        "/user/reset-password",
        data: {
          "password": newPassword,
          "confirm_password": confirmPassword,
        },
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: response.data["msg"],
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> userInterest(Map<String,dynamic> interestList, String tmpToken) async {
    try {
      final response = await ApiService(token:tmpToken).sendRequest.post(
        "/user/user-interest",
        data: interestList, // Sending list as JSON
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: response.data["msg"],
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }


  Future<ResponseData> getProfile() async {
    print('getToken():${getToken()}');
    try {
      final response = await ApiService(token: getToken()).sendRequest.get("/user/get-profile");
      return ResponseData(
          statusCode: response.statusCode,
          response: GetProfileResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> updateProfile(File? image, String name,String bio, String username ) async {
    print('imageAPI:$image');
    print('image.path:${image?.path}');
    String fileName = "";
    if (image != null) {
      fileName = image.path.split('/').last;
    } else {
      fileName = "";
    }
    FormData formData;
    if (image != null) {
      print('inside');
      formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(image.path, filename: fileName),
        "name": name,
        "bio": bio,
        "username": username,

      });
    } else {
      print('outside');
      formData = FormData.fromMap({
        "name": name,
        "username": username,
        "bio": bio,
      });

    }
    print('formData:$formData');
    try {
      final response = await ApiService(token: getToken()).sendRequest.post(
        "/user/update-profile",
        data: formData,
      );
      return ResponseData(
        statusCode: response.statusCode,
      //  response: response.data["msg"],
          response: UpdateProfileResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> suggestedAccount(String searchKey,String page, String limit) async {
    try {
      // Check if searchKey is empty and construct the full URL accordingly

      String suggestedURL = searchKey.isNotEmpty
          ? "/user/search-suggested?search=$searchKey&page=$page&limit=$limit"
          : "/user/search-suggested?&page=$page&limit=$limit";

      final response = await ApiService(token: getToken()).sendRequest.get(suggestedURL);
      return ResponseData(
          statusCode: response.statusCode,
          response: SuggestedAccountResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> followerList(String pageNumber, String limit) async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.get('/user/get-follower?page=$pageNumber&limit=$limit');
      return ResponseData(
          statusCode: response.statusCode,
          response: FollowerListResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> otherUserFollowerList(String userId,String pageNumber, String limit) async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.get('/user/other-user-follower?userId=$userId&page=$pageNumber&limit=$limit');
      return ResponseData(
          statusCode: response.statusCode,
          response: FollowerListResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }


  Future<ResponseData> followUser(Map<String, dynamic> followUserMap) async {
    print('followUserBody:$followUserMap');
    try {
      final response = await ApiService(token: getToken()).sendRequest.post(
        "/user/follow-user",
        data: followUserMap,
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: response.data["msg"],
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> unFollowUser(int otherUserID) async {
    print('otherUserID:$otherUserID');
    try {
      final response = await ApiService(token: getToken()).sendRequest.delete(
        "/user/unfollow-user?userid=$otherUserID",
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: response.data["msg"],
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> followingList(String pageNumber, String limit) async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.get('/user/get-following?page=$pageNumber&limit=$limit');
      return ResponseData(
          statusCode: response.statusCode,
          response: FollowingListResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> otherUserFollowingList(String otherUserId, String pageNumber, String limit) async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.get('/user/other-user-following?userId=$otherUserId&page=$pageNumber&limit=$limit');
      return ResponseData(
          statusCode: response.statusCode,
          response: OtherUserFollowingListResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> forYouFeed(String page,String limit) async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.get('/user/for-you-feed?page=$page&limit=$limit');
      return ResponseData(
          statusCode: response.statusCode,
          response: ForYouFeedResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> updateContent(File? image, String descr, List<dynamic> tags) async {
    print('jsonEncode(tags):${jsonEncode(tags)}');
    print('imageAPI:$image');
    print('image.path:${image?.path}');
    String fileName = "";
    if (image != null) {
      fileName = image.path.split('/').last;
    } else {
      fileName = "";
    }
    FormData formData;

    if (image != null) {
      formData = FormData.fromMap({
      "content": await MultipartFile.fromFile(image.path, filename: fileName,),
        "descr": descr,
      //  "tags": '["#dance","#baby","#vijay Song"]',
        "tags": jsonEncode(tags),
      });
      print('formData:$formData');
    } else {
      formData = FormData.fromMap({
        "descr": descr,
        "tags": jsonEncode(tags),
      });
      print('formData:$formData');
    }
      print('formData:$formData');

    try {
      final response = await ApiService(token: getToken()).sendRequest.post(
        "/user/upload-content",
        data: formData,
      );
      return ResponseData(
        statusCode: response.statusCode,
      //  response: response.data["msg"],
          response: UploadContentResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> getUserContent(String pageNumber,String limit) async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.get('/user/get-user-content?page=$pageNumber&limit=$limit');
      return ResponseData(
          statusCode: response.statusCode,
          response: GetUserContentResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> getOtherUserContent(String userId, String pageNumber,String limit) async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.get('/user/other-user-content?userId=$userId&page=$pageNumber&limit=$limit');
      return ResponseData(
          statusCode: response.statusCode,
          response: GetOtherUserContentResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> deletePost(String contentId) async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.delete('/user/delete-content?content_id=$contentId');
      return ResponseData(
          statusCode: response.statusCode,
          response: DeletePostResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> otherProfile(String userId) async {
    print('getToken():${getToken()}');
    try {
      final response = await ApiService(token: getToken()).sendRequest.get("/user/get-other-user-profile?userId=$userId");
      return ResponseData(
          statusCode: response.statusCode,
          response: GetOtherProfileResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> explore(String pageNumber,String limit) async {
    print('getToken():${getToken()}');
    try {
      final response = await ApiService(token: getToken()).sendRequest.get("/user/explore-feed?page=$pageNumber&limit=$limit");
      return ResponseData(
          statusCode: response.statusCode,
          response: ExploreResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> followingFeed(String pageNumber,String limit) async {
    print('getToken():${getToken()}');
    try {
      final response = await ApiService(token: getToken()).sendRequest.get("/user/following-feed?page=$pageNumber&limit=$limit");
      return ResponseData(
          statusCode: response.statusCode,
          response: FollowingFeedResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> hitLikeDetailsReels(Map<String, dynamic> hitLikeDetails) async {
    print('hitLikeDetails:$hitLikeDetails');
    try {
      final response = await ApiService(token: getToken()).sendRequest.post(
        "/user/like-content",
        data: hitLikeDetails,
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: response.data["msg"],
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> bookmarkFollowing(Map<String, dynamic> bookmarkDetails) async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.post("/user/save-content",
        data: bookmarkDetails,
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: response.data["msg"],
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> getBookmarkContent(String pageNumber,String limit) async {
    print('getToken():${getToken()}');
    try {
      final response = await ApiService(token: getToken()).sendRequest.get("/user/get-saved-content?page=$pageNumber&limit=$limit");
      return ResponseData(
          statusCode: response.statusCode,
          response: GetUserContentResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> getOtherBookmarkContent(String userID,String pageNumber,String limit) async {
    print('getToken():${getToken()}');
    try {
      final response = await ApiService(token: getToken()).sendRequest.get("/user/other-saved-content?userId=$userID&page=$pageNumber&limit=$limit");
      return ResponseData(
          statusCode: response.statusCode,
          response: GetOtherUserContentResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }


  Future<ResponseData> sendComment(Map<String, dynamic> commentDetails) async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.post("/user/comment-content",
        data: commentDetails,
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: response.data["msg"],
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> getComments(String contentId,String pageNumber,String limit) async {
    print('limit():$limit');
    try {
      final response = await ApiService(token: getToken()).sendRequest.get("/user/get-content-comment?content_id=$contentId&page=$pageNumber&limit=$limit");
      return ResponseData(
          statusCode: response.statusCode,
          response: GetCommentsResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }


  Future<ResponseData> changePassword(Map<String, dynamic> passwordDetails) async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.post("/user/change-password",
        data: passwordDetails,
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: response.data["msg"],
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'],
          code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }
  Future<ResponseData> leaveReason() async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.get("/user/leave-reason");
      return ResponseData(
          statusCode: response.statusCode,
          response: LeaveReasonResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }


  Future<ResponseData> saveLeaveReason(Map<String, dynamic> logoutDetails) async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.post("/user/save-leave-reason",
        data: logoutDetails,
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: response.data["msg"],
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'],
          code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> guestLogout() async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.post("/guest/logout");
      return ResponseData(
        statusCode: response.statusCode,
        response: response.data["msg"],
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'],
          code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }


/* Future<ResponseData> registerOTPVerify(String otp, String token) async {
    try {
      final response = await ApiService(token: token).sendRequest.post(
        "/verify-user",
        data: {"otp": otp},
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: VerifyOtpResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }



  // Sign In




  Future<ResponseData> forgotOtpVerify(String otp, String token) async {
    try {
      final response = await ApiService(token: token).sendRequest.post(
        "/submit-otp",
        data: {"otp": otp},
      );
      return ResponseData(
        statusCode: response.statusCode,
        //    response: response.data["message"],
        response: SubmitOtpResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> resetPassword(
      String token, String newPassword, String confirmPassword) async {
    try {
      final response = await ApiService(token: token).sendRequest.post(
        "/reset-password",
        data: {
          "new_password": newPassword,
          "confirm_password": confirmPassword,
        },
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: response.data["message"],
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }*/


}

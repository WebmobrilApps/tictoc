import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tictoc/model/forgot_password_response.dart';
import 'package:tictoc/model/get_profile_response.dart';
import 'package:tictoc/model/guest_login_response.dart';
import 'package:tictoc/model/resend_verify_otp_response.dart';
import 'package:tictoc/model/sign_in_response.dart';
import 'package:tictoc/model/sign_up_response.dart';
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

  Future<ResponseData> updateProfile(File? image, String name, String link,String bio ) async {
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
        "image": await MultipartFile.fromFile(image.path, filename: fileName),
        "name": name,
        "link": link,
        "bio": bio,
      });
      print('formData:$formData');
    } else {
      formData = FormData.fromMap({
        "name": name,
        "link": link,
        "bio": bio,
      });
      print('formData:$formData');
    }
    try {
      final response = await ApiService(token: getToken()).sendRequest.post(
        "/user/update-profile",
        data: formData,
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

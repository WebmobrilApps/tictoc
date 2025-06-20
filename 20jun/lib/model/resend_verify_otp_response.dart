class ResendVerifyOtpResponse {
  final int? resCode;
  final bool? success;
  final String? message;
  final Data? data;

  ResendVerifyOtpResponse({
    this.resCode,
    this.success,
    this.message,
    this.data,
  });

  ResendVerifyOtpResponse.fromJson(Map<String, dynamic> json)
      : resCode = json['resCode'] as int?,
        success = json['success'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'resCode' : resCode,
    'success' : success,
    'message' : message,
    'data' : data?.toJson()
  };
}

class Data {
  final int? otp;

  Data({
    this.otp,
  });

  Data.fromJson(Map<String, dynamic> json)
      : otp = json['otp'] as int?;

  Map<String, dynamic> toJson() => {
    'otp' : otp
  };
}
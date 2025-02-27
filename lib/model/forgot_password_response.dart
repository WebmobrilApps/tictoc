class ForgotPasswordResponse {
  final int? resCode;
  final bool? success;
  final String? msg;
  final Data? data;

  ForgotPasswordResponse({
    this.resCode,
    this.success,
    this.msg,
    this.data,
  });

  ForgotPasswordResponse.fromJson(Map<String, dynamic> json)
      : resCode = json['resCode'] as int?,
        success = json['success'] as bool?,
        msg = json['msg'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'resCode' : resCode,
    'success' : success,
    'msg' : msg,
    'data' : data?.toJson()
  };
}

class Data {
  final int? otp;
  final String? tempToken;

  Data({
    this.otp,
    this.tempToken,
  });

  Data.fromJson(Map<String, dynamic> json)
      : otp = json['otp'] as int?,
        tempToken = json['tempToken'] as String?;

  Map<String, dynamic> toJson() => {
    'otp' : otp,
    'tempToken' : tempToken
  };
}
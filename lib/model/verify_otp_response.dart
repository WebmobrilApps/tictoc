class VerifyOtpResponse {
  final int? resCode;
  final bool? success;
  final String? msg;
  final Data? data;

  VerifyOtpResponse({
    this.resCode,
    this.success,
    this.msg,
    this.data,
  });

  VerifyOtpResponse.fromJson(Map<String, dynamic> json)
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
  final String? token;

  Data({
    this.token,
  });

  Data.fromJson(Map<String, dynamic> json)
      : token = json['token'] as String?;


  Map<String, dynamic> toJson() => {
    'token' : token
  };
}
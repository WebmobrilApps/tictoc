class UserInterestResponse {
  final int? resCode;
  final bool? success;
  final String? msg;
  final List<dynamic>? data;

  UserInterestResponse({
    this.resCode,
    this.success,
    this.msg,
    this.data,
  });

  UserInterestResponse.fromJson(Map<String, dynamic> json)
      : resCode = json['resCode'] as int?,
        success = json['success'] as bool?,
        msg = json['msg'] as String?,
        data = json['data'] as List?;

  Map<String, dynamic> toJson() => {
    'resCode' : resCode,
    'success' : success,
    'msg' : msg,
    'data' : data
  };
}
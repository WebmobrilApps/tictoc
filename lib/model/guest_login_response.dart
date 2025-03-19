class GuestLoginResponse {
  final int? resCode;
  final bool? success;
  final String? msg;
  final Data? data;
  final String? token;
  final bool? interest;

  GuestLoginResponse({
    this.resCode,
    this.success,
    this.msg,
    this.data,
    this.token,
    this.interest,
  });

  GuestLoginResponse.fromJson(Map<String, dynamic> json)
    : resCode = json['resCode'] as int?,
      success = json['success'] as bool?,
      msg = json['msg'] as String?,
      data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null,
      token = json['token'] as String?,
      interest = json['interest'] as bool?;

  Map<String, dynamic> toJson() => {
    'resCode' : resCode,
    'success' : success,
    'msg' : msg,
    'data' : data?.toJson(),
    'token' : token,
    'interest' : interest
  };
}

class Data {
  final int? pkGuest;
  final String? deviceId;
  final int? status;
  final dynamic fcmToken;
  final String? createdDate;
  final String? updatedDate;
  final String? type;

  Data({
    this.pkGuest,
    this.deviceId,
    this.status,
    this.fcmToken,
    this.createdDate,
    this.updatedDate,
    this.type,
  });

  Data.fromJson(Map<String, dynamic> json)
    : pkGuest = json['pk_guest'] as int?,
      deviceId = json['deviceId'] as String?,
      status = json['status'] as int?,
      fcmToken = json['fcmToken'],
      createdDate = json['createdDate'] as String?,
      updatedDate = json['updatedDate'] as String?,
      type = json['type'] as String?;

  Map<String, dynamic> toJson() => {
    'pk_guest' : pkGuest,
    'deviceId' : deviceId,
    'status' : status,
    'fcmToken' : fcmToken,
    'createdDate' : createdDate,
    'updatedDate' : updatedDate,
    'type' : type
  };
}
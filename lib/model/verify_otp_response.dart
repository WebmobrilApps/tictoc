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
  final User? user;
  final String? token;

  Data({
    this.user,
    this.token,
  });

  Data.fromJson(Map<String, dynamic> json)
    : user = (json['user'] as Map<String,dynamic>?) != null ? User.fromJson(json['user'] as Map<String,dynamic>) : null,
      token = json['token'] as String?;

  Map<String, dynamic> toJson() => {
    'user' : user?.toJson(),
    'token' : token
  };
}

class User {
  final int? pkUser;
  final String? username;
  final String? email;
  final String? phone;
  final dynamic profilePic;
  final int? isVerify;

  User({
    this.pkUser,
    this.username,
    this.email,
    this.phone,
    this.profilePic,
    this.isVerify,
  });

  User.fromJson(Map<String, dynamic> json)
    : pkUser = json['pk_user'] as int?,
      username = json['username'] as String?,
      email = json['email'] as String?,
      phone = json['phone'] as String?,
      profilePic = json['profile_pic'],
      isVerify = json['isVerify'] as int?;

  Map<String, dynamic> toJson() => {
    'pk_user' : pkUser,
    'username' : username,
    'email' : email,
    'phone' : phone,
    'profile_pic' : profilePic,
    'isVerify' : isVerify
  };
}
class SignInResponse {
  final int? resCode;
  final bool? success;
  final String? msg;
  final Data? data;

  SignInResponse({
    this.resCode,
    this.success,
    this.msg,
    this.data,
  });

  SignInResponse.fromJson(Map<String, dynamic> json)
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
  final int? otp;
  final String? tempToken;
  final bool? interest;

  Data({
    this.user,
    this.token,
    this.otp,
    this.tempToken,
    this.interest,
  });

  Data.fromJson(Map<String, dynamic> json)
      : user = (json['user'] as Map<String,dynamic>?) != null ? User.fromJson(json['user'] as Map<String,dynamic>) : null,
        token = json['token'] as String?,
        otp = json['otp'] as int?,
        tempToken = json['tempToken'] as String?,
        interest = json['interest'] as bool?;

  Map<String, dynamic> toJson() => {
    'user' : user?.toJson(),
    'token' : token,
    'otp' : otp,
    'tempToken' : tempToken,
    'interest' : interest
  };
}

class User {
  final int? pkUser;
  final String? name;
  final int? guest;
  final String? username;
  final String? tictocid;
  final dynamic link;
  final dynamic bio;
  final dynamic profilePic;
  final String? countryCode;
  final String? email;
  final String? phone;
  final String? password;
  final String? status;
  final int? isVerify;
  final dynamic fcmToken;
  final String? createdDate;
  final String? updatedDate;
  final String? firebaseId;

  User({
    this.pkUser,
    this.name,
    this.guest,
    this.username,
    this.tictocid,
    this.link,
    this.bio,
    this.profilePic,
    this.countryCode,
    this.email,
    this.phone,
    this.password,
    this.status,
    this.isVerify,
    this.fcmToken,
    this.createdDate,
    this.updatedDate,
    this.firebaseId,
  });

  User.fromJson(Map<String, dynamic> json)
    : pkUser = json['pk_user'] as int?,
      name = json['name'] as String?,
      guest = json['guest'] as int?,
      username = json['username'] as String?,
      tictocid = json['tictocid'] as String?,
      link = json['link'],
      bio = json['bio'],
      profilePic = json['profile_pic'],
      countryCode = json['countryCode'] as String?,
      email = json['email'] as String?,
      phone = json['phone'] as String?,
      password = json['password'] as String?,
      status = json['status'] as String?,
      isVerify = json['isVerify'] as int?,
      fcmToken = json['fcmToken'],
      createdDate = json['createdDate'] as String?,
      updatedDate = json['updatedDate'] as String?,
      firebaseId = json['firebase_id'] as String?;

  Map<String, dynamic> toJson() => {
    'pk_user' : pkUser,
    'name' : name,
    'guest' : guest,
    'username' : username,
    'tictocid' : tictocid,
    'link' : link,
    'bio' : bio,
    'profile_pic' : profilePic,
    'countryCode' : countryCode,
    'email' : email,
    'phone' : phone,
    'password' : password,
    'status' : status,
    'isVerify' : isVerify,
    'fcmToken' : fcmToken,
    'createdDate' : createdDate,
    'updatedDate' : updatedDate,
    'firebase_id' : firebaseId
  };
}
class GetOtherProfileResponse {
  final int? resCode;
  final bool? success;
  final String? msg;
  final Data? data;

  GetOtherProfileResponse({
    this.resCode,
    this.success,
    this.msg,
    this.data,
  });

  GetOtherProfileResponse.fromJson(Map<String, dynamic> json)
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
  final int? pkUser;
  final String? name;
  final int? guest;
  final String? username;
  final String? tictocid;
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
  final int? followers;
  final int? following;
  final int? likes;
  int? isFollowing;
  final int? isBlockedByYou;
  final int? hasBlockedYou;

  Data({
    this.pkUser,
    this.name,
    this.guest,
    this.username,
    this.tictocid,
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
    this.followers,
    this.following,
    this.likes,
    this.isFollowing,
    this.isBlockedByYou,
    this.hasBlockedYou,
  });

  Data.fromJson(Map<String, dynamic> json)
    : pkUser = json['pk_user'] as int?,
      name = json['name'] as String?,
      guest = json['guest'] as int?,
      username = json['username'] as String?,
      tictocid = json['tictocid'] as String?,
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
      followers = json['followers'] as int?,
      following = json['following'] as int?,
      likes = json['likes'] as int?,
      isFollowing = json['isFollowing'] as int?,
      isBlockedByYou = json['isBlockedByYou'] as int?,
      hasBlockedYou = json['hasBlockedYou'] as int?;

  Map<String, dynamic> toJson() => {
    'pk_user' : pkUser,
    'name' : name,
    'guest' : guest,
    'username' : username,
    'tictocid' : tictocid,
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
    'followers' : followers,
    'following' : following,
    'likes' : likes,
    'isFollowing' : isFollowing,
    'isBlockedByYou' : isBlockedByYou,
    'hasBlockedYou' : hasBlockedYou
  };
}
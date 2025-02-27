class GetProfileResponse {
  final int? resCode;
  final bool? success;
  final String? msg;
  final Data? data;

  GetProfileResponse({
    this.resCode,
    this.success,
    this.msg,
    this.data,
  });

  GetProfileResponse.fromJson(Map<String, dynamic> json)
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
  String? name;
  final int? guest;
  final String? username;
  final String? tictocid;
  final List<Link>? link;
  final String? bio;
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

  Data({
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
  });

  Data.fromJson(Map<String, dynamic> json)
      : pkUser = json['pk_user'] as int?,
        name = json['name'] as String?,
        guest = json['guest'] as int?,
        username = json['username'] as String?,
        tictocid = json['tictocid'] as String?,
        link = (json['link'] as List?)?.map((dynamic e) => Link.fromJson(e as Map<String,dynamic>)).toList(),
        bio = json['bio'] as String?,
        profilePic = json['profile_pic'],
        countryCode = json['countryCode'] as String?,
        email = json['email'] as String?,
        phone = json['phone'] as String?,
        password = json['password'] as String?,
        status = json['status'] as String?,
        isVerify = json['isVerify'] as int?,
        fcmToken = json['fcmToken'],
        createdDate = json['createdDate'] as String?,
        updatedDate = json['updatedDate'] as String?;

  Map<String, dynamic> toJson() => {
    'pk_user' : pkUser,
    'name' : name,
    'guest' : guest,
    'username' : username,
    'tictocid' : tictocid,
    'link' : link?.map((e) => e.toJson()).toList(),
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
    'updatedDate' : updatedDate
  };
}

class Link {
  final String? type;
  final String? link;

  Link({
    this.type,
    this.link,
  });

  Link.fromJson(Map<String, dynamic> json)
      : type = json['type'] as String?,
        link = json['link'] as String?;

  Map<String, dynamic> toJson() => {
    'type' : type,
    'link' : link
  };
}
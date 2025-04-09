class OtherUserFollowersResponse {
  final int? resCode;
  final bool? success;
  final String? msg;
  final List<Data>? data;

  OtherUserFollowersResponse({
    this.resCode,
    this.success,
    this.msg,
    this.data,
  });

  OtherUserFollowersResponse.fromJson(Map<String, dynamic> json)
      : resCode = json['resCode'] as int?,
        success = json['success'] as bool?,
        msg = json['msg'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'resCode' : resCode,
    'success' : success,
    'msg' : msg,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final int? userId;
  final String? username;
  final String? profilePic;
  final String? name;
  final int? isFollowing;

  Data({
    this.userId,
    this.username,
    this.profilePic,
    this.name,
    this.isFollowing,
  });

  Data.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as int?,
        username = json['username'] as String?,
        profilePic = json['profile_pic'] as String?,
        name = json['name'] as String?,
        isFollowing = json['isFollowing'] as int?;

  Map<String, dynamic> toJson() => {
    'userId' : userId,
    'username' : username,
    'profile_pic' : profilePic,
    'name' : name,
    'isFollowing' : isFollowing
  };
}
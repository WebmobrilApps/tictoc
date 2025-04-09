class FollowerListResponse {
  final int? resCode;
  final bool? success;
  final String? msg;
  final List<Data>? data;

  FollowerListResponse({
    this.resCode,
    this.success,
    this.msg,
    this.data,
  });

  FollowerListResponse.fromJson(Map<String, dynamic> json)
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
  final String? name;
  final String? profilePic;
  final int? followerId;
   int? isFollowing;

  Data({
    this.userId,
    this.username,
    this.name,
    this.profilePic,
    this.followerId,
    this.isFollowing,
  });

  Data.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as int?,
        username = json['username'] as String?,
        name = json['name'] as String?,
        profilePic = json['profile_pic'] as String?,
        followerId = json['follower_id'] as int?,
        isFollowing = json['isFollowing'] as int?;

  Map<String, dynamic> toJson() => {
    'userId' : userId,
    'username' : username,
    'name' : name,
    'profile_pic' : profilePic,
    'follower_id' : followerId,
    'isFollowing' : isFollowing
  };
}
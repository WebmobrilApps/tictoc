class OtherUserFollowingListResponse {
  final int? resCode;
  final bool? success;
  final String? msg;
  List<Data>? data;
  final int? total;

  OtherUserFollowingListResponse({
    this.resCode,
    this.success,
    this.msg,
    this.data,
    this.total,
  });

  OtherUserFollowingListResponse.fromJson(Map<String, dynamic> json)
      : resCode = json['resCode'] as int?,
        success = json['success'] as bool?,
        msg = json['msg'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList(),
        total = json['total'] as int?;

  Map<String, dynamic> toJson() => {
    'resCode' : resCode,
    'success' : success,
    'msg' : msg,
    'data' : data?.map((e) => e.toJson()).toList(),
    'total' : total
  };
}

class Data {
  final int? userId;
  final String? username;
  final dynamic profilePic;
  final String? name;
  int? isFollowing;

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
        profilePic = json['profile_pic'],
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
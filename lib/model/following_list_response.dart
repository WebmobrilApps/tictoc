class FollowingListResponse {
  final int? resCode;
  final bool? success;
  final String? msg;
  List<Data>? data;
  final int? total;

  FollowingListResponse({
    this.resCode,
    this.success,
    this.msg,
    this.data,
    this.total,
  });

  FollowingListResponse.fromJson(Map<String, dynamic> json)
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
  final int? pkUser;
  final String? name;
  final String? username;
  final String? profilePic;

  Data({
    this.pkUser,
    this.name,
    this.username,
    this.profilePic,
  });

  Data.fromJson(Map<String, dynamic> json)
      : pkUser = json['pk_user'] as int?,
        name = json['name'] as String?,
        username = json['username'] as String?,
        profilePic = json['profile_pic'] as String?;

  Map<String, dynamic> toJson() => {
    'pk_user' : pkUser,
    'name' : name,
    'username' : username,
    'profile_pic' : profilePic
  };
}
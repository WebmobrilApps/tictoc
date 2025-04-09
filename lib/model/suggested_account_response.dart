class SuggestedAccountResponse {
  final int? resCode;
  final bool? success;
  final String? msg;
  final List<Data>? data;

  SuggestedAccountResponse({
    this.resCode,
    this.success,
    this.msg,
    this.data,
  });

  SuggestedAccountResponse.fromJson(Map<String, dynamic> json)
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
  final int? pkUser;
  final String? name;
  final String? username;
  final String? profilePic;
  int? followingStatus;

  Data({
    this.pkUser,
    this.name,
    this.username,
    this.profilePic,
    this.followingStatus,
  });

  Data.fromJson(Map<String, dynamic> json)
    : pkUser = json['pk_user'] as int?,
      name = json['name'] as String?,
      username = json['username'] as String?,
      profilePic = json['profile_pic'] as String?,
      followingStatus = json['following_status'] as int?;

  Map<String, dynamic> toJson() => {
    'pk_user' : pkUser,
    'name' : name,
    'username' : username,
    'profile_pic' : profilePic,
    'following_status' : followingStatus
  };
}
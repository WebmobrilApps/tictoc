class GetCommentsResponse {
  final int? resCode;
  final bool? success;
  final String? msg;
  List<Data>? data;
  final int? total;

  GetCommentsResponse({
    this.resCode,
    this.success,
    this.msg,
    this.data,
    this.total,
  });

  GetCommentsResponse.fromJson(Map<String, dynamic> json)
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
  final int? pkComment;
  final int? userId;
  final int? videoId;
  final String? comment;
  final String? createdAt;
  final String? username;
  final dynamic profilePic;
  final String? name;

  Data({
    this.pkComment,
    this.userId,
    this.videoId,
    this.comment,
    this.createdAt,
    this.username,
    this.profilePic,
    this.name,
  });

  Data.fromJson(Map<String, dynamic> json)
    : pkComment = json['pk_comment'] as int?,
      userId = json['user_id'] as int?,
      videoId = json['video_id'] as int?,
      comment = json['comment'] as String?,
      createdAt = json['created_at'] as String?,
      username = json['username'] as String?,
      profilePic = json['profile_pic'],
      name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'pk_comment' : pkComment,
    'user_id' : userId,
    'video_id' : videoId,
    'comment' : comment,
    'created_at' : createdAt,
    'username' : username,
    'profile_pic' : profilePic,
    'name' : name
  };
}
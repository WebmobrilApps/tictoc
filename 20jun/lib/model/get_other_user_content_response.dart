class GetOtherUserContentResponse {
  final int? resCode;
  final bool? success;
  final String? msg;
  List<Data>? data;
  final int? total;

  GetOtherUserContentResponse({
    this.resCode,
    this.success,
    this.msg,
    this.data,
    this.total,
  });

  GetOtherUserContentResponse.fromJson(Map<String, dynamic> json)
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
  final int? videoId;
  final int? uploaderId;
  final String? descr;
  final String? url;
  final String? createdAt;
  final String? username;
  final String? name;
  final String? profilePic;
  int? likeCount;
  int? commentCount;
  int? saveCount;
  int? isLiked;
  int? isSaved;
  final List<String>? tags;

  Data({
    this.videoId,
    this.uploaderId,
    this.descr,
    this.url,
    this.createdAt,
    this.username,
    this.name,
    this.profilePic,
    this.likeCount,
    this.commentCount,
    this.saveCount,
    this.isLiked,
    this.isSaved,
    this.tags,
  });

  Data.fromJson(Map<String, dynamic> json)
    : videoId = json['videoId'] as int?,
      uploaderId = json['uploaderId'] as int?,
      descr = json['descr'] as String?,
      url = json['url'] as String?,
      createdAt = json['created_at'] as String?,
      username = json['username'] as String?,
      name = json['name'] as String?,
      profilePic = json['profile_pic'] as String?,
      likeCount = json['like_count'] as int?,
      commentCount = json['comment_count'] as int?,
      saveCount = json['save_count'] as int?,
      isLiked = json['is_liked'] as int?,
      isSaved = json['is_saved'] as int?,
      tags = (json['tags'] as List?)?.map((dynamic e) => e as String).toList();

  Map<String, dynamic> toJson() => {
    'videoId' : videoId,
    'uploaderId' : uploaderId,
    'descr' : descr,
    'url' : url,
    'created_at' : createdAt,
    'username' : username,
    'name' : name,
    'profile_pic' : profilePic,
    'like_count' : likeCount,
    'comment_count' : commentCount,
    'save_count' : saveCount,
    'is_liked' : isLiked,
    'is_saved' : isSaved,
    'tags' : tags
  };
}
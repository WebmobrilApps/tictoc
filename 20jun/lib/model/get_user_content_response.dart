class GetUserContentResponse {
  final int? resCode;
  final bool? success;
  final String? msg;
  List<Data>? data;
  final int? total;

  GetUserContentResponse({
    this.resCode,
    this.success,
    this.msg,
    this.data,
    this.total,
  });

  GetUserContentResponse.fromJson(Map<String, dynamic> json)
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
  final int? pkVideos;
  final int? userId;
  final String? descr;
  final String? url;
  final String? createdAt;
  final String? username;
  final String? name;
  final dynamic profilePic;
  int? likeCount;
  int? commentCount;
  int? saveCount;
  int? isLiked;
  int? isSaved;

  Data({
    this.pkVideos,
    this.userId,
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
  });

  Data.fromJson(Map<String, dynamic> json)
    : pkVideos = json['pk_videos'] as int?,
      userId = json['user_id'] as int?,
      descr = json['descr'] as String?,
      url = json['url'] as String?,
      createdAt = json['created_at'] as String?,
      username = json['username'] as String?,
      name = json['name'] as String?,
      profilePic = json['profile_pic'],
      likeCount = json['like_count'] as int?,
      commentCount = json['comment_count'] as int?,
      saveCount = json['save_count'] as int?,
      isLiked = json['is_liked'] as int?,
      isSaved = json['is_saved'] as int?;

  Map<String, dynamic> toJson() => {
    'pk_videos' : pkVideos,
    'user_id' : userId,
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
    'is_saved' : isSaved
  };
}
class FollowingFeedResponse {
  final int? resCode;
  final bool? success;
  final String? msg;
  List<Data>? data;
  final int? total;

  FollowingFeedResponse({
    this.resCode,
    this.success,
    this.msg,
    this.data,
    this.total,
  });

  FollowingFeedResponse.fromJson(Map<String, dynamic> json)
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
  final String? username;
  final dynamic profilePic;
  final String? descr;
  final String? url;
  final String? createdAt;
  int? likeCount;
  int? commentCount;
  int? saveCount;
  int? isLiked;
  int? isSaved;
  final int? isFollowing;
  final List<String>? tags;

  Data({
    this.videoId,
    this.uploaderId,
    this.username,
    this.profilePic,
    this.descr,
    this.url,
    this.createdAt,
    this.likeCount,
    this.commentCount,
    this.saveCount,
    this.isLiked,
    this.isSaved,
    this.isFollowing,
    this.tags,
  });

  Data.fromJson(Map<String, dynamic> json)
      : videoId = json['videoId'] as int?,
        uploaderId = json['uploaderId'] as int?,
        username = json['username'] as String?,
        profilePic = json['profile_pic'],
        descr = json['descr'] as String?,
        url = json['url'] as String?,
        createdAt = json['created_at'] as String?,
        likeCount = json['likeCount'] as int?,
        commentCount = json['commentCount'] as int?,
        saveCount = json['saveCount'] as int?,
        isLiked = json['isLiked'] as int?,
        isSaved = json['isSaved'] as int?,
        isFollowing = json['isFollowing'] as int?,
        tags = (json['tags'] as List?)?.map((dynamic e) => e as String).toList();

  Map<String, dynamic> toJson() => {
    'videoId' : videoId,
    'uploaderId' : uploaderId,
    'username' : username,
    'profile_pic' : profilePic,
    'descr' : descr,
    'url' : url,
    'created_at' : createdAt,
    'likeCount' : likeCount,
    'commentCount' : commentCount,
    'saveCount' : saveCount,
    'isLiked' : isLiked,
    'isSaved' : isSaved,
    'isFollowing' : isFollowing,
    'tags' : tags
  };
}
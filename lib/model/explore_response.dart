class ExploreResponse {
  final int? resCode;
  final bool? success;
  final String? msg;
  final List<Data>? data;

  ExploreResponse({
    this.resCode,
    this.success,
    this.msg,
    this.data,
  });

  ExploreResponse.fromJson(Map<String, dynamic> json)
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
  final int? videoId;
  final int? uploaderId;
  final String? username;
  final String? name;
  final String? profilePic;
  final String? descr;
  final String? url;
  final String? createdAt;
  int? likeCount;
  int? isLiked;
  final int? isSaved;
  final List<String>? tags;

  Data({
    this.videoId,
    this.uploaderId,
    this.username,
    this.name,
    this.profilePic,
    this.descr,
    this.url,
    this.createdAt,
    this.likeCount,
    this.isLiked,
    this.isSaved,
    this.tags,
  });

  Data.fromJson(Map<String, dynamic> json)
    : videoId = json['videoId'] as int?,
      uploaderId = json['uploaderId'] as int?,
      username = json['username'] as String?,
      name = json['name'] as String?,
      profilePic = json['profile_pic'] as String?,
      descr = json['descr'] as String?,
      url = json['url'] as String?,
      createdAt = json['created_at'] as String?,
      likeCount = json['likeCount'] as int?,
      isLiked = json['isLiked'] as int?,
      isSaved = json['isSaved'] as int?,
      tags = (json['tags'] as List?)?.map((dynamic e) => e as String).toList();

  Map<String, dynamic> toJson() => {
    'videoId' : videoId,
    'uploaderId' : uploaderId,
    'username' : username,
    'name' : name,
    'profile_pic' : profilePic,
    'descr' : descr,
    'url' : url,
    'created_at' : createdAt,
    'likeCount' : likeCount,
    'isLiked' : isLiked,
    'isSaved' : isSaved,
    'tags' : tags
  };
}
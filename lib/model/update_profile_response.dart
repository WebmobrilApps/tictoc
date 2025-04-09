class UpdateProfileResponse {
  final int? resCode;
  final bool? success;
  final String? msg;
  final Data? data;

  UpdateProfileResponse({
    this.resCode,
    this.success,
    this.msg,
    this.data,
  });

  UpdateProfileResponse.fromJson(Map<String, dynamic> json)
      : resCode = json['resCode'] as int?,
        success = json['success'] as bool?,
        msg = json['msg'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'resCode' : resCode,
    'success' : success,
    'msg' : msg,
    'data' : data?.toJson()
  };
}

class Data {
  final String? name;
  final String? image;
  final String? bio;

  Data({
    this.name,
    this.image,
    this.bio,
  });

  Data.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        image = json['image'] as String?,
        bio = json['bio'] as String?;

  Map<String, dynamic> toJson() => {
    'name' : name,
    'image' : image,
    'bio' : bio
  };
}
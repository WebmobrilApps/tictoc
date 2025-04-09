class DeletePostResponse {
  final int? resCode;
  final bool? success;
  final String? msg;
  final Data? data;

  DeletePostResponse({
    this.resCode,
    this.success,
    this.msg,
    this.data,
  });

  DeletePostResponse.fromJson(Map<String, dynamic> json)
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
  final String? contentId;

  Data({
    this.contentId,
  });

  Data.fromJson(Map<String, dynamic> json)
      : contentId = json['content_id'] as String?;

  Map<String, dynamic> toJson() => {
    'content_id' : contentId
  };
}
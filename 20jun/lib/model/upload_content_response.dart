class UploadContentResponse {
  final String? msg;
  final List<dynamic>? data;
  final dynamic resCode;

  UploadContentResponse({
    this.msg,
    this.data,
    this.resCode,
  });

  UploadContentResponse.fromJson(Map<String, dynamic> json)
      : msg = json['msg'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => e as dynamic).toList(),
        resCode = json['resCode'] as dynamic?;

  Map<String, dynamic> toJson() => {
    'msg' : msg,
    'data' : data,
    'resCode' : resCode
  };
}
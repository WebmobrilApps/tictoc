class LeaveReasonResponse {
  final int? resCode;
  final bool? success;
  final List<Data>? data;

  LeaveReasonResponse({
    this.resCode,
    this.success,
    this.data,
  });

  LeaveReasonResponse.fromJson(Map<String, dynamic> json)
      : resCode = json['resCode'] as int?,
        success = json['success'] as bool?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'resCode' : resCode,
    'success' : success,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final int? id;
  final String? reason;
  final String? changedAt;

  Data({
    this.id,
    this.reason,
    this.changedAt,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        reason = json['reason'] as String?,
        changedAt = json['changed_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'reason' : reason,
    'changed_at' : changedAt
  };
}
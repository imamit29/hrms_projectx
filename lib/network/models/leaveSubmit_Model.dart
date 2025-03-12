import 'dart:convert';

LeaveSubmitModel LeaveSubmitModelFromJson(String str) => LeaveSubmitModel.fromJson(json.decode(str));

class LeaveSubmitModel {
  LeaveSubmitModel({
    required this.jsonrpc,
    required this.id,
    required this.result,
  });

  final String? jsonrpc;
  final dynamic id;
  final Result? result;

  factory LeaveSubmitModel.fromJson(Map<String, dynamic> json){
    return LeaveSubmitModel(
      jsonrpc: json["jsonrpc"],
      id: json["id"],
      result: json["result"] == null ? null : Result.fromJson(json["result"]),
    );
  }

}

class Result {
  Result({
    required this.statusCode,
    required this.status,
    required this.message,
  });

  final int? statusCode;
  final String? status;
  final String? message;

  factory Result.fromJson(Map<String, dynamic> json){
    return Result(
      statusCode: json["status_code"],
      status: json["status"],
      message: json["message"],
    );
  }

}

import 'dart:convert';

LogoutModel LogoutModelFromJson(String str) => LogoutModel.fromJson(json.decode(str));

class LogoutModel {
  String? jsonrpc;
  Null? id;
  Result? result;

  LogoutModel({this.jsonrpc, this.id, this.result});

  LogoutModel.fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    data['id'] = this.id;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  int? statusCode;
  String? status;
  int? userId;

  Result({this.statusCode, this.status, this.userId});

  Result.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    status = json['status'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    return data;
  }
}


import 'dart:convert';

AttendanceModel AttendanceModelFromJson(String str) => AttendanceModel.fromJson(json.decode(str));

class AttendanceModel {
  String? jsonrpc;
  int? id;
  Result? result;

  AttendanceModel({this.jsonrpc, this.id, this.result});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
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
  List<String>? present;
  List<String>? weekend;
  List<String>? leave;
  List<String>? holidays;
  List<String>? absent;

  Result(
      {this.statusCode,
        this.status,
        this.present,
        this.weekend,
        this.leave,
        this.holidays,
        this.absent});

  Result.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    status = json['status'];
    present = json['Present'].cast<String>();
    weekend = json['weekend'].cast<String>();
    leave = json['leave'].cast<String>();
    holidays = json['holidays'].cast<String>();
    absent = json['absent'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status'] = this.status;
    data['Present'] = this.present;
    data['weekend'] = this.weekend;
    data['leave'] = this.leave;
    data['holidays'] = this.holidays;
    data['absent'] = this.absent;
    return data;
  }
}



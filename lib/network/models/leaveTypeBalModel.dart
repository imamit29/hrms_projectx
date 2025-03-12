import 'dart:convert';

LeaveTypeBalModel LeaveTypeBalModelFromJson(String str) => LeaveTypeBalModel.fromJson(json.decode(str));

class LeaveTypeBalModel {
  String? jsonrpc;
  int? id;
  Result? result;

  LeaveTypeBalModel({this.jsonrpc, this.id, this.result});

  LeaveTypeBalModel.fromJson(Map<String, dynamic> json) {
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
  String? message;
  List<LeaveTypes>? leaveTypes;

  Result({this.statusCode, this.status, this.message, this.leaveTypes});

  Result.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    status = json['status'];
    message = json['message'];
    if (json['leave_types'] != null) {
      leaveTypes = <LeaveTypes>[];
      json['leave_types'].forEach((v) {
        leaveTypes!.add(new LeaveTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.leaveTypes != null) {
      data['leave_types'] = this.leaveTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveTypes {
  int? leaveTypeId;
  String? leaveTypeName;
  int? allocatedLeaves;
  int? leavesTaken;
  int? remainingLeaves;

  LeaveTypes(
      {this.leaveTypeId,
        this.leaveTypeName,
        this.allocatedLeaves,
        this.leavesTaken,
        this.remainingLeaves});

  LeaveTypes.fromJson(Map<String, dynamic> json) {
    leaveTypeId = json['leave_type_id'];
    leaveTypeName = json['leave_type_name'];
    allocatedLeaves = json['allocated_leaves'];
    leavesTaken = json['leaves_taken'];
    remainingLeaves = json['remaining_leaves'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leave_type_id'] = this.leaveTypeId;
    data['leave_type_name'] = this.leaveTypeName;
    data['allocated_leaves'] = this.allocatedLeaves;
    data['leaves_taken'] = this.leavesTaken;
    data['remaining_leaves'] = this.remainingLeaves;
    return data;
  }
}



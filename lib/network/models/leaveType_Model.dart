import 'dart:convert';

LeaveTypeModel LeaveTypeModelFromJson(String str) => LeaveTypeModel.fromJson(json.decode(str));

class LeaveTypeModel {
  int? statusCode;
  String? status;
  List<String>? leaveData;

  LeaveTypeModel({this.statusCode, this.status, this.leaveData});

  LeaveTypeModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    status = json['status'];
    leaveData = json['leave_data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status'] = this.status;
    data['leave_data'] = this.leaveData;
    return data;
  }
}


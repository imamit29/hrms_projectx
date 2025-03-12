import 'dart:convert';

LeaveTypeModel LeaveTypeModelFromJson(String str) => LeaveTypeModel.fromJson(json.decode(str));

class LeaveTypeModel {
  int? statusCode;
  String? status;
  String? message;
  List<LeaveTypes>? leaveTypes;

  LeaveTypeModel({this.statusCode, this.status, this.message, this.leaveTypes});

  LeaveTypeModel.fromJson(Map<String, dynamic> json) {
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

  LeaveTypes({this.leaveTypeId, this.leaveTypeName});

  LeaveTypes.fromJson(Map<String, dynamic> json) {
    leaveTypeId = json['leave_type_id'];
    leaveTypeName = json['leave_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leave_type_id'] = this.leaveTypeId;
    data['leave_type_name'] = this.leaveTypeName;
    return data;
  }
}


import 'dart:convert';

HolidayModel HolidayModelFromJson(String str) => HolidayModel.fromJson(json.decode(str));

class HolidayModel {
  String? jsonrpc;
  Null? id;
  Result? result;

  HolidayModel({this.jsonrpc, this.id, this.result});

  HolidayModel.fromJson(Map<String, dynamic> json) {
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
  List<HolidaysList>? holidaysList;

  Result({this.statusCode, this.status, this.holidaysList});

  Result.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    status = json['status'];
    if (json['holidays_list'] != null) {
      holidaysList = <HolidaysList>[];
      json['holidays_list'].forEach((v) {
        holidaysList!.add(new HolidaysList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status'] = this.status;
    if (this.holidaysList != null) {
      data['holidays_list'] =
          this.holidaysList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HolidaysList {
  String? name;
  String? startDate;
  String? endDate;

  HolidaysList({this.name, this.startDate, this.endDate});

  HolidaysList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}


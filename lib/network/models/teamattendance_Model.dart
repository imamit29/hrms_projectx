import 'dart:convert';

TeamAttendanceModel TeamAttendanceModelFromJson(String str) => TeamAttendanceModel.fromJson(json.decode(str));

class TeamAttendanceModel {
  String? jsonrpc;
  int? id;
  Result? result;

  TeamAttendanceModel({this.jsonrpc, this.id, this.result});

  TeamAttendanceModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  UserAttendance? userAttendance;
  List<TeamAttendance>? teamAttendance;
  List<CurrentMonthHoliday>? currentMonthHoliday;

  Result(
      {this.statusCode,
        this.userId,
        this.userAttendance,
        this.teamAttendance,
        this.currentMonthHoliday});

  Result.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    userId = json['user_id'];
    userAttendance = json['user_attendance'] != null
        ? new UserAttendance.fromJson(json['user_attendance'])
        : null;
    if (json['team_attendance'] != null) {
      teamAttendance = <TeamAttendance>[];
      json['team_attendance'].forEach((v) {
        teamAttendance!.add(new TeamAttendance.fromJson(v));
      });
    }
    if (json['current_month_holiday'] != null) {
      currentMonthHoliday = <CurrentMonthHoliday>[];
      json['current_month_holiday'].forEach((v) {
        currentMonthHoliday!.add(new CurrentMonthHoliday.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['user_id'] = this.userId;
    if (this.userAttendance != null) {
      data['user_attendance'] = this.userAttendance!.toJson();
    }
    if (this.teamAttendance != null) {
      data['team_attendance'] =
          this.teamAttendance!.map((v) => v.toJson()).toList();
    }
    if (this.currentMonthHoliday != null) {
      data['current_month_holiday'] =
          this.currentMonthHoliday!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserAttendance {
  int? id;
  String? name;
  String? department;
  String? jobPosition;
  String? phone;
  String? workEmail;
  String? company;
  String? image;
  String? checkIn;
  String? checkOut;

  UserAttendance(
      {this.id,
        this.name,
        this.department,
        this.jobPosition,
        this.phone,
        this.workEmail,
        this.company,
        this.image,
        this.checkIn,
        this.checkOut});

  UserAttendance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    department = json['department'];
    jobPosition = json['job_position'];
    phone = json['phone'];
    workEmail = json['work_email'];
    company = json['company'];
    image = json['image'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['department'] = this.department;
    data['job_position'] = this.jobPosition;
    data['phone'] = this.phone;
    data['work_email'] = this.workEmail;
    data['company'] = this.company;
    data['image'] = this.image;
    data['check_in'] = this.checkIn;
    data['check_out'] = this.checkOut;
    return data;
  }
}

class TeamAttendance {
  int? id;
  String? name;
  String? department;
  String? jobPosition;
  String? phone;
  String? workEmail;
  String? checkIn;
  String? checkOut;

  TeamAttendance(
      {this.id,
        this.name,
        this.department,
        this.jobPosition,
        this.phone,
        this.workEmail,
        this.checkIn,
        this.checkOut});

  TeamAttendance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    department = json['department'];
    jobPosition = json['job_position'];
    phone = json['phone'];
    workEmail = json['work_email'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['department'] = this.department;
    data['job_position'] = this.jobPosition;
    data['phone'] = this.phone;
    data['work_email'] = this.workEmail;
    data['check_in'] = this.checkIn;
    data['check_out'] = this.checkOut;
    return data;
  }
}

class CurrentMonthHoliday {
  String? name;
  String? startDate;
  String? endDate;

  CurrentMonthHoliday({this.name, this.startDate, this.endDate});

  CurrentMonthHoliday.fromJson(Map<String, dynamic> json) {
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


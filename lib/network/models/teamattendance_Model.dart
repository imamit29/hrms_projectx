import 'dart:convert';

TeamAttendanceModel TeamAttendanceModelFromJson(String str) => TeamAttendanceModel.fromJson(json.decode(str));

class TeamAttendanceModel {
  TeamAttendanceModel({
    required this.jsonrpc,
    required this.id,
    required this.result,
  });

  final String? jsonrpc;
  final dynamic id;
  final Result? result;

  factory TeamAttendanceModel.fromJson(Map<String, dynamic> json){
    return TeamAttendanceModel(
      jsonrpc: json["jsonrpc"],
      id: json["id"],
      result: json["result"] == null ? null : Result.fromJson(json["result"]),
    );
  }

}

class Result {
  Result({
    required this.statusCode,
    required this.userId,
    required this.userAttendance,
    required this.teamAttendance,
    required this.currentMonthHoliday,
  });

  final int? statusCode;
  final int? userId;
  final UserAttendance? userAttendance;
  final List<TeamAttendance> teamAttendance;
  final List<CurrentMonthHoliday> currentMonthHoliday;

  factory Result.fromJson(Map<String, dynamic> json){
    return Result(
      statusCode: json["status_code"],
      userId: json["user_id"],
      userAttendance: json["user_attendance"] == null ? null : UserAttendance.fromJson(json["user_attendance"]),
      teamAttendance: json["team_attendance"] == null ? [] : List<TeamAttendance>.from(json["team_attendance"]!.map((x) => TeamAttendance.fromJson(x))),
      currentMonthHoliday: json["current_month_holiday"] == null ? [] : List<CurrentMonthHoliday>.from(json["current_month_holiday"]!.map((x) => CurrentMonthHoliday.fromJson(x))),
    );
  }

}

class CurrentMonthHoliday {
  CurrentMonthHoliday({
    required this.name,
    required this.startDate,
    required this.endDate,
  });

  final String? name;
  final String? startDate;
  final String? endDate;

  factory CurrentMonthHoliday.fromJson(Map<String, dynamic> json){
    return CurrentMonthHoliday(
      name: json["name"],
      startDate: json["start_date"],
      endDate: json["end_date"],
    );
  }

}

class TeamAttendance {
  TeamAttendance({
    required this.id,
    required this.name,
    required this.department,
    required this.jobPosition,
    required this.phone,
    required this.workEmail,
    required this.checkIn,
    required this.checkOut,
  });

  final int? id;
  final String? name;
  final dynamic? department;
  final dynamic? jobPosition;
  final String? phone;
  final String? workEmail;
  final String? checkIn;
  final String? checkOut;

  factory TeamAttendance.fromJson(Map<String, dynamic> json){
    return TeamAttendance(
      id: json["id"],
      name: json["name"],
      department: json["department"],
      jobPosition: json["job_position"],
      phone: json["phone"],
      workEmail: json["work_email"],
      checkIn: json["check_in"],
      checkOut: json["check_out"],
    );
  }

}

class UserAttendance {
  UserAttendance({
    required this.id,
    required this.name,
    required this.department,
    required this.jobPosition,
    required this.phone,
    required this.workEmail,
    required this.company,
    required this.image,
    required this.checkIn,
    required this.checkOut,
  });

  final int? id;
  final String? name;
  final String? department;
  final String? jobPosition;
  final String? phone;
  final String? workEmail;
  final String? company;
  final String? image;
  final String? checkIn;
  final String? checkOut;

  factory UserAttendance.fromJson(Map<String, dynamic> json){
    return UserAttendance(
      id: json["id"],
      name: json["name"],
      department: json["department"],
      jobPosition: json["job_position"],
      phone: json["phone"],
      workEmail: json["work_email"],
      company: json["company"],
      image: json["image"],
      checkIn: json["check_in"],
      checkOut: json["check_out"],
    );
  }

}

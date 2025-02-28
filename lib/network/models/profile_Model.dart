import 'dart:convert';

ProfileModel ProfileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

class ProfileModel {
  String? jsonrpc;
  Null? id;
  Result? result;

  ProfileModel({this.jsonrpc, this.id, this.result});

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
  Data? data;

  Result({this.statusCode, this.status, this.data});

  Result.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  PersonalInformation? personalInformation;
  EmployementStatus? employementStatus;
  PositionDetails? positionDetails;

  Data(
      {this.personalInformation, this.employementStatus, this.positionDetails});

  Data.fromJson(Map<String, dynamic> json) {
    personalInformation = json['personal_information'] != null
        ? new PersonalInformation.fromJson(json['personal_information'])
        : null;
    employementStatus = json['employement_status'] != null
        ? new EmployementStatus.fromJson(json['employement_status'])
        : null;
    positionDetails = json['position_details'] != null
        ? new PositionDetails.fromJson(json['position_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.personalInformation != null) {
      data['personal_information'] = this.personalInformation!.toJson();
    }
    if (this.employementStatus != null) {
      data['employement_status'] = this.employementStatus!.toJson();
    }
    if (this.positionDetails != null) {
      data['position_details'] = this.positionDetails!.toJson();
    }
    return data;
  }
}

class PersonalInformation {
  int? employeeId;
  String? firstName;
  String? empCode;
  bool? dob;
  String? gender;
  String? bloodGroup;

  PersonalInformation(
      {this.employeeId,
        this.firstName,
        this.empCode,
        this.dob,
        this.gender,
        this.bloodGroup});

  PersonalInformation.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    firstName = json['first_name'];
    empCode = json['emp_code'];
    dob = json['dob'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    data['first_name'] = this.firstName;
    data['emp_code'] = this.empCode;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['blood_group'] = this.bloodGroup;
    return data;
  }
}

class EmployementStatus {
  String? joiningDate;
  String? empType;
  String? empStatus;
  String? dateOfConfirmation;

  EmployementStatus(
      {this.joiningDate,
        this.empType,
        this.empStatus,
        this.dateOfConfirmation});

  EmployementStatus.fromJson(Map<String, dynamic> json) {
    joiningDate = json['joining_date'];
    empType = json['emp_type'];
    empStatus = json['emp_status'];
    dateOfConfirmation = json['date_of_confirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['joining_date'] = this.joiningDate;
    data['emp_type'] = this.empType;
    data['emp_status'] = this.empStatus;
    data['date_of_confirmation'] = this.dateOfConfirmation;
    return data;
  }
}

class PositionDetails {
  String? companyName;
  String? department;
  bool? branch;
  String? designation;
  String? grade;
  String? rM;
  String? fM;

  PositionDetails(
      {this.companyName,
        this.department,
        this.branch,
        this.designation,
        this.grade,
        this.rM,
        this.fM});

  PositionDetails.fromJson(Map<String, dynamic> json) {
    companyName = json['company_name'];
    department = json['department'];
    branch = json['branch'];
    designation = json['designation'];
    grade = json['grade'];
    rM = json['r_m'];
    fM = json['f_m'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_name'] = this.companyName;
    data['department'] = this.department;
    data['branch'] = this.branch;
    data['designation'] = this.designation;
    data['grade'] = this.grade;
    data['r_m'] = this.rM;
    data['f_m'] = this.fM;
    return data;
  }
}

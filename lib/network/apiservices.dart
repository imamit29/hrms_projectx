import 'dart:convert';
import 'dart:ffi';

import 'package:hrms_project/extras/Constants.dart';
import 'package:hrms_project/network/models/attendance_Model.dart';
import 'package:hrms_project/network/models/holiday_Model.dart';
import 'package:hrms_project/network/models/leaveSubmit_Model.dart';
import 'package:hrms_project/network/models/leaveTypeBalModel.dart';
import 'package:hrms_project/network/models/leaveType_Model.dart';
import 'package:hrms_project/network/models/login_Model.dart';
import 'package:hrms_project/network/models/profile_Model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ApiService {


  Future<LoginModel?> userLogin(String email, String password, String device_id) async {
    try {

      final Map<String, dynamic> payload = {
        "email": email,
        "password": password,
        "device_id": device_id
      };

      final response = await http.post(
        Uri.parse("${Constants.baseURL}UserLogin"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      print(response.request);
      print(payload);
      print(response.body);

      if (response.statusCode == 200) {
        LoginModel model = loginModelFromJson(response.body);
        return model;
      }
    } catch (e) {}
    return null;
  }

  Future<ProfileModel?> userProfile(userid) async {
    try {

      final Map<String, dynamic> payload = {
        "user_id": userid
      };

      final response = await http.post(
        Uri.parse("${Constants.baseURL}UserProfile"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      print(response.request);
      print(response.body);
      if (response.statusCode == 200) {
        ProfileModel model = ProfileModelFromJson(response.body);
        return model;
      }
    } catch (e) {}
    return null;
  }

  Future<LeaveTypeModel?> leaveType(userid) async {
    try {

      final response = await http.get(
        Uri.parse("${Constants.baseURL}GetLeaveTypes/"),
        headers: {"Content-Type": "application/json"},
        //body: jsonEncode(payload),
      );

      print(response.request);
      print(response.body);
      if (response.statusCode == 200) {
        LeaveTypeModel model = LeaveTypeModelFromJson(response.body);
        return model;
      }
    } catch (e) {}
    return null;
  }

  Future<HolidayModel?> holidayCalander(userid) async {
    try {

      final Map<String, dynamic> payload = {
        "user_id": userid
      };

      final response = await http.post(
        Uri.parse("${Constants.baseURL}HollidayCalander"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      print(response.request);
      print(response.body);
      if (response.statusCode == 200) {
        HolidayModel model = HolidayModelFromJson(response.body);
        return model;
      }
    } catch (e) {}
    return null;
  }

  Future<AttendanceModel?> attendanceInfo(userid) async {
    try {

      final Map<String, dynamic> payload = {
        "user_id": userid
      };

      final response = await http.post(
        Uri.parse("${Constants.baseURL}GetAttendanceInfo"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      print(response.request);
      print(response.body);
      if (response.statusCode == 200) {
        AttendanceModel model = AttendanceModelFromJson(response.body);
        return model;
      }
    } catch (e) {}
    return null;
  }

  Future<LeaveSubmitModel?> getleavesubmit(userid, leave_type, start_date, end_date, reason) async {
    try {

      final Map<String, dynamic> payload = {
        "user_id": userid,
        "leave_type": leave_type,
        "start_date": start_date,
        "end_date": end_date,
        "reason": reason
      };

      final response = await http.post(
        Uri.parse("${Constants.baseURL}ApplyLeave"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      print(response.request);
      print(response.body);
      if (response.statusCode == 200) {
        LeaveSubmitModel model = LeaveSubmitModelFromJson(response.body);
        return model;
      }
    } catch (e) {}
    return null;
  }

  Future<LeaveTypeBalModel?> leaveTypeBal(userid) async {
    try {

      final Map<String, dynamic> payload = {
        "user_id": userid,
      };

      final response = await http.post(
        Uri.parse("${Constants.baseURL}GetLeaveTypesAndBalance"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      print(response.request);
      print(response.body);
      if (response.statusCode == 200) {
        LeaveTypeBalModel model = LeaveTypeBalModelFromJson(response.body);
        return model;
      }
    } catch (e) {}
    return null;
  }
}
import 'package:flutter/cupertino.dart';
import 'package:hrms_project/network/models/holiday_Model.dart';
import 'package:hrms_project/network/models/profile_Model.dart';
import 'package:hrms_project/network/models/teamattendance_Model.dart';

class TeamAttendanceProvider extends ChangeNotifier {
  late TeamAttendanceModel _teamAttendanceData;

  TeamAttendanceModel get teamAttendanceData => _teamAttendanceData;

  void setTeamAttendanceData(TeamAttendanceModel response) {
    _teamAttendanceData = response;
    notifyListeners();
  }
}
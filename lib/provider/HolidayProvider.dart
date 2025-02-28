import 'package:flutter/cupertino.dart';
import 'package:hrms_project/network/models/holiday_Model.dart';
import 'package:hrms_project/network/models/profile_Model.dart';

class HolidayProvider extends ChangeNotifier {
  late HolidayModel _holidayData;

  HolidayModel get holidayData => _holidayData;

  void setHolidayData(HolidayModel response) {
    _holidayData = response;
    notifyListeners();
  }
}
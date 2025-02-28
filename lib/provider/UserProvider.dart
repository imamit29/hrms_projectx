import 'package:flutter/cupertino.dart';
import 'package:hrms_project/network/models/profile_Model.dart';

class UserProvider extends ChangeNotifier {
  late ProfileModel _profileData;

  ProfileModel get profileData => _profileData;

  void setProfileData(ProfileModel response) {
    _profileData = response;
    notifyListeners();
  }
}
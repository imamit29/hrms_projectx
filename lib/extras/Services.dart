import 'package:flutter/cupertino.dart';
import 'package:hrms_project/extras/globalFunctions.dart';
import 'package:hrms_project/main.dart';
import 'package:hrms_project/screens/welcomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services {

  Future<void> logoutUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    openPageNoBack(context, WelcomeScreen());
  }
}
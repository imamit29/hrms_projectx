import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

openPageNoBack(context, screenName) {
  Navigator.pushAndRemoveUntil<dynamic>(
    context,
    MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => screenName,
    ),
        (route) => false, //if you want to disable back feature set to false
  );
}

openPage(context, screenName) {
  Navigator.pushAndRemoveUntil<dynamic>(
    context,
    MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => screenName,
    ),
        (route) => true, //if you want to disable back feature set to false
  );
}

showError(var msg , context) {
  Fluttertoast.showToast(
      msg: "$msg",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Theme.of(context).colorScheme.primary,
      textColor: Colors.white,
      fontSize: 16.0);
}


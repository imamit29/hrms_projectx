import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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


showLoaderDialog(BuildContext context, msg) {
  var alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: Text('$msg...')),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

}

onAlert(context, title, msg, alertType) {
  Alert(
    context: context,
    type: alertType,
    title: title,
    desc: msg,
    buttons: [
      DialogButton(
        color: Theme.of(context).colorScheme.primary,
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}

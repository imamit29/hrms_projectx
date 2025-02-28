import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrms_project/extras/globalFunctions.dart';
import 'package:hrms_project/network/apiservices.dart';
import 'package:hrms_project/network/models/profile_Model.dart';
import 'package:hrms_project/provider/HolidayProvider.dart';
import 'package:hrms_project/provider/UserProvider.dart';
import 'package:hrms_project/screens/NavigatorScreen.dart';
import 'package:hrms_project/screens/welcomePage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark, // this will change the brightness of the icons
    statusBarColor: Color.fromRGBO(5, 42, 61, 1), // or any color you want
  ));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => HolidayProvider()),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InitScreen(),
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(5, 42, 61, 1), // Primary color
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromRGBO(5, 42, 61, 1),
          secondary: const Color.fromRGBO(4, 46, 62, 0.10), // Secondary color
        ),
      ),
    );
  }
}

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {

  var isLoggedIn = false;

  @override
  initState() {
    super.initState();
   checkLoginStatus();

  }

  checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn =  prefs.getBool('isloggedin') ?? false;
    print('isLoggedIn : $isLoggedIn');
    if(isLoggedIn){
      _getLogin();
    }else{
      openPageNoBack(context,WelcomeScreen());
    }


  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/ic_launcher.png',
        width: 150,
        height: 150,
      ),
    );
  }

  ProfileModel? _userModel;

  void _getLogin() async {
    var prefs = await SharedPreferences.getInstance();
    _userModel = (await ApiService().userProfile(prefs.get('userid')));

    if(_userModel?.result?.status == 'Sucessfull'){
      Provider.of<UserProvider>(context, listen: false).setProfileData(_userModel!);
      openPageNoBack(context, NavigatorScreen());
    }else{
      openPageNoBack(context,WelcomeScreen());
    }


  }
}



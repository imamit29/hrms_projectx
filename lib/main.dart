import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrms_project/extras/Constants.dart';
import 'package:hrms_project/screens/LoginScreen.dart';
import 'package:hrms_project/screens/NavigatorScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark, // this will change the brightness of the icons
    statusBarColor: Color.fromRGBO(5, 42, 61, 1), // or any color you want
  ));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
    theme: ThemeData(
      primaryColor: const Color.fromRGBO(5, 42, 61, 1), // Primary color
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color.fromRGBO(5, 42, 61, 1),
        secondary: const Color.fromRGBO(4, 46, 62, 0.10), // Secondary color
      ),
    ),
    routes: <String, WidgetBuilder>{
      '/LoginScreen': (BuildContext context) => LoginScreen(),
    },
  ));
}



class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InitScreen(),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoggedIn?NavigatorScreen():WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5E6D3),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 70),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/ic_launcher.png', // Replace with actual image asset
                            width: 100,
                            height: 100,
                            //fit: BoxFit.contain,
                          ),
                          SizedBox(height: 10),
                          Text(
                            Constants.appName,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Image.asset(
                        'assets/hrms_illustration.gif', // Replace with actual image asset
                        width: 200,
                        height: 200,
                        //fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(

                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Theme.of(context).colorScheme.primary,
                          ),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

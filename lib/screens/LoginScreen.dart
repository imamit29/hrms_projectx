import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_project/extras/Constants.dart';
import 'package:hrms_project/extras/globalFunctions.dart';
import 'package:hrms_project/screens/NavigatorScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _showPassword = false;
  bool _value = false;
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _url = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/background.png"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.10), BlendMode.dstATop),
              ),
            ),
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [

                      Card(
                        margin: EdgeInsets.zero,
                        color: Theme.of(context).colorScheme.primary,
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: const Radius.circular(0),
                              topRight: const Radius.circular(0),
                              bottomLeft: const Radius.circular(50),
                              topLeft: Radius.circular(0)),

                        ),
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                          height: 200,
                          child: Image.asset(
                            'assets/login_top.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Column(

                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                'assets/ic_launcher.png', // Replace with actual image asset
                                width: 70,
                                height: 70,
                                //fit: BoxFit.contain,
                              ),
                            ),
                            Text(
                              Constants.appName,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding:
                    const EdgeInsets.only(bottom: 20, top: 20),
                    child: const Text(
                        "Login With Username & Password",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        // Email Field
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.indigo)
                            ),
                          ),
                          controller: _username,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field cannot be empty';
                            }
                            return null;
                          },

                        ),
                        const SizedBox(height: 16),
                        // Password Field
                        TextFormField(
                          controller: _password,
                          obscureText: _showPassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.indigo)
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              child: Icon(
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),

                        ),
                        const SizedBox(height: 16),
                        // Password Field
                        TextFormField(
                          controller: _url,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'URL',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.indigo)
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(value: _value,
                              activeColor: Theme.of(context).colorScheme.primary,
                              onChanged: (value) {
                                setState(() {
                                  _value = value!;
                                });
                              },),
                            const Text("Remember Me")
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {

                              if(_username.text.isEmpty){

                                  showError('Please enter a valid username', context);
                                }else if(_username.text.isEmpty){
                                  showError('Please enter a valid password', context);
                                }else if(_username.text.isEmpty){
                                  showError('Please enter a valid URL', context);
                                }else{

                                if(_value){
                                  var prefs = await SharedPreferences.getInstance();
                                  prefs.setBool('isloggedin', true);
                                  prefs.setString("username",_username.text);
                                }
                                openPageNoBack(context, NavigatorScreen());


                              }

                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

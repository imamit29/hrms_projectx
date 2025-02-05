import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_project/screens/bottombarPages/ExplorePage.dart';
import 'package:hrms_project/screens/bottombarPages/HomePage.dart';
import 'package:hrms_project/screens/bottombarPages/ProfilePage.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({Key? key}) : super(key: key);

  @override
  _NavigatorScreenState createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {

  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    ProfilePage(),
    ExplorePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
      appBar: AppBar(
        title: Text('Welcome to EPAM HRMS'),
        leading:  Container(
            margin: const EdgeInsets.only(left: 24.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Container(
                margin: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/ic_launcher.png'),
                  ),
                ))),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.all(20,),
              child: InkWell(
                onTap: () {

                },
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            )

          ]
      ),
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
    ));
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit this App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }
}
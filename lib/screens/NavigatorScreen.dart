import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_project/extras/Services.dart';
import 'package:hrms_project/screens/bottombarPages/ActionPage.dart';
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
    ActionPage(),
    ProfilePage(),
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
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Welcome to EPAM HRMS', style: TextStyle(color: Colors.white, fontSize: 14),),
        leading:  Container(
            margin: const EdgeInsets.only(left: 30.0),
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
                  Services().logoutUser(context);
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
      body: SafeArea(child: Container(
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
        child:  _pages[_selectedIndex],
      )),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.circle, color: Colors.transparent),
                label: ''), // Dummy for FAB
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex > 1 ? 1 : _selectedIndex,
          onTap: (index) {
            if (index == 1) return; // Prevents tab change when FAB is clicked
            _onItemTapped(index);
          },
          selectedItemColor: Colors.blue,

        ),
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () {
              setState(() {
                _selectedIndex = 1; // Navigate to action screen
              });
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
            elevation: 4,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
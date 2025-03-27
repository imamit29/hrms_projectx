import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrms_project/extras/globalFunctions.dart';
import 'package:hrms_project/network/apiservices.dart';
import 'package:hrms_project/network/models/logout_Model.dart';
import 'package:hrms_project/network/models/profile_Model.dart';
import 'package:hrms_project/provider/UserProvider.dart';
import 'package:hrms_project/screens/bottombarPages/homeSections/HolidayCard.dart';
import 'package:hrms_project/screens/bottombarPages/homeSections/PayslipCard.dart';
import 'package:hrms_project/screens/bottombarPages/homeSections/TeamAttendanceCard.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unique_identifier/unique_identifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    initUniqueIdentifierState();
  }

  @override
  Widget build(BuildContext context) {
    final apiResponse = Provider.of<UserProvider>(context).profileData;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${apiResponse.result?.data?.personalInformation?.firstName} 👋',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${apiResponse.result?.data?.positionDetails?.designation}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: AssetImage('assets/userimg.png'), // Replace with a network image if needed
                        ),
                      ],
                    ),),
                  const SizedBox(height: 30),
                  // Time and Shift Card

                  Container(
                    height: 230,
                    child: Stack(
                      children: [

                        Container(
                          height: 100,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: Image.asset(
                            'assets/homeheader.jpg',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Container(
                          height: 150,
                          margin: EdgeInsets.only(top: 90),
                          alignment: Alignment.bottomCenter,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '7:03 PM',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.purple,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${getCurrentDayOfWeek()} | GENERAL Shift',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           apiResponse.result!.data!.attendanceInfo!.checkIn=='N/A'?Container():Text(
                                             'Check-In: ${apiResponse.result!.data!.attendanceInfo!.checkIn.toString()}',
                                             style: TextStyle(
                                               fontSize: 12,
                                               color: Colors.grey,
                                             ),
                                           ),
                                           apiResponse.result!.data!.attendanceInfo!.checkOut=='N/A'?Container():Text(
                                             'Check-Out: ${apiResponse.result!.data!.attendanceInfo!.checkOut.toString()}',
                                             style: TextStyle(
                                               fontSize: 12,
                                               color: Colors.grey,
                                             ),
                                           ),
                                         ],
                                       ),

                                        const SizedBox(height: 8),
                                        apiResponse.result!.data!.attendanceInfo!.checkIn=='N/A'||apiResponse.result!.data!.attendanceInfo!.checkOut=='N/A'?ElevatedButton(
                                          onPressed: () {
                                            if(apiResponse.result!.data!.attendanceInfo!.checkIn=='N/A'){
                                              _getCheckIn_Out(28.6379,77.378548,'checkin',getCurrentDateTime(),'');
                                            }else{
                                              _getCheckIn_Out(28.6379,77.378548,'checkout',apiResponse.result!.data!.attendanceInfo!.checkIn.toString(),getCurrentDateTime());
                                            }

                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          ),
                                          child: Text(apiResponse.result!.data!.attendanceInfo!.checkIn=='N/A'?'Check In':'Check Out', style: TextStyle(color: Colors.white),),
                                        ):Container(),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TeamAttendanceCard(),
                  PayslipCard(),
                  UpcomingHolidayCard()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  var device_id = '';
  Future<void> initUniqueIdentifierState() async {
    String identifier;
    try {
      identifier = (await UniqueIdentifier.serial)!;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }

    if (!mounted) return;

    setState(() {
      device_id = identifier;
    });
  }

  LogoutModel? _userModel;

  void _getCheckIn_Out(lat,long,ctype,checkin,checkout) async {
    showLoaderDialog(context, 'Processing...');
    var prefs = await SharedPreferences.getInstance();
    _userModel = (await ApiService().checkIn_Out(prefs.get('userid'), lat,long,ctype,checkin,checkout));
    Navigator.pop(context);
    _getProfile();
  }

  ProfileModel? _profileModel;

  void _getProfile() async {
    var prefs = await SharedPreferences.getInstance();
    _profileModel = (await ApiService().userProfile(prefs.get('userid')));
    if (_userModel?.result?.status == "Sucessfull") {
      Provider.of<UserProvider>(context, listen: false)
          .setProfileData(_profileModel!);
    } else {
    }
  }

  String getCurrentDateTime() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
    return formatter.format(now);
  }

  String getCurrentDayOfWeek() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('EEEE'); // 'EEEE' gives the full weekday name
    return formatter.format(now);
  }

}
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_project/extras/globalFunctions.dart';
import 'package:hrms_project/network/apiservices.dart';
import 'package:hrms_project/network/models/holiday_Model.dart';
import 'package:hrms_project/network/models/teamattendance_Model.dart';
import 'package:hrms_project/provider/HolidayProvider.dart';
import 'package:hrms_project/provider/TeamAttendanceProvider.dart';
import 'package:hrms_project/screens/CalendarScreen.dart';
import 'package:hrms_project/screens/TeamAttendanceScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamAttendanceCard extends StatefulWidget {
  const TeamAttendanceCard({Key? key}) : super(key: key);

  @override
  _TeamAttendanceCardState createState() => _TeamAttendanceCardState();
}

class _TeamAttendanceCardState extends State<TeamAttendanceCard> {


  List<TeamAttendance?> holidays = [];


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Team Attendance',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Icon(Icons.open_in_new, color: Colors.grey),
                ],
              ),
              SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2,
                ),
                itemCount: holidays.length>4?4:holidays.length,
                itemBuilder: (context, index) {
                  return AttendanceCard(holiday: holidays, index: index);
                },
              ),
            ],
          ),
        ),
        onTap: (){
          openPage(context, TeamAttendanceScreen());
        },
      ),
    );
  }

  @override
  void initState() {
    _getTeamAttendance();
    super.initState();
  }

  TeamAttendanceModel? _teamAttendanceModel;

  void _getTeamAttendance() async {
    var prefs = await SharedPreferences.getInstance();
    _teamAttendanceModel = (await ApiService().teamAttendance(prefs.get('userid')));
    setState(() {
      Provider.of<TeamAttendanceProvider>(context, listen: false).setTeamAttendanceData(_teamAttendanceModel!);
      holidays = _teamAttendanceModel!.result!.teamAttendance!;

    });

  }
}

class AttendanceCard extends StatelessWidget {
  final List<TeamAttendance?> holiday;
  final index;
  const AttendanceCard({super.key, required this.holiday, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Icon(Icons.person),
            ),
            SizedBox(height: 5,),
            Text(
              holiday[index]!.name!,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(5, 42, 61, 1),

              ),
            ),
            holiday[index]!.jobPosition!=""?Text(
              holiday[index]!.jobPosition!,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(5, 42, 61, 1),

              ),
            ):Container(),
            SizedBox(height: 5,),
            Text(
              holiday[index]!.checkIn=='N/A'&&holiday[index]!.checkOut=='N/A'?'Not Checked In Yet':
              holiday[index]!.checkIn!='N/A'&&holiday[index]!.checkOut=='N/A'?'Checked In':
              holiday[index]!.checkIn!='N/A'&&holiday[index]!.checkOut!='N/A'?'Checked Out':"",
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color:
                holiday[index]!.checkIn=='N/A'&&holiday[index]!.checkOut=='N/A'?Colors.red:
                holiday[index]!.checkIn!='N/A'&&holiday[index]!.checkOut=='N/A'?Colors.green:
                holiday[index]!.checkIn!='N/A'&&holiday[index]!.checkOut!='N/A'?Colors.deepOrange:null,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
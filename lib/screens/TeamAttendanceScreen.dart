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
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamAttendanceScreen extends StatefulWidget {
  const TeamAttendanceScreen({Key? key}) : super(key: key);

  @override
  _TeamAttendanceScreenState createState() => _TeamAttendanceScreenState();
}

class _TeamAttendanceScreenState extends State<TeamAttendanceScreen> {


  @override
  Widget build(BuildContext context) {
    final apiResponse = Provider.of<TeamAttendanceProvider>(context).teamAttendanceData;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {Navigator.pop(context);},
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Team Attendance', style: TextStyle(fontSize: 20,color: Colors.white),),),
      body: Container(
        margin: EdgeInsets.all(20),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemCount: apiResponse.result?.teamAttendance.length,
          itemBuilder: (context, index) {
            return AttendanceCard(holiday: apiResponse.result!.teamAttendance, index: index);
          },
        ),
      ),
    );
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
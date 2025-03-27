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
import 'package:url_launcher/url_launcher.dart';

class DirectoryScreen extends StatefulWidget {
  const DirectoryScreen({Key? key}) : super(key: key);

  @override
  _DirectoryScreenState createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {


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
        title: Text('Team Directory', style: TextStyle(fontSize: 20,color: Colors.white),),),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: apiResponse.result?.teamAttendance.length,
          itemBuilder: (context, index) {
            return DirectoryCard(holiday: apiResponse.result!.teamAttendance, index: index);
          },
        ),
      ),
    );
  }

}

class DirectoryCard extends StatelessWidget {
  final List<TeamAttendance?> holiday;
  final index;
  const DirectoryCard({super.key, required this.holiday, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      child: Card(
        color: Colors.blue[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                child: Icon(Icons.person),
              ),
              Expanded(child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    holiday[index]!.name!,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(5, 42, 61, 1),

                    ),
                  ),
                  holiday[index]!.jobPosition!=""?Text(
                    holiday[index]!.jobPosition!,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(5, 42, 61, 1),

                    ),
                  ):Container(),
                  SizedBox(height: 5,),

                ],
              ),)),
              GestureDetector(
                child: Icon(Icons.call, color: Theme.of(context).colorScheme.primary,),
                onTap: (){
                  openDialer(holiday[index]!.phone.toString());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openDialer(String phoneNumber) async {
    final Uri dialUri = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(dialUri)) {
      await launchUrl(dialUri);
    } else {
      throw "Could not open dialer.";
    }
  }
}
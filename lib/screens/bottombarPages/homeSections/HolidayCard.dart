import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_project/extras/globalFunctions.dart';
import 'package:hrms_project/network/apiservices.dart';
import 'package:hrms_project/network/models/holiday_Model.dart';
import 'package:hrms_project/provider/HolidayProvider.dart';
import 'package:hrms_project/screens/CalendarScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpcomingHolidayCard extends StatefulWidget {
  const UpcomingHolidayCard({Key? key}) : super(key: key);

  @override
  _UpcomingHolidayCardState createState() => _UpcomingHolidayCardState();
}

class _UpcomingHolidayCardState extends State<UpcomingHolidayCard> {


  List<HolidaysList?> holidays = [];


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
                    'Upcoming Holidays',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
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
                  return HolidayCard(holiday: holidays, index: index);
                },
              ),
            ],
          ),
        ),
        onTap: (){
          openPage(context, CalendarScreen());
        },
      ),
    );
  }

  @override
  void initState() {
    _getHolidays();
    super.initState();
  }

  HolidayModel? _holidayModel;

  void _getHolidays() async {
    var prefs = await SharedPreferences.getInstance();
    _holidayModel = (await ApiService().holidayCalander(prefs.get('userid')));
    setState(() {
      Provider.of<HolidayProvider>(context, listen: false).setHolidayData(_holidayModel!);
      holidays = _holidayModel!.result!.holidaysList!;

    });

  }
}

class HolidayCard extends StatelessWidget {
  final List<HolidaysList?> holiday;
  final index;
  const HolidayCard({super.key, required this.holiday, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Flexible(child: Text(
                  holiday[index]!.name!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),),
                Container(
                  height: 40,
                  width: 40,
                  //top: -35,
                  child: Image.asset(
                    "assets/ic_flags.png",
                  ),
                ),
              ],
            ),
            Text(
              holiday[index]!.startDate!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
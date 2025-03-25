import 'package:flutter/material.dart';
import 'package:hrms_project/extras/globalFunctions.dart';
import 'package:hrms_project/network/apiservices.dart';
import 'package:hrms_project/network/models/attendance_Model.dart';
import 'package:hrms_project/network/models/holiday_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {

  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<String>> events = {};
  var presents ='00', absents = '00', leaves = '00', weekoffs = '00', holidays = '00';

  @override
  void initState() {
    _getHolidays();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {Navigator.pop(context);},
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Attendance Info', style: TextStyle(color: Colors.white, fontSize: 20),),

      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/background.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.10), BlendMode.dstATop),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child:  TableCalendar(
                  focusedDay: _focusedDay,
                  firstDay: DateTime(2020, 1, 1),
                  lastDay: DateTime(2030, 12, 31),
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false, // Hide the FormatButton
                  ),
                  eventLoader: (day) {
                    DateTime normalizedDay = DateTime(day.year, day.month, day.day);
                    return events[normalizedDay] ?? [];
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      if (events.isNotEmpty) {
                        return Positioned(
                          bottom: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: events.map((event) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _getEventColor(event.toString()),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                      _updateLegend(focusedDay);
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              _buildLegendItem(Colors.green, "Total Present", presents),
              _buildLegendItem(Colors.red, "Total Absent", absents),
              _buildLegendItem(Colors.orange, "Total Leaves", leaves),
              _buildLegendItem(Colors.grey, "WeekOffs", weekoffs),
              _buildLegendItem(Colors.blue, "Holidays", holidays),//

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label, String count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 6,
            backgroundColor: color,
          ),
          SizedBox(width: 8),
          Text(label),
          Spacer(),
          Text(count, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  AttendanceModel? _userModel;

  void _getHolidays() async {
    var prefs = await SharedPreferences.getInstance();
    _userModel = (await ApiService().attendanceInfo(prefs.get('userid')));
    setState(() {

      Map<String, List<String>> attendanceMap = {
        "Present": _userModel?.result?.present ?? [],
        "Weekend": _userModel?.result?.weekend ?? [],
        "Leave": _userModel?.result?.leave ?? [],
        "Holidays": _userModel?.result?.holidays ?? [],
        "Absent": _userModel?.result?.absent ?? [],
      };

      events.clear();

      presents = attendanceMap['Present']!.length.toString();
      absents = attendanceMap['Absent']!.length.toString();
      leaves = attendanceMap['Leave']!.length.toString();
      weekoffs = attendanceMap['Weekend']!.length.toString();
      holidays = attendanceMap['Holidays']!.length.toString();

      print(attendanceMap['Present']!.length);
      attendanceMap.forEach((type, dates) {
        for (String date in dates) {
          DateTime parsedDate = _parseDate(date);
          DateTime normalizedDate = DateTime(
              parsedDate.year, parsedDate.month, parsedDate.day);

          if (!events.containsKey(normalizedDate)) {
            events[normalizedDate] = [];
          }
          events[normalizedDate]!.add(type);
        }
      });

    });



  }

  DateTime _parseDate(String dateStr) {
    List<String> parts = dateStr.split('-');
    return DateTime(
      int.parse(parts[2]), // Year
      int.parse(parts[1]), // Month
      int.parse(parts[0]), // Day
    );
  }

  Color _getEventColor(String eventType) {
    switch (eventType) {
      case "Present":
        return Colors.green;
      case "Weekend":
        return Colors.blue;
      case "Leave":
        return Colors.orange;
      case "Holidays":
        return Colors.purple;
      case "Absent":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  List<String> _currentMonthEvents = [];
  void _updateLegend(DateTime focusedMonth) {
    print("Updating legend for month: ${focusedMonth.month}/${focusedMonth.year}");
    print("Current events: $events");

    DateTime startOfMonth = DateTime(focusedMonth.year, focusedMonth.month, 1);
    DateTime endOfMonth = DateTime(focusedMonth.year, focusedMonth.month + 1, 0);

    List<String> monthEvents = [];
    var _presents =0, _absents = 0, _leaves = 0, _weekoffs = 0, _holidays = 0;

    // Convert events.keys to a List<DateTime> and iterate with a for loop
    List<DateTime> eventDates = events.keys.toList();

    for (int i = 0; i < eventDates.length; i++) {
      DateTime date = eventDates[i];
      List<String> eventList = events[date]!; // Retrieve event list for the date
      DateTime normalizedDate = DateTime(date.year, date.month, date.day);


      if (normalizedDate.isAfter(startOfMonth.subtract(Duration(days: 1))) &&
          normalizedDate.isBefore(endOfMonth.add(Duration(days: 1)))) {



        if(eventList[0]=='Absent'){
          _absents++;
        }else if(eventList[0]=='Weekend'){
          _weekoffs++;
        }else if(eventList[0]=='Present'){
          _presents++;
        }else if(eventList[0]=='Leave'){
          _leaves++;
        }else {
          _holidays++;
        }

        monthEvents.addAll(eventList);
      }
    }

    setState(() {

      absents = _absents.toString();
      weekoffs = _weekoffs.toString();
      presents = _presents.toString();
      leaves = _leaves.toString();
      holidays = _holidays.toString();

      _currentMonthEvents = monthEvents.toSet().toList(); // Remove duplicates
    });

    print("Updated legend: $_currentMonthEvents");
  }







}

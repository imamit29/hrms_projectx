import 'package:flutter/material.dart';
import 'package:hrms_project/extras/globalFunctions.dart';
import 'package:hrms_project/network/apiservices.dart';
import 'package:hrms_project/network/models/holiday_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late CalendarFormat _calendarFormat;
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  Map<DateTime, List<String>> _events = {};

  @override
  void initState() {
    _calendarFormat = CalendarFormat.month;
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
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
        title: Text('Holiday Calendar', style: TextStyle(color: Colors.white, fontSize: 20),),

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
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = _normalizeDate(selectedDay);
                      _focusedDay = focusedDay;
                    });
                  },
                  eventLoader: (day) => _events[_normalizeDate(day)] ?? [],
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekendStyle: TextStyle(color: Colors.red),
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      if (events.isNotEmpty) {
                        return Positioned(
                          bottom: 5,
                          right: 5,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _events[DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day)] != null
                    ? ListView.builder(
                  itemCount: _events[DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day)]!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(_events[DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day)]![index]),
                        leading: Icon(Icons.event, color: Colors.blue),
                      ),
                    );
                  },
                )
                    : Center(child: Text("No holidays on this day")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  HolidayModel? _userModel;

  void _getHolidays() async {
    var prefs = await SharedPreferences.getInstance();
    _userModel = (await ApiService().holidayCalander(prefs.get('userid')));
    setState(() {

      List<HolidaysList>? holidays = _userModel?.result?.holidaysList;

      Map<DateTime, List<String>> parsedEvents = {};

      for (var holiday in holidays!) {
        DateTime date = _parseDate(holiday.startDate.toString());
        String holidayName = holiday.name.toString();

        if (parsedEvents.containsKey(date)) {
          parsedEvents[date]!.add(holidayName);
        } else {
          parsedEvents[date] = [holidayName];
        }
      }

      setState(() {
        _events = parsedEvents;
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

  /// Normalize Date (Removes Time Component)
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }


}

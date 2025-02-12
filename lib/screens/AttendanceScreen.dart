import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrms_project/extras/Constants.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AttendanceScreen extends StatefulWidget {
  AttendanceScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<_SalesData> chartData = [];
  String cdate = "",sMonth="",sYear="";
  List<String>dateStatus =[];
  List months = [
    'jan',
    'feb',
    'mar',
    'apr',
    'may',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec'
  ];
  bool _isLoading1 = false;
  final DateTime _currentDate = DateTime.now();
  DateTime _targetDateTime = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  static final Widget _eventIcon = Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.red, width: 2.0)),
    child: const Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  @override
  void initState() {
    var now = DateTime.now();
    int current_mon = now.month;
    //_calEvents(now.year, current_mon);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Color.fromRGBO(104, 131, 188, 1),
      todayTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Color.fromRGBO(104, 131, 188, 1),
      ),
      todayButtonColor: Colors.white,
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: true,
      weekendTextStyle: const TextStyle(
        color: Colors.black,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      isScrollable: false,
      markedDatesMap: _markedDateMap,
      height: 370.0,
      markedDateIconMaxShown: 1,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: const NeverScrollableScrollPhysics(),
      markedDateCustomTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.red,
      ),
      showHeader: false,
      selectedDayTextStyle: const TextStyle(
        color: Colors.yellow,
      ),
      minSelectedDate: _currentDate.subtract(const Duration(days: 5000)),
      maxSelectedDate: _currentDate.add(const Duration(days: 5000)),
      inactiveDaysTextStyle: const TextStyle(
        color: Color.fromRGBO(104, 131, 188, 1),
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        setState(() {
          _targetDateTime = date;
          DateFormat.yMMM().format(DateTime.now());
        });
      },
      onDayLongPressed: (DateTime date) {
      },
      onDayPressed: (date, events) {},
    );

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () {Navigator.pop(context);},
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title, style: TextStyle(color: Colors.white, fontSize: 20),),
        ),
        body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: const AssetImage("assets/back1.jpg"),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.2), BlendMode.dstATop),
        ),
        ),
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      _currentMonth,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    )),
                    TextButton(
                      child: const Text('PREV'),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(
                              _targetDateTime.year, _targetDateTime.month - 1);
                          _currentMonth =
                              DateFormat.yMMM().format(_targetDateTime);
                          dateStatus.clear();
                          // _calEvents(
                          //     _targetDateTime.year, _targetDateTime.month);
                        });
                      },
                    ),
                    TextButton(
                      child: const Text('NEXT'),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(
                              _targetDateTime.year, _targetDateTime.month + 1);
                          _currentMonth =
                              DateFormat.yMMM().format(_targetDateTime);
                          dateStatus.clear();
                          // _calEvents(
                          //     _targetDateTime.year, _targetDateTime.month);
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: calendarCarouselNoHeader,
              ),
              _isLoading1 == true?
                  Center(
                    child: CircularProgressIndicator(),
                  ):
              Column(
                children: [
                  dateStatus.length>0?
                  SizedBox(
                    height: 200,
                    child: SfCircularChart(
                        backgroundColor: Colors.white,
                        onDataLabelRender: (DataLabelRenderArgs args) {
                          double value = double.parse(args.text);
                          args.text = value.toStringAsFixed(0);
                        },
                        legend: Legend(
                          iconHeight: 10,
                          position: LegendPosition.right,
                          isVisible: true,
                          toggleSeriesVisibility: true,
                          iconWidth: 10,
                        ),
                        series: <CircularSeries<_SalesData, String>>[
                          PieSeries<_SalesData, String>(
                            legendIconType: LegendIconType.circle,
                            selectionBehavior:
                            SelectionBehavior(enable: true),
                            explode: false,
                            dataSource: chartData,
                            pointColorMapper: (_SalesData data, _) =>
                            data.color,
                            xValueMapper: (_SalesData sales, _) =>
                            sales.year,
                            yValueMapper: (_SalesData sales, _) =>
                            sales.sales,
                            name: 'Attendance',
                            explodeGesture: ActivationMode.singleTap,
                            dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                            ),
                          )
                        ]),
                  ):
                  Text(""),
                  Divider(),
                  dateStatus.length>0?
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(children: const [
                      Expanded(
                        flex: 1,
                        child: Text("Date",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text("Status",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ]),
                  ):
                  Text(""),
                  dateStatus.length>0
                      ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dateStatus.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => Container(
                      child: Padding(padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: [
                            Expanded(flex: 1,child: Text("${dateStatus[index].split("-")[0]} $sMonth $sYear",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal)),),
                            Expanded(flex: 1,child: Text(eventType(dateStatus[index].split("-")[1]),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal)),),
                          ],
                        ),),
                    ),
                  )
                      :  Center(
                    child: Text('Ro Record'),
                  ),
                ],
              )
            ],
          ),
        )));
  }


  showError(var msg) {
    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromRGBO(104, 131, 188, 1),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  String monthName(String month) {
    if (month == "1") {
      month = "January";
    }
    if (month == "2") {
      month = "February";
    }
    if (month == "3") {
      month = "March";
    }
    if (month == "4") {
      month = "April";
    }
    if (month == "5") {
      month = "May";
    }
    if (month == "6") {
      month = "June";
    }
    if (month == "7") {
      month = "July";
    }
    if (month == "8") {
      month = "August";
    }
    if (month == "9") {
      month = "September";
    }
    if (month == "10") {
      month = "October";
    }
    if (month == "11") {
      month = "November";
    }
    if (month == "12") {
      month = "December";
    }

    return month;
  }

  String eventType(String type) {
    if (type == "A") {
      type = "Absent";
    }
    if (type == "P") {
      type = "Present";
    }
    if (type == "L") {
      type = "Leave";
    }
    if (type == "H") {
      type = "Holiday";
    }
    if (type == "ML") {
      type = "Medical Leave";
    }
    if (type == "PL") {
      type = "Preparation Leave";
    }

    return type;
  }

  final EventList<Event> _markedDateMap = EventList<Event>(
    events: {
      DateTime(2019, 2, 10): [
        Event(
          date: DateTime(2019, 2, 10),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        Event(
          date: DateTime(2019, 2, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        Event(
          date: DateTime(2019, 2, 10),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );
}

class _SalesData {
  _SalesData(this.year, this.sales, this.color);

  final String year;
  final double sales;
  final Color color;
}

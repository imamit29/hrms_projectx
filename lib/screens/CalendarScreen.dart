import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:shared_preferences/shared_preferences.dart';

class HolidayCalendar extends StatefulWidget {
  HolidayCalendar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HolidayCalendarState createState() => _HolidayCalendarState();
}

class _HolidayCalendarState extends State<HolidayCalendar> {
  var isAllEvent = false;

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
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  DateTime _targetDateTime = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  static Widget _eventIcon = Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Color.fromRGBO(104, 131, 188, 1), width: 2.0)),
    child: Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );
  var _isLoading1 = true;

  @override
  void initState() {
    var now = DateTime.now();
    int currentMon = now.month;
    print(months[currentMon - 1]);
    //_calEvents(now.year, currentMon);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.red,
      todayTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.red,
      ),
      todayButtonColor: Colors.white,
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.black,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      markedDatesMap: _markedDateMap,
      height: 350.0,
      markedDateIconMaxShown: 1,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      isScrollable: false,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Color.fromRGBO(104, 131, 188, 1),
      ),
      showHeader: false,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 5000)),
      maxSelectedDate: _currentDate.add(Duration(days: 5000)),
      inactiveDaysTextStyle: TextStyle(
        color: Color.fromRGBO(104, 131, 188, 1),
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          DateFormat.yMMM().format(DateTime.now());
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
      onDayPressed: (date, events) {
        List<String> sdate = date.toString().split(" ");
        String cdate = sdate[0];
        print(cdate);
        _currentDate2 = date;

        // List<CalendarModel> templist = [];
        //
        // for (int i = 0; i < _userModel!.length; i++) {
        //   print(cdate + " -- " + _userModel![i].date.toString());
        //
        //   if (cdate == _userModel![i].date) {
        //     templist.add(_userModel![i]);
        //   }
        // }
        // setState(() {
        //   homeworklist = templist;
        // });
      },
    );

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () {Navigator.pop(context);},
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title, style: TextStyle(color: Colors.white, fontSize: 20),),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  isAllEvent==true?
                  Icons.calendar_month_rounded:
                  Icons.list,
                  color: Colors.white,
                ),
                onPressed: () {

                 setState(() {
                   isAllEvent==true?
                   isAllEvent = false:
                   isAllEvent=true;
                  // _calEvents(2022, DateTime.now().month);
                 });


                 _currentDate = DateTime.now();
                 _currentDate2 = DateTime.now();
                 _targetDateTime = DateTime.now();
                 _currentMonth = DateFormat.yMMM().format(DateTime.now());



                }
            ),

          ],
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
              isAllEvent==false?
              _calendar(_calendarCarouselNoHeader):
              Container(),
              // _isLoading1
              //     ?  Center(
              //         child: isAllEvent==true?
              //         LinearProgressIndicator():
              //   CircularProgressIndicator(),
              //       )
              //     : _homework() //
            ],
          ),
        )));
  }

  // List<CalendarModel>? _userModel;
  //
  // void _calEvents(int year, int month) async {
  //
  //   _isLoading1 = true;
  //
  //
  //   var prefs = await SharedPreferences.getInstance();
  //   String schid = prefs.getString("schid").toString();
  //   String secid = prefs.getString("secId").toString();
  //
  //   String syear="",smonth="";
  //
  //   if(isAllEvent == false){
  //
  //     syear = year.toString();
  //     smonth = month.toString();
  //
  //
  //   }else{
  //
  //     syear = "all";
  //     smonth = "0";
  //   }
  //
  //
  //
  //   _userModel = (await ApiService().calendar(secid, schid, syear, smonth));
  //
  //   setState(() async {
  //     await Future.delayed(const Duration(seconds: 0))
  //         .then((value) => setState(() async {
  //               _isLoading1 = false;
  //               setState(() {
  //                 _markedDateMap.clear();
  //                 List<CalendarModel> list = _userModel!;
  //                 homeworklist = list;
  //                 for (int i = 0; i < list.length; i++) {
  //                   List<String> dates = list[i].date.toString().split("-");
  //
  //                   _markedDateMap.add(
  //                       DateTime(int.parse(dates[0]), int.parse(dates[1]),
  //                           int.parse(dates[2])),
  //                       Event(
  //                           date: DateTime(int.parse(dates[0]), int.parse(dates[1]),
  //                               int.parse(dates[2])),
  //                           dot: list[i].type.toString().toLowerCase() == "PTM".toLowerCase()
  //                               ? const Icon(
  //                             Icons.brightness_1,
  //                             color: Colors.green,
  //                             size: 10,
  //                           )
  //                               : list[i].type.toString().toLowerCase() == "EXAM".toLowerCase()
  //                               ? const Icon(
  //                             Icons.brightness_1,
  //                             color: Colors.red,
  //                             size: 10,
  //                           )
  //                               : list[i].type.toString().toLowerCase() == "HOLIDAY".toLowerCase()
  //                               ? const Icon(
  //                             Icons.brightness_1,
  //                             color: Colors.yellow,
  //                             size: 10,
  //                           )
  //                               : list[i].type.toString().toLowerCase() == "EVENT".toLowerCase()
  //                               ? const Icon(
  //                             Icons.brightness_1,
  //                             color: Colors.orange,
  //                             size: 10,
  //                           )
  //
  //                               : list[i].type.toString().toLowerCase() == "OTHER".toLowerCase()
  //                               ? const Icon(
  //                             Icons.brightness_1,
  //                             color: Color.fromRGBO(104, 131, 188, 1),
  //                             size: 10,
  //                           )
  //                               : const Icon(
  //                             Icons.brightness_1,
  //                             color:
  //                             Color.fromRGBO(104, 131, 188, 1),
  //                             size: 10,
  //                           )));
  //                 }
  //               });
  //             }));
  //   });
  // }

  Widget _calendar(CalendarCarousel<Event> calendarCarouselNoHeader) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                    _currentMonth,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  )),
              TextButton(
                child: Text('PREV'),
                onPressed: () {
                  setState(() {
                    _targetDateTime = DateTime(
                        _targetDateTime.year, _targetDateTime.month - 1);
                    _currentMonth =
                        DateFormat.yMMM().format(_targetDateTime);

                    // _calEvents(
                    //     _targetDateTime.year, _targetDateTime.month);
                  });
                },
              ),
              TextButton(
                child: Text('NEXT'),
                onPressed: () {
                  setState(() {
                    // _targetDateTime = DateTime(
                    //     _targetDateTime.year, _targetDateTime.month + 1);
                    // _currentMonth =
                    //     DateFormat.yMMM().format(_targetDateTime);
                    //
                    // _calEvents(
                    //     _targetDateTime.year, _targetDateTime.month);
                  });
                },
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: calendarCarouselNoHeader,
        ),
      ],
    );
  }

  // Widget _homework() {
  //   return Column(
  //     children: [
  //       homeworklist.isNotEmpty
  //           ? Container(
  //               margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
  //               child: ListView.builder(
  //                 shrinkWrap: true,
  //                 physics: const NeverScrollableScrollPhysics(),
  //                 itemCount: homeworklist.length,
  //                 scrollDirection: Axis.vertical,
  //                 itemBuilder: (context, index) => Container(
  //                   child: InkWell(
  //                     child: Card(
  //                         elevation: 1,
  //                         shape: const RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.only(
  //                               bottomRight: Radius.circular(5),
  //                               topRight: Radius.circular(5),
  //                               bottomLeft: Radius.circular(5),
  //                               topLeft: Radius.circular(5)),
  //                         ),
  //                         child: Row(
  //                           children: [
  //                             Expanded(
  //                                 flex: 2,
  //                                 child: Padding(
  //                                     padding: const EdgeInsets.all(1),
  //                                     child: Container(
  //                                       color: Colors.grey[100],
  //                                       child: Column(
  //                                         children: [
  //                                           Padding(
  //                                               padding: const EdgeInsets.only(
  //                                                   top: 5),
  //                                               child: Text(
  //                                                   homeworklist[index]
  //                                                       .day
  //                                                       .toString(),
  //                                                   maxLines: 2,
  //                                                   style: const TextStyle(
  //                                                       color: Colors.black,
  //                                                       fontSize: 18,
  //                                                       fontWeight:
  //                                                           FontWeight.bold))),
  //                                           Container(
  //                                             height: 25,
  //                                             margin: EdgeInsets.only(top: 5),
  //                                             alignment: Alignment.center,
  //                                             color: homeworklist[index]
  //                                                         .type!
  //                                                         .toUpperCase() ==
  //                                                     "EVENT"
  //                                                 ? Colors.orange[300]
  //                                                 : homeworklist[index]
  //                                                             .type!
  //                                                             .toUpperCase() ==
  //                                                         "EXAM"
  //                                                     ? Colors.red[400]
  //                                                     : homeworklist[index]
  //                                                                 .type!
  //                                                                 .toUpperCase() ==
  //                                                             "PTM"
  //                                                         ? Colors.green[400]
  //                                                         : homeworklist[index]
  //                                                                     .type!
  //                                                                     .toUpperCase() ==
  //                                                                 "HOLIDAY"
  //                                                             ? Colors.yellow
  //                                                             : Colors.yellow[300],
  //                                             child: Padding(
  //                                               padding: EdgeInsets.all(0),
  //                                               child: Text(
  //                                                   monthName(
  //                                                       homeworklist[index]
  //                                                           .month
  //                                                           .toString()).toUpperCase(),
  //                                                   maxLines: 1,
  //                                                   style: TextStyle(
  //                                                       color:
  //                                                       Colors.black,
  //                                                       fontSize: 12,
  //                                                       fontWeight:
  //                                                           FontWeight.normal)),
  //                                             ),
  //                                           ),
  //                                           Container(
  //                                               height: 25,
  //                                               alignment: Alignment.center,
  //                                               width: double.infinity,
  //                                               child: Padding(
  //                                                   padding: EdgeInsets.all(5),
  //                                                   child: Text(
  //                                                       homeworklist[index]
  //                                                           .year
  //                                                           .toString(),
  //                                                       maxLines: 1,
  //                                                       style: const TextStyle(
  //                                                           color: Colors.black,
  //                                                           fontSize: 12,
  //                                                           fontWeight:
  //                                                               FontWeight
  //                                                                   .normal))))
  //                                         ],
  //                                       ),
  //                                     ))),
  //                             Expanded(
  //                                 flex: 9,
  //                                 child: Container(
  //                                   margin:
  //                                       EdgeInsets.symmetric(horizontal: 10),
  //                                   child: Column(
  //                                     children: [
  //                                       Stack(
  //                                         children: [
  //                                           Align(
  //                                               alignment: Alignment.topLeft,
  //                                               child: Text(
  //                                                   homeworklist[index]
  //                                                       .type
  //                                                       .toString(),
  //                                                   maxLines: 1,
  //                                                   style: const TextStyle(
  //                                                       color: Colors.black,
  //                                                       fontSize: 12,
  //                                                       fontWeight:
  //                                                           FontWeight.bold))),
  //                                           Container(
  //                                             child: Align(
  //                                                 alignment: Alignment.topRight,
  //                                                 child: Text(
  //                                                     homeworklist[index]
  //                                                         .time
  //                                                         .toString(),
  //                                                     maxLines: 1,
  //                                                     style: const TextStyle(
  //                                                         color: Colors.black,
  //                                                         fontSize: 12,
  //                                                         fontWeight: FontWeight
  //                                                             .normal))),
  //                                             margin:
  //                                                 EdgeInsets.only(right: 10),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                       Divider(
  //                                         thickness: 1,
  //                                       ),
  //                                       Align(
  //                                         alignment: Alignment.topLeft,
  //                                         child: Padding(
  //                                             padding: const EdgeInsets.only(
  //                                                 top: 5, bottom: 10),
  //                                             child: Text(
  //                                                 homeworklist[index]
  //                                                     .desc
  //                                                     .toString(),
  //                                                 maxLines: 3,
  //                                                 style: const TextStyle(
  //                                                     color: Colors.black,
  //                                                     fontSize: 14,
  //                                                     fontWeight:
  //                                                         FontWeight.normal))),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 )),
  //                           ],
  //                         )),
  //                   ),
  //                 ),
  //               ))
  //           : Center(
  //               child: const Text("This month doesn't have events.",
  //                   style: TextStyle(fontWeight: FontWeight.bold)),
  //             ),
  //     ],
  //   );
  // }

  String monthName(String month) {
    if (month == "1") {
      month = "Jan";
    }
    if (month == "2") {
      month = "Feb";
    }
    if (month == "3") {
      month = "Mar";
    }
    if (month == "4") {
      month = "April";
    }
    if (month == "5") {
      month = "May";
    }
    if (month == "6") {
      month = "Jun";
    }
    if (month == "7") {
      month = "July";
    }
    if (month == "8") {
      month = "Aug";
    }
    if (month == "9") {
      month = "Sept";
    }
    if (month == "10") {
      month = "Oct";
    }
    if (month == "11") {
      month = "Nov";
    }
    if (month == "12") {
      month = "Dec";
    }

    return month;
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

  EventList<Event> _markedDateMap = EventList<Event>(
    events: {
      DateTime(2019, 2, 10): [
        Event(
          date: DateTime(2019, 2, 10),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
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

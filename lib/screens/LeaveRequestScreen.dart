import 'package:flutter/material.dart';
import 'package:hrms_project/extras/globalFunctions.dart';
import 'package:hrms_project/network/apiservices.dart';
import 'package:hrms_project/network/models/leaveSubmit_Model.dart';
import 'package:hrms_project/network/models/leaveType_Model.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LeaveRequestScreen extends StatefulWidget {
  @override
  _LeaveRequestScreenState createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  int leaveType = 0;
  String selectedDay = "Full Day";
  List<String> leaveTypes = [];
  List<String> leaveTypesId = [];
  TextEditingController _comment = TextEditingController();
  TextEditingController _startDate= TextEditingController();
  TextEditingController _endDate= TextEditingController();

  @override
  void initState() {
    _getLeaveType();
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
          title: Text("Leave Request", style: TextStyle(color: Colors.white, fontSize: 20),)),
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
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                'Select Dates',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      child: TextFormField(
                        controller: _startDate,
                        decoration: InputDecoration(labelText: "From*",
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(
                                    Radius.circular(
                                        10.0))),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0), // Inactive Border
                              borderRadius: BorderRadius.circular(10),
                            ),
                            ),
                        enabled: false,
                        autofocus: false,
                      ),
                      onTap: (){
                        _startDatePicker(context, _startDate);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      child: TextFormField(
                        controller: _endDate,
                        decoration: InputDecoration(labelText: "To*",
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(
                                  Radius.circular(
                                      10.0))),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0), // Inactive Border
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        enabled: false,
                        autofocus: false,
                      ),
                      onTap: (){
                        _endDatePicker(context, _endDate);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Select Leave Type*',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Radio(
                    value: "Full Day",
                    groupValue: selectedDay,
                    onChanged: (value) {
                      setState(() {
                        selectedDay = value.toString();
                      });
                    },
                  ),
                  Text("Full Day"),
                  Radio(
                    value: "First Half",
                    groupValue: selectedDay,
                    onChanged: (value) {
                      setState(() {
                        selectedDay = value.toString();
                      });
                    },
                  ),
                  Text("First half"),
                  Radio(
                    value: "Second Half",
                    groupValue: selectedDay,
                    onChanged: (value) {
                      setState(() {
                        selectedDay = value.toString();
                      });
                    },
                  ),
                  Text("Second half"),
                ],
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: "Type of leaves*",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0), // Inactive Border
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0), // Active Border
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5), // Error Border
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0), // Focused Error Border
                      borderRadius: BorderRadius.circular(10),
                    )),
                items:
                leaveTypes.map((String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    for (var value in _leaveTypeModel!.leaveTypes!) {
                      if(value.leaveTypeName==newValue){
                        leaveType = value.leaveTypeId!;
                        break;
                      }
                    }
                    print(leaveType);
                  });
                },
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              TextFormField(
                controller: _comment,
                decoration: InputDecoration(
                    labelText: "Comments*",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0), // Inactive Border
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0), // Active Border
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5), // Error Border
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0), // Focused Error Border
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _getLeaveSubmit();

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text("SUBMIT", style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  LeaveTypeModel? _leaveTypeModel;

  void _getLeaveType() async {
    var prefs = await SharedPreferences.getInstance();
    _leaveTypeModel = (await ApiService().leaveType(prefs.get('userid')));
    setState(() {
      for (var value in _leaveTypeModel!.leaveTypes!) {
        leaveTypes.add('${value.leaveTypeName.toString()}');
        leaveTypesId.add(value.leaveTypeId.toString());
        // (${value.leaveTypeId.toString()})
      }
    });
  }

  LeaveSubmitModel? _leaveSubmitModel;

  void _getLeaveSubmit() async {
    showLoaderDialog(context, 'Applying...');
    DateFormat outputFormat = DateFormat("yyyy-MM-dd");
    DateTime parsedStartDate = DateFormat("dd-MM-yyyy").parse(_startDate.text);
    DateTime parsedEndDate = DateFormat("dd-MM-yyyy").parse(_endDate.text);
    String formattedStartDate = outputFormat.format(parsedStartDate);
    String formattedEndDate = outputFormat.format(parsedEndDate);

    var prefs = await SharedPreferences.getInstance();
    _leaveSubmitModel = (await ApiService().getleavesubmit(prefs.get('userid'), leaveType, formattedStartDate, formattedEndDate, _comment.text));
    Navigator.pop(context);
    setState(() {
      if(_leaveSubmitModel?.result?.message == 'Leave request successfully created'){
        onAlert(context, 'Leave Applied', _leaveSubmitModel?.result?.message, AlertType.success);
        _startDate.text = '';
        _endDate.text = '';
        _comment.text = '';
      }else{
        onAlert(context, 'Failed', _leaveSubmitModel?.result?.message, AlertType.error);
      }
    });
  }


  DateTime selectedDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  Future<void> _startDatePicker(
      BuildContext context,
      TextEditingController textController,
      ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      firstDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(2050, 1),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _endDate.text = "";
        final DateTime now = selectedDate;
        final DateFormat formatter = DateFormat('dd-MM-yyyy');
        final String formatted = formatter.format(now);
        print(formatted);
        String date = formatted;
        textController.text = date;
      });
    }
  }

  Future<void> _endDatePicker(
      BuildContext context,
      TextEditingController textController,
      ) async {
    List<String> sDate = _startDate.text.toString().split("-");
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(
          int.parse(sDate[2]), int.parse(sDate[1]), int.parse(sDate[0])),
      firstDate: DateTime(
          int.parse(sDate[2]), int.parse(sDate[1]), int.parse(sDate[0])),
      lastDate: DateTime(2050, 1),
    );
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;

        final DateTime now = selectedEndDate;
        final DateFormat formatter = DateFormat('dd-MM-yyyy');
        final String formatted = formatter.format(now);
        String date = formatted;
        textController.text = date;
      });
    }
  }

  String dateConverter(String date) {
    // Input date Format
    final format = DateFormat("dd-MM-yyyy");
    DateTime gettingDate = format.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    // Output Date Format
    final String formatted = formatter.format(gettingDate);
    return formatted;
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  List<String> split(String string, String separator, {int max = 0}) {
    var result = <String>[];

    if (separator.isEmpty) {
      result.add(string);
      return result;
    }

    while (true) {
      var index = string.indexOf(separator, 0);
      if (index == -1 || (max > 0 && result.length >= max)) {
        result.add(string);
        break;
      }

      result.add(string.substring(0, index));
      string = string.substring(index + separator.length);
    }

    return result;
  }
}

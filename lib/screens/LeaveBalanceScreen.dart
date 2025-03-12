import 'package:flutter/material.dart';
import 'package:hrms_project/network/apiservices.dart';
import 'package:hrms_project/network/models/leaveTypeBalModel.dart';
import 'package:hrms_project/network/models/leaveType_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaveBalanceScreen extends StatefulWidget {
  @override
  _LeaveBalanceScreenState createState() => _LeaveBalanceScreenState();
}

class _LeaveBalanceScreenState extends State<LeaveBalanceScreen> {

  final List<Map<String, dynamic>> leaveData = const [
    {'month': 'January', 'added': 0.75, 'subtracted': 1},
    {'month': 'February', 'added': 0.75, 'subtracted': 1},
    {'month': 'March', 'added': 0.75, 'subtracted': 1},
    {'month': 'April', 'added': 0.75, 'subtracted': 0},
    {'month': 'May', 'added': 1.75, 'subtracted': 1},
    {'month': 'June', 'added': 0.75, 'subtracted': 0},
    {'month': 'July', 'added': 0.75, 'subtracted': 1},
    {'month': 'August', 'added': 0.75, 'subtracted': 1},
    {'month': 'September', 'added': 0.75, 'subtracted': 1},
    {'month': 'October', 'added': 0.75, 'subtracted': 0},
    {'month': 'November', 'added': 1.75, 'subtracted': 1},
    {'month': 'December', 'added': 0.75, 'subtracted': 0},
  ];

  String selectedValue = 'Casual Leave/Sick Leave'; // Initial selected value

  List<String> items = ['Casual Leave/Sick Leave', 'Compensatory Off (CO)', 'Privilege Leave (PL)'];

  var isLoading = true;

  @override
  void initState() {
    _getLeaveType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Leave Balance', style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {Navigator.pop(context);},
        ),
      ),
      body: isLoading?Center(child: CircularProgressIndicator(),):Container(
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
            children: [
              Align(
                alignment: Alignment.topRight,
                child: DropdownButton<String>(
                  value: selectedValue,
                  icon: Icon(Icons.arrow_drop_down),
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  items: items.map<DropdownMenuItem<String>>((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: leaveData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Card(
                        child: ExpansionTile(
                          title: Text(leaveData[index]['month']),
                          children: [
                            ListTile(
                              title: Text('Balance Added: ${leaveData[index]['added']}'),
                            ),
                            ListTile(
                              title: Text('Balance Subtracted: ${leaveData[index]['subtracted']}'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  LeaveTypeBalModel? _leaveTypeBalModel;

  void _getLeaveType() async {
    var prefs = await SharedPreferences.getInstance();
    _leaveTypeBalModel = (await ApiService().leaveTypeBal(prefs.get('userid')));
    isLoading = false;
    setState(() {
      print(_leaveTypeBalModel);
    });
  }
}
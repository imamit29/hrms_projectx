import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_project/extras/globalFunctions.dart';
import 'package:hrms_project/screens/ApplyRegurlarizationScreen.dart';
import 'package:hrms_project/screens/AttendanceScreen.dart';
import 'package:hrms_project/screens/CalendarScreen.dart';
import 'package:hrms_project/screens/ExpenseScreen.dart';
import 'package:hrms_project/screens/LeaveBalanceScreen.dart';
import 'package:hrms_project/screens/LeaveRequestScreen.dart';
import 'package:hrms_project/screens/PaySlipScreen.dart';

class ActionPage extends StatefulWidget {
  const ActionPage({Key? key}) : super(key: key);

  @override
  _ActionPageState createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {

  final List<Map<String, dynamic>> actions = [
    {'icon': Icons.mouse, 'title': 'Apply Regularization', 'color': Colors.blue[100]},
    {'icon': Icons.info_outline, 'title': 'Attendance Info', 'color': Colors.blue[100]},
    {'icon': Icons.local_cafe, 'title': 'Apply Leave', 'color': Colors.cyan[100]},
    {'icon': Icons.currency_rupee, 'title': 'Add Expanse', 'color': Colors.cyan[100]},
    {'icon': Icons.view_module, 'title': 'Leave Balance', 'color': Colors.cyan[100]},
    {'icon': Icons.calendar_today, 'title': 'Holiday Calendar', 'color': Colors.cyan[100]},
    {'icon': Icons.receipt, 'title': 'Payslips', 'color': Colors.orange[100]},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(margin: EdgeInsets.only(left: 5),
              child: Text(
                'Actions',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: actions.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: actions[index]['color'],
                    child: ListTile(
                      leading: Icon(actions[index]['icon'], color: Colors.black54),
                      title: Text(
                        actions[index]['title'],
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        if(actions[index]['title'] == 'Payslips'){
                          openPage(context, PayslipScreen());
                        }else if(actions[index]['title'] == 'Apply Regularization'){
                          openPage(context, ApplyRegularizationScreen());
                        }else if(actions[index]['title'] == 'Add Expanse'){
                          openPage(context, ExpanseScreen());
                        }else if(actions[index]['title'] == 'Apply Leave'){
                          openPage(context, LeaveRequestScreen());
                        }else if(actions[index]['title'] == 'Attendance Info'){
                          openPage(context, AttendanceScreen());
                        }else if(actions[index]['title'] == 'Holiday Calendar'){
                          openPage(context, CalendarScreen());
                        }else if(actions[index]['title'] == 'Leave Balance'){
                          openPage(context, LeaveBalanceScreen());
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
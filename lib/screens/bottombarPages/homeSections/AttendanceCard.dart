import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AttendanceCard extends StatefulWidget {
  const AttendanceCard({Key? key}) : super(key: key);

  @override
  _AttendanceCardState createState() => _AttendanceCardState();
}

class _AttendanceCardState extends State<AttendanceCard> {


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Who Is In',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                Icon(Icons.open_in_new, color: Colors.grey),
              ],
            ),
            SizedBox(height: 40),
            SizedBox(
              height: 100,
              width: 100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          color: Colors.green,
                          value: 4,
                          radius: 20,
                        ),
                        PieChartSectionData(
                          color: Colors.orange,
                          value: 1,
                          radius: 20,
                        ),
                        PieChartSectionData(
                          color: Colors.red,
                          value: 1,
                          radius: 20,
                        ),
                        PieChartSectionData(
                          color: Colors.grey,
                          value: 2,
                          radius: 20,
                        ),
                      ],
                      centerSpaceRadius: 40,
                      sectionsSpace: 2,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Text(
                        '5',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text('Teammates', style: TextStyle(color: Colors.grey, fontSize: 10)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LegendItem(color: Colors.green, label: 'On Time', count: '04'),
                LegendItem(color: Colors.orange, label: 'Late In', count: '01'),
                LegendItem(color: Colors.red, label: 'Not Yet In', count: '01'),
                LegendItem(color: Colors.grey, label: 'On Leave', count: '02'),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<PieChartSectionData> _chartSections() {
  return [
    PieChartSectionData(
      color: Colors.redAccent,
      value: 20,
      radius: 20,
      title: '',
    ),
    PieChartSectionData(
      color: Colors.teal,
      value: 80,
      radius: 20,
      title: '',
    ),
  ];
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String count;

  const LegendItem({required this.color, required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration:  BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(60),
                left: Radius.circular(60),
              ),
              color: color),
          height: 5,
          width: 15,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 2),
          child: Text(label, style: TextStyle(color: Colors.grey, fontSize: 12)),
        ),
        Text(count, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
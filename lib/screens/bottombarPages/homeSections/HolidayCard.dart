import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpcomingHolidayCard extends StatefulWidget {
  const UpcomingHolidayCard({Key? key}) : super(key: key);

  @override
  _UpcomingHolidayCardState createState() => _UpcomingHolidayCardState();
}

class _UpcomingHolidayCardState extends State<UpcomingHolidayCard> {


  final List<Map<String, String>> holidays = const [
    {"date": "2 Feb", "name": "Vasant Panchami", "day": "Sunday"},
    {"date": "14 Feb", "name": "Shab-e-barat", "day": "Friday"},
    {"date": "26 Feb", "name": "Maha Shivratri", "day": "Wednesday"},
    {"date": "13 Mar", "name": "Holi", "day": "Thursday"},
  ];

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
              itemCount: holidays.length,
              itemBuilder: (context, index) {
                return HolidayCard(holiday: holidays[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HolidayCard extends StatelessWidget {
  final Map<String, String> holiday;
  const HolidayCard({super.key, required this.holiday});

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
                Text(
                  holiday['date']!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                Positioned(
                  left: 0,
                  //top: -35,
                  child: Image.asset(
                    "assets/ic_flags.png",
                    width: 50,
                  ),
                ),
              ],
            ),
            Text(
              holiday['name']!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            Text(
              holiday['day']!,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
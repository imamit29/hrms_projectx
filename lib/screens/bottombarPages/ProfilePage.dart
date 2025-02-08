import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Samuel Alex',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              'Team Manager',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.edit, size: 16, color: Colors.white,),
              label: Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            _buildInfoCard('Personal Information', [
              Divider(height: 1, color: Colors.black, thickness: 0.1,),
              Divider(height: 5,),
              _buildInfoRow('First Name', 'Samuel'),
              _buildInfoRow('Last Name', 'Alex'),
              _buildInfoRow('Employee Code', 'HRSAM123'),
              _buildInfoRow('Date Of Birth', '12-10-1998'),
              _buildInfoRow('Gender', 'Male'),
              _buildInfoRow('Blood Group', 'B+'),
            ]),
            SizedBox(height: 10),
            _buildInfoCard('Employment Status & Type', [
              Divider(height: 1, color: Colors.black, thickness: 0.1,),
              Divider(height: 5,),
              _buildInfoRow('Date Of Joining', '15-10-2022'),
              _buildInfoRow('Date Of Retirement', '15-10-2060'),
              _buildInfoRow('Employement Type', 'Permanent'),
              _buildInfoRow('Employement Status', 'Confirmed'),
              _buildInfoRow('Date Of Confirmation', '15-10-2022'),
              _buildInfoRow('Employment Status', 'Active', isActive: true),
            ]),
            SizedBox(height: 10),
            _buildInfoCard('Position Details', [
              Divider(height: 1, color: Colors.black, thickness: 0.1,),
              Divider(height: 5,),
              _buildInfoRow('Company Name', 'SRS Tech'),
              _buildInfoRow('Department', 'Software'),
              _buildInfoRow('Branch', 'Gurugram(A)'),
              _buildInfoRow('Designation', 'Developer'),
              _buildInfoRow('Grade', 'A1'),
              _buildInfoRow('Reporting Manager', 'Rohan Singh'),
              _buildInfoRow('functional manager', 'Prem D'),

            ]),
          ],
        ),
      ),
    );
  }
}

Widget _buildInfoCard(String title, List<Widget> children) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Divider(),
          ...children,
        ],
      ),
    ),
  );
}

Widget _buildInfoRow(String label, String value, {bool isActive = false}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isActive ? Colors.green : Colors.black,
          ),
        ),
      ],
    ),
  );
}
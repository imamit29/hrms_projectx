import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_project/extras/globalFunctions.dart';
import 'package:hrms_project/network/apiservices.dart';
import 'package:hrms_project/network/models/profile_Model.dart';
import 'package:hrms_project/provider/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final apiResponse = Provider.of<UserProvider>(context).profileData;
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
              apiResponse.result!.data!.personalInformation!.firstName!,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            // Text(
            //   'Team Manager',
            //   style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            // ),
            SizedBox(height: 10),
            // ElevatedButton.icon(
            //   onPressed: () {},
            //   icon: Icon(Icons.edit, size: 16, color: Colors.white,),
            //   label: Text('Edit Profile'),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.blue,
            //     foregroundColor: Colors.white,
            //   ),
            // ),
            // SizedBox(height: 20),
            _buildInfoCard('Personal Information', [
              Divider(height: 1, color: Colors.black, thickness: 0.1,),
              Divider(height: 5,),
              _buildInfoRow('Name', apiResponse.result!.data!.personalInformation!.firstName!),
              _buildInfoRow('Employee Code', apiResponse.result!.data!.personalInformation!.empCode!),
              apiResponse.result!.data!.personalInformation!.dob!?_buildInfoRow('Date Of Birth', '12-10-1998'):Container(),
              _buildInfoRow('Gender', apiResponse.result!.data!.personalInformation!.gender!),
              _buildInfoRow('Blood Group', apiResponse.result!.data!.personalInformation!.bloodGroup!),
            ]),
            SizedBox(height: 10),
            _buildInfoCard('Employment Status & Type', [
              Divider(height: 1, color: Colors.black, thickness: 0.1,),
              Divider(height: 5,),
              _buildInfoRow('Date Of Joining', apiResponse.result!.data!.employementStatus!.joiningDate!),
              //_buildInfoRow('Date Of Retirement', '15-10-2060'),
              _buildInfoRow('Employee Type', apiResponse.result!.data!.employementStatus!.empType!),
              //_buildInfoRow('Employement Status', 'Confirmed'),
              _buildInfoRow('Date Of Confirmation', apiResponse.result!.data!.employementStatus!.dateOfConfirmation!),
              _buildInfoRow('Employment Status', apiResponse.result!.data!.employementStatus!.empStatus!, isActive: true),
            ]),
            SizedBox(height: 10),
            _buildInfoCard('Position Details', [
              Divider(height: 1, color: Colors.black, thickness: 0.1,),
              Divider(height: 5,),
              _buildInfoRow('Company Name', apiResponse.result!.data!.positionDetails!.companyName!),
              _buildInfoRow('Department', apiResponse.result!.data!.positionDetails!.department!),
              apiResponse.result!.data!.positionDetails!.branch!?_buildInfoRow('Branch', 'Gurugram(A)'):Container(),
              _buildInfoRow('Designation', apiResponse.result!.data!.positionDetails!.designation!),
              _buildInfoRow('Grade', apiResponse.result!.data!.positionDetails!.grade!),
              _buildInfoRow('Reporting Manager', apiResponse.result!.data!.positionDetails!.rM!),
              _buildInfoRow('functional manager', apiResponse.result!.data!.positionDetails!.fM!),

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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PayslipScreen extends StatefulWidget {
  @override
  _PayslipScreenState createState() => _PayslipScreenState();
}

class _PayslipScreenState extends State<PayslipScreen> {

  String selectedValue = 'Select Month'; // Initial selected value

  List<String> items = ['Select Month', 'Apr 2024', 'May 2024', 'Jun 2024', 'Jul 2024', 'Aug 2024', 'Sep 2024', 'Oct 2024', 'Nov 2024', 'Dec 2024', 'Jan 2025', 'Feb 2025', 'Mar 2025'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Payslips', style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {Navigator.pop(context);},
        ),
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
              SizedBox(height: 16),
              PayslipCard(title: 'Payslip', amount: '₹80,000.00'),
              // SizedBox(height: 16),
              // PayslipCard(title: 'Reimbursement Payslip', amount: '₹80,000.00'),
              // SizedBox(height: 16),
              // PayslipCard(title: 'CTC Payslip', amount: '₹12,40,000.00'),
            ],
          ),
        ),
      ),
    );
  }
}

class PayslipCard extends StatelessWidget {
  final String title;
  final String amount;

  PayslipCard({required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(amount, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Image.asset(
                    'assets/payslipvector.png', // Replace with actual image asset
                    width: 50,
                    height: 50,
                    //fit: BoxFit.contain,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: () {}, child: Text('View', style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),),
                SizedBox(width: 8),
                ElevatedButton(onPressed: () {}, child: Text('Download',style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

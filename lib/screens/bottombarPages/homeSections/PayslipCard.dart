import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PayslipCard extends StatefulWidget {
  @override
  _PayslipCardState createState() => _PayslipCardState();
}

class _PayslipCardState extends State<PayslipCard> {
  bool _showSalary = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Payslip",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 16),
                    Container(
                        margin: EdgeInsets.only(right: 0),
                        child: Icon(Icons.open_in_new, color: Colors.grey)),
                    const SizedBox(height: 16),
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: const Text(
                        "Dec 2024",
                        style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 10,
                  top: -35,
                  child: Image.asset(
                    "assets/ic_piggy_bank.png",
                    width: 50,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(4, 46, 62, 0.10),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Net Pay",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      Text(
                        _showSalary ? "₹50,000" : "₹*****",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Gross Pay",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black54)),
                              Text(
                                _showSalary ? "₹60,000" : "₹*****",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Deductions",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black54)),
                              Text(
                                _showSalary ? "₹10,000" : "₹*****",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.download, color: Colors.blue),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Show Salary", style: TextStyle(color: Colors.grey),),
                const SizedBox(width: 16),
                Switch(
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey[300],
                  value: _showSalary,
                  onChanged: (value) {
                    setState(() {
                      _showSalary = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';


class LeaveRequestScreen extends StatefulWidget {
  @override
  _LeaveRequestScreenState createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  String leaveType = "";
  String selectedDay = "Full Day";
  TextEditingController commentsController = TextEditingController();

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
                    child: TextFormField(
                      initialValue: "07/02/2025",
                      decoration: InputDecoration(labelText: "From*",
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
                      readOnly: true,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      initialValue: "07/02/2025",
                      decoration: InputDecoration(labelText: "To*",
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
                      readOnly: true,
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
                items: ["Privilege Leave", "Casual Leave/Sick Leave", "Compensatory Off"]
                    .map((String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    leaveType = newValue!;
                  });
                },
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              TextFormField(
                controller: commentsController,
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
                  onPressed: () {},
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
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ApplyRegularizationScreen extends StatefulWidget {
  @override
  _ApplyRegularizationScreenState createState() => _ApplyRegularizationScreenState();
}

class _ApplyRegularizationScreenState extends State<ApplyRegularizationScreen> {
  String selectedOption = 'Both';
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
  TextEditingController startHoursController = TextEditingController();
  TextEditingController startMinutesController = TextEditingController();
  TextEditingController endHoursController = TextEditingController();
  TextEditingController endMinutesController = TextEditingController();
  TextEditingController commentsController = TextEditingController();

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedFromDate)
      setState(() {
        selectedFromDate = picked;
      });
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedToDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedToDate)
      setState(() {
        selectedToDate = picked;
      });
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
        title: Text('Apply Regularization', style: TextStyle(fontSize: 20,color: Colors.white),),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Your Choice',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Radio(
                    value: "Forgot In",
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value.toString();
                      });
                    },
                  ),
                  Text("Forgot In"),
                  Radio(
                    value: "Forgot Out",
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value.toString();
                      });
                    },
                  ),
                  Text("Forgot Out"),
                  Radio(
                    value: "Both",
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value.toString();
                      });
                    },
                  ),
                  Text("Both"),
                ],
              ),
              Text(
                'Select Date',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Text("From date: ",),
                  TextButton(
                    onPressed: () => _selectFromDate(context),
                    child: Text(DateFormat('dd/MM/yyyy').format(selectedFromDate)),
                  ),
                  Text("To date: "),
                  TextButton(
                    onPressed: () => _selectToDate(context),
                    child: Text(DateFormat('dd/MM/yyyy').format(selectedToDate)),
                  ),
                ],
              ),
              Text(
                'Select Start Time',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.all(5),
                      child: TextField(
                        style: TextStyle(fontSize: 12),
                        controller: startHoursController,
                        decoration: InputDecoration(
                          labelText: "Start Hours",
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
                          ),),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                      child: Container(
                        height: 40,
                        margin: EdgeInsets.all(5),
                        child: TextField(
                          style: TextStyle(fontSize: 12),
                          controller: startMinutesController,
                          decoration: InputDecoration(
                            labelText: "Start Minutes",
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
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),)
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Select End Time',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Row(
                children: [

                  Expanded(
                      child: Container(
                        height: 40,
                        margin: EdgeInsets.all(5),
                        child: TextField(
                          style: TextStyle(fontSize: 12),
                          controller: endHoursController,
                          decoration: InputDecoration(
                            labelText: "End Hours",
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
                            ),),
                          keyboardType: TextInputType.number,
                        ),)
                  ),
                  SizedBox(width: 10),
                  Expanded(
                      child: Container(
                        height: 40,
                        margin: EdgeInsets.all(5),
                        child: TextField(
                          style: TextStyle(fontSize: 12),
                          controller: endMinutesController,
                          decoration: InputDecoration(
                            labelText: "End Minutes",
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
                            ),),
                          keyboardType: TextInputType.number,
                        ),)
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Enter Comment',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.all(5),
                child: TextField(
                  style: TextStyle(fontSize: 14),
                  controller: commentsController,
                  decoration: InputDecoration(
                    labelText: "Comments",
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
                    ),),
                  maxLines: 3,
                ),),
              SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("UPLOAD FILE"),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'No file selected',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {

                    // if(_username.text.isEmpty){
                    //
                    //   showError('Please enter a valid username', context);
                    // }else if(_username.text.isEmpty){
                    //   showError('Please enter a valid password', context);
                    // }else if(_username.text.isEmpty){
                    //   showError('Please enter a valid URL', context);
                    // }else{
                    //
                    //   if(_value){
                    //     var prefs = await SharedPreferences.getInstance();
                    //     prefs.setBool('isloggedin', true);
                    //     prefs.setString("username",_username.text);
                    //   }
                    //   openPageNoBack(context, NavigatorScreen());
                    //
                    //
                    // }

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
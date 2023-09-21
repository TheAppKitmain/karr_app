import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/utils/Constants.dart';



class AddCityCharges extends StatefulWidget {


  @override
  _AddCityChargesState createState() => _AddCityChargesState();
}
class _AddCityChargesState extends State<AddCityCharges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
        automaticallyImplyLeading: true,
        // Set to true if you want the default back arrow
        toolbarHeight: 60,
        title: const Text(
        "Add City Chargess",
        style: TextStyle(
        fontSize: 20,
        color: AppColors.black // Adjust the title text size as needed
    ),

    ),
    centerTitle: true,
    // Center the title horizontally,
    backgroundColor: AppColors.white,
    leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    color: AppColors.black, // Use your custom icon here
    onPressed: () {
    // Add your navigation logic here
  },
    ),

    ),
      body: Padding(
    padding: const EdgeInsets.all(30.0),

    child:Column(

        children:[

          const Text("Select Day", style: TextStyle(
              fontSize: 18, fontFamily: "Lato", color: AppColors.black),textAlign: TextAlign.start,),
          const SizedBox(height: 20,),
          DatePicker(

            DateTime.now(),
            initialSelectedDate: DateTime.now(),

            selectionColor: AppColors.primaryColor,
            selectedTextColor: Colors.white,
            onDateChange: (date) {
              // New date selected
              setState(() {
                // _selectedValue = date;
              });
            },
          ),
        ],
      ),
    )

    );
  }

}
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/utils/Constants.dart';



class AddTolls extends StatefulWidget {


  @override
  _AddTollsState createState() => _AddTollsState();
}
class _AddTollsState extends State<AddTolls> {
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
            "Add Tolls",
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
          padding: const EdgeInsets.all(20.0),

          child:Column(

            children:[

              Row(
                children: [
                  Text("Select Day", style: TextStyle(
                      fontSize: 16, fontFamily: "Lato", color: AppColors.black),textAlign: TextAlign.start,),
                ],
              ),
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
              SizedBox(height: 10,),
              Row(
                children: [
                  Text("Select Number of Trips", style: TextStyle(
                      fontSize: 16, fontFamily: "Lato", color: AppColors.black),textAlign: TextAlign.start,),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child:
                  Card(
                    elevation: 4, // Adjust the elevation value as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          // Image icon for one-way trip
                          Image.asset(
                            'assets/png/one_way.png', // Replace with your image asset path
                            width: 24, // Adjust the width as needed
                            height: 24, // Adjust the height as needed
                          ),
                          SizedBox(width: 10), // Add spacing between icon and text
                          // Text "1 Trip (One Way)"
                          Text(
                            '1 Trip (One Way)',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black, // Adjust the text color as needed
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ),
                  Expanded(
                    flex: 1,
                    child:
                  Card(
                    elevation: 4, // Adjust the elevation value as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          // Image icon for one-way trip
                          Image.asset(
                            'assets/png/one_way.png', // Replace with your image asset path
                            width: 24, // Adjust the width as needed
                            height: 24, // Adjust the height as needed
                          ),
                          SizedBox(width: 10), // Add spacing between icon and text
                          // Text "1 Trip (One Way)"
                          Text(
                            '1 Trip (One Way)',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black, // Adjust the text color as needed
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  )
                ],
              ),
              Row(
                children: [
                  Text("Select Charge", style: TextStyle(
                      fontSize: 16, fontFamily: "Lato", color: AppColors.black),textAlign: TextAlign.start,),
                ],
              ),

            ],
          ),
        )

    );
  }

}
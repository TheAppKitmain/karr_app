import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/tolls/dataClass/TollsDataClass.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/AddTollItemView.dart';



class AddTolls extends StatefulWidget {


  @override
  _AddTollsState createState() => _AddTollsState();
}
class _AddTollsState extends State<AddTolls> {
  List<Toll> allTolls = [];


  Future<void> fetchallTolls() async {
    final dio = Dio();

    try {
      final response = await dio.get(
        'https://codecoyapps.com/karr/api/toll',
      );

      final responseData = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final status = responseData['status'] as bool;
        final message = responseData['message'] as String;

        if (status) {
          final chargeJson = responseData['tolls'];
          if (chargeJson != null) {
            chargeJson.forEach((v) {
              allTolls.add( Toll.fromJson(v));
            });
          }
          print('Data fetched successfully: $message');


          setState(() {
          });
          // Clear the existing list


        } else {
          // Handle the case where fetching data failed
          print('Data fetch failed: $message');
        }
      } else {
        // Handle error status codes (e.g., show an error message)
        print('API request failed with status code ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors or exceptions
      print('API request error: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchallTolls();
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          // Set to true if you want the default back arrow
          toolbarHeight: height*0.08,
          title:  Text(
            "Add Tolls",
            style: TextStyle(
                fontSize: width*0.05,
                color: AppColors.black // Adjust the title text size as needed
            ),

          ),
          centerTitle: true,
          // Center the title horizontally,
          backgroundColor: AppColors.white,
          iconTheme: const IconThemeData(color: Colors.black),

        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),

          child:Column(

            children:[

              Row(
                children: [
                  Text("Select Day", style: TextStyle(
                      fontSize: width*0.04, fontFamily: "Lato", color: AppColors.black),textAlign: TextAlign.start,),
                ],
              ),
              const SizedBox(height: 20,),
              DatePicker(

                DateTime.now(),
                initialSelectedDate: DateTime.now(),

                selectionColor: AppColors.primaryColor,
                selectedTextColor: Colors.white,
                height: height*0.1 ,
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
                      fontSize: width*0.04, fontFamily: "Lato", color: AppColors.black),textAlign: TextAlign.start,),
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
              SizedBox(height: 10,),
              Row(
                children: [
                  Text("Select Charge", style: TextStyle(
                      fontSize: 16, fontFamily: "Lato", color: AppColors.black),textAlign: TextAlign.start,),
                ],
              ),
              SizedBox(height: 10,),
              allTolls.isNotEmpty?


                  ListView.builder(
                itemCount: allTolls.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return AddTollsItemView(tolls: allTolls[index]);
                },)
              :Text("data"),

            ],
          ),
        )

    );
  }

}
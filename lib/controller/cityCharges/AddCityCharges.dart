import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/cityCharges/dataclass/AllCityChargesDataClass.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/AddTollItemView.dart';
import 'package:kaar/widgets/AddItemView.dart';



class AddCityCharges extends StatefulWidget {


  @override
  _AddCityChargesState createState() => _AddCityChargesState();
}
class _AddCityChargesState extends State<AddCityCharges> {
  List<Charges> cityCharges = [];


  Future<void> fetchallTolls() async {
    final dio = Dio();

    try {
      final response = await dio.get(
        'https://codecoyapps.com/karr/api/city',
      );

      final responseData = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final status = responseData['status'] as bool;
        final message = responseData['message'] as String;

        if (status) {
          final chargeJson = responseData['tolls'];
          if (chargeJson != null) {
            chargeJson.forEach((v) {
              cityCharges.add( Charges.fromJson(v));
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
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
        toolbarHeight: 60,
        title: const Text(
        "Add City Chargess",
        style: TextStyle(
        fontSize: 20,
        color: AppColors.black // Adjust the title text size as needed
    ),

    ),
    centerTitle: true,
    iconTheme: const IconThemeData(color: Colors.black),
    // Center the title horizontally,
    backgroundColor: AppColors.white,

    ),
      body: Padding(
    padding: const EdgeInsets.all(30.0),

    child:Column(

        children:[

          const Text("Select Days", style: TextStyle(
              fontSize: 18, fontFamily: "Lato", color: AppColors.black),textAlign: TextAlign.start,),
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
              Text("Select Charge", style: TextStyle(
                  fontSize: 16, fontFamily: "Lato", color: AppColors.black),textAlign: TextAlign.start,),
            ],
          ),
          SizedBox(height: 10,),
          cityCharges.isNotEmpty?


          ListView.builder(
            itemCount: cityCharges.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return AddItemView(tolls: cityCharges[index]);
            },)
              :Text("data"),

        ],

      ),
    )

    );
  }

}
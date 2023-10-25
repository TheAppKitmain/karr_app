import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/cityCharges/dataclass/AllCityChargesDataClass.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/AddTollItemView.dart';
import 'package:kaar/widgets/AddItemView.dart';
import 'package:kaar/widgets/CustomDialogBox.dart';
import 'package:kaar/widgets/PrimaryButton.dart';



class AddCityCharges extends StatefulWidget {


  @override
  _AddCityChargesState createState() => _AddCityChargesState();
}
class _AddCityChargesState extends State<AddCityCharges> {
  List<Charges> cityCharges = [];
  bool _isLoading = false;

  Future<void> fetchallCityCharges() async {
    final dio = Dio();

    try {
      final response = await dio.get(
        'http://ec2-54-146-4-118.compute-1.amazonaws.com/api/city',
      );

      final responseData = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final status = responseData['status'] as bool;
        final message = responseData['message'] as String;

        if (status) {
          final chargeJson = responseData['charges'];
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
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchallCityCharges();
  }
  final dio = Dio();

  Future<Map<String, dynamic>?> addCityCharge() async {
    final dio = Dio();

    try {
      final response = await dio.post(
        'http://ec2-54-146-4-118.compute-1.amazonaws.com/api/driver/city',
        queryParameters: {
          'driver_id': 1,
          'date': "24 Oct 2023",

          'notes':"test notes" ,
          'city_id[]': ["2"],
        },
      );

      final responseData = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final status = responseData['status'] as bool;
        final message = responseData['message'] as String;

        if (status) {

        } else {
          // Handle the case where login failed
          print('Login failed: $message');
          return {
            'status': status,
            'message': message,
          };
        }
      } else {
        // Handle error status codes (e.g., show an error message)
        print('API request failed with status code ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle network errors or exceptions
      print('API request error: $e');
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    final fontSize = width * 0.04;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: height * 0.08,
        title:  Text(
        "Add City Chargess",
        style: TextStyle(
            fontSize: fontSize,
        color: AppColors.black // Adjust the title text size as needed
    ),

    ),
    centerTitle: true,
    iconTheme: const IconThemeData(color: Colors.black),
    // Center the title horizontally,
    backgroundColor: AppColors.white,

    ),
      body: Padding(
    padding:  EdgeInsets.all(15.0),

    child:Column(

        children:[

           Text("Select Days", style: TextStyle(
              fontSize: fontSize, fontFamily: "Lato", color: AppColors.black),textAlign: TextAlign.start,),
           SizedBox(height: height*0.01,),
          DatePicker(

            DateTime.now(),
            initialSelectedDate: DateTime.now(),

            selectionColor: AppColors.primaryColor,
            selectedTextColor: Colors.white,

            height: height*0.12 ,
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
                  fontSize: fontSize, fontFamily: "Lato", color: AppColors.black),textAlign: TextAlign.start,),
            ],
          ),
          SizedBox(height: 10,),
          cityCharges.isNotEmpty
         ? ListView.builder(
            itemCount: cityCharges.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return AddItemView(tolls: cityCharges[index]);
            },) :CircularProgressIndicator(),

          Spacer(),
          PrimaryButton(
              text: "Submit City Charge",
              onPressed: () async {
                setState(() {
                  _isLoading = true; // Start loading
                });
                final response = await addCityCharge();
                if (response != null) {
                  final status = response['status'] as bool;
                  final message = response['message'] as String;

                  if (status) {
                    setState(() {
                      _isLoading = false; // Start loading
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(' $message'),
                      ),

                    );
                    CustomDialogBox.show(context, status, "City Charge Submitted", "Great! Your city charge has been submitted successfully.");
                  }else{
                    setState(() {
                      _isLoading = false; // Start loading
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(' $message'),
                      ),

                    );
                    CustomDialogBox.show(context, status, "City Charge  not Submitted", "Your city charge has not been submitted successfully.");
                  }
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('API request failed'),
                    ),
                  );
                  setState(() {
                    _isLoading = false; // Stop loading
                  });
                }
              })
        ],

      ),

    )

    );
  }

}
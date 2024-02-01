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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../tolls/AllTolls.dart';



class AddCityCharges extends StatefulWidget {
  Function(int?) onNext;
  Function(int?) onPrevious;



  AddCityCharges( {required this.onNext,required this.onPrevious});

  @override
  _AddCityChargesState createState() => _AddCityChargesState();
}
class _AddCityChargesState extends State<AddCityCharges> {
  List<Charges> cityCharges = [];
  List<Charges> selectedCityCharges = [];
  bool _isLoading = false;
  bool _isLoadingdata = true;
  DateTime? _selectedDate;
  String? userid;


  void loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString('userid');
    });
  }

  Future<void> fetchallCityCharges() async {
    final dio = Dio();

    try {

      final response = await dio.get(
        'https://dashboard.karrcompany.co.uk/api/city',
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


          _isLoadingdata=false;
          setState(() {});
          // Clear the existing list


        } else {
          // Handle the case where fetching data failed
          _isLoadingdata=false;
          setState(() {});
          print('Data fetch failed: $message');
        }
      } else {
        // Handle error status codes (e.g., show an error message)
        _isLoadingdata=false;
        setState(() {});
        print('API request failed with status code ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors or exceptions
      _isLoadingdata=false;
      setState(() {});
      print('API request error: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserDetails();
    fetchallCityCharges();
  }


  Future<Map<String, dynamic>?> addCityCharge() async {
    final dio = Dio();

    try {
      final Map<String, dynamic> requestData = {
        'driver_id': userid,
        'date': DateFormat('yyyy-MM-dd').format(_selectedDate??DateTime.now())  ?? DateTime.now().toLocal().toString().split(' ')[0],

        'cities': selectedCityCharges
            .where((toll) => toll.ischecked!)
            .map((toll) => {
          'city_id': toll.id,
          'notes': toll.note, // Assuming that the note is stored in the 'note' property of the Toll object
        })
            .toList(),
      };
      final response = await dio.post(
        'https://dashboard.karrcompany.co.uk/api/driver/city',
        data: requestData,
      );


      final responseData = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final status = responseData['status'] as bool;
        final message = responseData['message'] as String;

        if (status) {
          return response.data;
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

  void onTollChecked(Charges city, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedCityCharges.add(city);
      } else {
        selectedCityCharges.remove(city);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    final fontSize = width * 0.04;
    return WillPopScope(
      onWillPop: () =>widget.onPrevious(0),
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(fontSize: fontSize,onBackClick: () {
            widget.onPrevious(0);
          },title: 'Add City Charges',),
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
            if(cityCharges.isEmpty)
              _isLoadingdata?const CircularProgressIndicator():
              Text(
                "No City charge available",
                style: TextStyle(fontSize: fontSize, fontFamily: "Lato", color: AppColors.black),
              )
            else
              _isLoadingdata?const CircularProgressIndicator():
              ListView.builder(
              itemCount: cityCharges.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return AddItemView(tolls: cityCharges[index]
                ,onTollChecked: onTollChecked,);
              },) ,

            const Spacer(),
            _isLoading // Show progress indicator if loading
                ? const CircularProgressIndicator()
                : PrimaryButton(
                text: "Submit City Charge",
                onPressed: () async {
                  if (selectedCityCharges.isEmpty) {
                    // Show a Snackbar if no tolls are selected
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select at least one charge to submit.'),
                      ),
                    );
                    return; // Return to prevent further execution
                  }
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
                      saveRecentActivity('City Charge added');
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
                      CustomDialogBox.show(context, status, "City Charge  Not Submitted", "Your city charge has not been submitted successfully.");
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

      ),
    );
  }

}
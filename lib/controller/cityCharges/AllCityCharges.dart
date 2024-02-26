import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/Notes/ActivityDataClass/ActivityDataClass.dart';
import 'package:kaar/controller/cityCharges/AddCityCharges.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/AllCityChargeItemView.dart';
import 'package:kaar/widgets/PrimaryButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../tolls/AllTolls.dart';

class CityCharges extends StatefulWidget {
  Function(int?) onNext;
  Function(int?) onPrevious;



  CityCharges( {required this.onNext,required this.onPrevious});
  @override
  _CityChargesState createState() => _CityChargesState();
}

class _CityChargesState extends State<CityCharges> {
  List<String> gameList = ["Date", "City"];
  List<Charges> cityCharges = [];
  bool isLoading = true;
  var selectedValue;

  String? userid;

  @override
  void initState() {
    super.initState();
    loadUserDetails();
  }

  void loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString('userid');
      fetchCityCharges();
    });
  }

  Future<void> fetchCityCharges() async {
    final dio = Dio();

    try {
      final response = await dio.post(
        'https://dashboard.karrcompany.co.uk/api/recent/activity',
        queryParameters: {
          "driver_id": userid,
        },
      );

      final responseData = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final status = responseData['status'] as bool;
        final message = responseData['message'] as String;

        if (status) {
          final chargeJson = responseData['charges'];
          if (chargeJson != null) {
            chargeJson.forEach((v) {
              cityCharges.add(Charges.fromJson(v));
            });
          }
          print('Data fetched successfully: $message');
          isLoading = false;
          setState(() {});
          // Clear the existing list
        } else {
          // Handle the case where fetching data failed
          isLoading = false;
          setState(() {});
          print('Data fetch failed: $message');
        }
      } else {
        // Handle error status codes (e.g., show an error message)
        isLoading = false;
        setState(() {});
        print('API request failed with status code ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors or exceptions
      isLoading = false;
      setState(() {});
      print('API request error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final fontSize = width * 0.04;
    return WillPopScope(
      onWillPop: () =>widget.onPrevious(0),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(fontSize: fontSize,onBackClick: () {
          widget.onPrevious(0);
        },title: 'All City Charges',),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  "All Charges",
                  style: TextStyle(
                      fontSize: fontSize,
                      fontFamily: "Lato",
                      color: AppColors.black),
                ),
                const Spacer(),
                Card(
                  elevation: 4,
                  color: Colors.white,
                  child: Container(

                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white), // Set the black outline border
                      borderRadius: BorderRadius.circular(10),
                      // Set border radius if needed
                    ),
                    padding: EdgeInsets.symmetric(horizontal:25), // Add horizontal padding
                    child: DropdownButton<String>(
                      value: selectedValue,
                      underline: Offstage(),
                      hint: Padding(
                        padding:  EdgeInsets.only(right: width*0.09),
                        child: Text("Sort By",style: TextStyle(color: AppColors.black,fontSize: fontSize,fontFamily: 'Lato-Regular',fontWeight: FontWeight.normal),),
                      ),

                      items: gameList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style: TextStyle(color: AppColors.black,fontSize: fontSize,fontFamily: 'Lato-Regular',fontWeight: FontWeight.normal)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue;
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
          ), isLoading
              ? Center(
            child:
            CircularProgressIndicator(),

          ):
          cityCharges.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: cityCharges.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return AllCityChargeItemView(
                          cityCharge: cityCharges[index]);
                    },
                  ),
                )
              : Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          'assets/png/nocitycharges.png',
                          // Replace with your image asset path
                          width: width*0.3,
                          height: height*0.2,
                        ),
                      ),
                    ),
                    Center(
                        child: Text(
                      "Haven't Added Before?",
                      style: TextStyle(
                          fontSize: width * 0.07,
                          fontFamily: "Lato",
                          color: AppColors.black),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(
                      "Click Add City Charge and provide us with the ",
                      style: TextStyle(
                          fontSize: fontSize,
                          fontFamily: "fonts/Lato-Regular",
                          color: AppColors.black),
                    )),
                    Center(
                        child: Text(
                      "details to add new charge for you. ",
                      style: TextStyle(
                          fontSize: fontSize,
                          fontFamily: "fonts/Lato-Regular",
                          color: AppColors.black),
                    )),
                    Center(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: PrimaryButton(
                            text: 'Add City Charge',
                            onPressed: () {
                              widget.onNext(7);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => AddCityCharges()),
                              // );
                            },
                          )),
                    ),
                  ],
                ),
        ]),
        floatingActionButton: Visibility(
          visible: cityCharges.isEmpty?false:true,
          child: FloatingActionButton(
            onPressed: () {
              widget.onNext(7);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => AddCityCharges()),
              // );
            },
            backgroundColor: AppColors.primaryColor,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

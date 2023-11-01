import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/Notes/ActivityDataClass/ActivityDataClass.dart';
import 'package:kaar/controller/cityCharges/AddCityCharges.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/AllCityChargeItemView.dart';
import 'package:kaar/widgets/PrimaryButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CityCharges extends StatefulWidget {
  @override
  _CityChargesState createState() => _CityChargesState();
}

class _CityChargesState extends State<CityCharges> {
  List<String> gameList = ["Date", "City"];
  List<Charges> cityCharges = [];

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
        'http://ec2-54-146-4-118.compute-1.amazonaws.com/api/recent/activity',
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

          setState(() {});
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final fontSize = width * 0.04;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Set to true if you want the default back arrow
        toolbarHeight: 60,
        title: Text(
          "All City Charges",
          style: TextStyle(
              fontSize: fontSize,
              color: AppColors.black // Adjust the title text size as needed
              ),
        ),
        centerTitle: true,
        // Center the title horizontally,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
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
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  // Set the black outline border
                  borderRadius: BorderRadius.circular(10),
                  // Set border radius if needed
                ),
                padding: const EdgeInsets.symmetric(horizontal: 25),
                // Add horizontal padding
                child: DropdownButton<String>(
                  value: selectedValue,
                  underline: null,
                  hint: Text(
                    "Sort By",
                    style: TextStyle(
                        color: AppColors.black,
                        fontFamily: 'Lato-Regular',
                        fontSize: fontSize),
                  ),
                  items: gameList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue;
                    });
                  },
                ),
              )
            ],
          ),
        ),
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
                        width: 200,
                        height: 300,
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
                    "Click “Add City Charge” and provide us with the ",
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddCityCharges()),
                            );
                          },
                        )),
                  ),
                ],
              ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCityCharges()),
          );
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

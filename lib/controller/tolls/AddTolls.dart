import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/tolls/dataClass/TollsDataClass.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/AddTollItemView.dart';
import 'package:kaar/widgets/CustomDialogBox.dart';
import 'package:kaar/widgets/PrimaryButton.dart';
import 'package:kaar/widgets/selectable_card.dart';
import 'package:lottie/lottie.dart';

class AddTolls extends StatefulWidget {
  @override
  _AddTollsState createState() => _AddTollsState();
}

class _AddTollsState extends State<AddTolls> {
  List<Toll> allTolls = [];
  int selectedCardIndex = -1;
  bool _isLoading = false;
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
              allTolls.add(Toll.fromJson(v));
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

  final dio = Dio();

  Future<Map<String, dynamic>?> addToll() async {
    final dio = Dio();

    try {
      final response = await dio.post(
        'https://codecoyapps.com/karr/api/driver/toll',
        queryParameters: {
          'driver_id': 1,
          'date': "24 Oct 2023",
          'way':1 ,
          'notes':"test notes" ,
          'paytoll_id[]': ["1"],
        },
      );
print(response.data);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchallTolls();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final fontSize = width * 0.04;
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,

          // Set to true if you want the default back arrow
          toolbarHeight: height * 0.08,
          title: Text(
            "Add Tolls",
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
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Select Day",
                    style: TextStyle(
                        fontSize: fontSize,
                        fontFamily: "Lato",
                        color: AppColors.black),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: AppColors.primaryColor,
                selectedTextColor: Colors.white,
                height: height * 0.12,
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    // _selectedValue = date;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Select Number of Trips",
                    style: TextStyle(
                        fontSize: fontSize,
                        fontFamily: "Lato",
                        color: AppColors.black),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SelectableCard(
                      title: '1 Trip (One Way)',
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      icon:'assets/png/one_way.png',
                      selected: selectedCardIndex == 0,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedCardIndex = 0;
                          } else {
                            selectedCardIndex = -1; // Unselect the card
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SelectableCard(
                      title: '2 Trip (In and Out)',
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      icon:'assets/png/two_way.png',
                      selected: selectedCardIndex == 1,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedCardIndex = 1;
                          } else {
                            selectedCardIndex = -1; // Unselect the card
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Select Charge",
                    style: TextStyle(
                        fontSize: fontSize,
                        fontFamily: "Lato",
                        color: AppColors.black),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              allTolls.isNotEmpty
                  ? ListView.builder(
                      itemCount: allTolls.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return AddTollsItemView(tolls: allTolls[index]);
                      },
                    )
                  : CircularProgressIndicator(),
              Spacer(),
      _isLoading // Show progress indicator if loading
          ? CircularProgressIndicator()
          : PrimaryButton(
                  text: "Submit Toll",
                  onPressed: () async {
                    setState(() {
                      _isLoading = true; // Start loading
                    });
                    final response = await addToll();
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
                        CustomDialogBox.show(context, status, "Toll Submitted", "Great! Your toll has been submitted successfully.");
                      }else{
                        setState(() {
                          _isLoading = false; // Start loading
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(' $message'),
                          ),

                        );
                        CustomDialogBox.show(context, status, "Toll  not Submitted", "Your toll has not been submitted successfully.");
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
        ));
  }
}

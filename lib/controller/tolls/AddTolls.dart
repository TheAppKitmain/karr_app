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
import 'package:shared_preferences/shared_preferences.dart';

import 'AllTolls.dart';

class AddTolls extends StatefulWidget {
  Function(int?) onNext;
  Function(int?) onPrevious;



  AddTolls( {required this.onNext,required this.onPrevious});

  @override
  _AddTollsState createState() => _AddTollsState();
}

class _AddTollsState extends State<AddTolls> {
  List<Toll> allTolls = [];
  int selectedCardIndex = 0;
  DateTime? _selectedDate;
  String? userid;
  bool _isLoading = false;
  List<Toll> selectedTolls = [];

  @override
  void initState() {
    super.initState();
    loadUserDetails();
    fetchallTolls();
  }

  void loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString('userid');
    });
  }

  Future<void> fetchallTolls() async {
    final dio = Dio();

    try {
      final response = await dio.get(
        'http://ec2-54-146-4-118.compute-1.amazonaws.com/api/toll',
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
      final Map<String, dynamic> requestData = {
        'driver_id': userid,
        'date': _selectedDate?.toLocal().toString().split(' ')[0] ?? DateTime.now().toLocal().toString().split(' ')[0],
        'way': selectedCardIndex + 1,
        'tolls': selectedTolls
            .where((toll) => toll.ischecked!)
            .map((toll) => {
          'toll_id': toll.id,
          'notes': toll.note, // Assuming that the note is stored in the 'note' property of the Toll object
        })
            .toList(),
      };
      final response = await dio.post(
        'http://ec2-54-146-4-118.compute-1.amazonaws.com/api/driver/toll',
        data: requestData,
      );

      final responseData = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final status = responseData['status'] as bool;
        final message = responseData['message'] as String;

        if (status) {
          return response.data;
        } else {
          print('Toll not Submitted: $message');
          return {
            'status': status,
            'message': message,
          };
        }
      } else {
        print('API request failed with status code ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('API request error: $e');
      return null;
    }
  }
  void onTollChecked(Toll toll, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedTolls.add(toll);
      } else {
        selectedTolls.remove(toll);
      }
    });
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
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(fontSize: fontSize,onBackClick: () {
          widget.onPrevious(0);
        },title: 'Add Tolls',),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Select Day",
                    style: TextStyle(fontSize: fontSize, fontFamily: "Lato", color: AppColors.black),
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
                  setState(() {
                    _selectedDate = date;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Select Number of Trips",
                    style: TextStyle(fontSize: fontSize, fontFamily: "Lato", color: AppColors.black),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: SelectableCard(
                      title: '1 Trip (One Way)',
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      icon: 'assets/png/one_way.png',
                      selected: selectedCardIndex == 0,
                      onSelected: (selected) {
                        setState(() {
                          selectedCardIndex = selected ? 0 : -1;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: SelectableCard(
                      title: '2 Trip (In and Out)',
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      icon: 'assets/png/two_way.png',
                      selected: selectedCardIndex == 1,
                      onSelected: (selected) {
                        setState(() {
                          selectedCardIndex = selected ? 1 : -1;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Select Charge",
                    style: TextStyle(fontSize: fontSize, fontFamily: "Lato", color: AppColors.black),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              allTolls.isNotEmpty
                  ? ListView.builder(
                itemCount: allTolls.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return AddTollsItemView(
                    tolls: allTolls[index],
                    onTollChecked: onTollChecked
                  );
                },
              )
                  : CircularProgressIndicator(),
              const Spacer(),
              _isLoading
                  ? CircularProgressIndicator()
                  : PrimaryButton(
                text: "Submit Toll",
                onPressed: () async {
                  if (selectedTolls.isEmpty) {
                    // Show a Snackbar if no tolls are selected
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select at least one toll to submit.'),
                      ),
                    );
                    return; // Return to prevent further execution
                  }
                  setState(() {
                    _isLoading = true;
                  });
                  final response = await addToll();
                  if (response != null) {
                    final status = response['status'] as bool;
                    final message = response['message'] as String;

                    if (status) {
                      setState(() {
                        _isLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(' $message'),
                        ),
                      );
                      CustomDialogBox.show(context, status, "Toll Submitted", "Great! Your toll has been submitted successfully.");
                    } else {
                      setState(() {
                        _isLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(' $message'),
                        ),
                      );
                      CustomDialogBox.show(context, status, "Toll not Submitted", "Your toll has not been submitted successfully.");
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('API request failed'),
                      ),
                    );
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

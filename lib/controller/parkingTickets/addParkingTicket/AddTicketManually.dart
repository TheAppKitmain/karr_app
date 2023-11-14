import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/CustomDialogBox.dart';
import 'package:kaar/widgets/CustomTextField.dart';
import 'package:kaar/widgets/PrimaryButton.dart';
import 'package:kaar/widgets/TextView.dart';
import 'package:intl/intl.dart';

import 'package:kaar/widgets/TicketSubmissionDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/date_picker.dart';

class AddTicketManually extends StatefulWidget {
  const AddTicketManually({super.key});

  @override
  State<AddTicketManually> createState() => _AddTicketManuallyState();
}

class _AddTicketManuallyState extends State<AddTicketManually> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _pcnNumberController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _issuerController = TextEditingController();

  String? userid;
  bool _isLoading = false;
  DateTime? _date;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserDetails();
  }

  void loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString('userid');
    });
  }

  Future<Map<String, dynamic>?> addTicket() async {
    final dio = Dio();

    try {
      final response = await dio.post(
        'http://ec2-54-146-4-118.compute-1.amazonaws.com/api/ticket',
        queryParameters: {
          'driver_id': userid,
          'date': _dateController.text,
          'pcn': _pcnNumberController.text,
          'price': double.tryParse(_amountController.text),
          'ticket_issuer': _issuerController.text,
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await getDatePicker(context);
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        _dateController.text = DateFormat('yyyy-MM-dd')
            .format(picked); // Format the date as needed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Manual Input",
                  style: TextStyle(
                    color: AppColors.black,
                    fontFamily: "Lato",
                    fontSize: width * 0.07,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  "Enter the details of your ticket manually.",
                  style: TextStyle(
                    color: AppColors.black,
                    fontFamily: "Lato-Regular",
                    fontSize: width * 0.04,
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text: "PCN",
                        onPressed: () {},
                      ),

                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _pcnNumberController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                      // Add spacing between fields
                      // Add more CustomTextField widgets with validators

                      const SizedBox(height: 20),
                      TextView(
                        text: "Amount",
                        onPressed: () {},
                      ),

                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _amountController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      ),
                      const SizedBox(height: 20),
                      TextView(
                        text: "Issuer Name",
                        onPressed: () {},
                      ),

                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _issuerController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        keyboardType:
                            TextInputType.name,
                      ),

                      const SizedBox(height: 20),
                      TextView(
                        text: "Date",
                        onPressed: () {},
                      ),

                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _dateController,
                        onTap: () {
                          _selectDate(context);
                        },
                        focusKeypad: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text, // Change this to text
                      ),

                      Center(
                          child:
                              _isLoading // Show progress indicator if loading
                                  ? CircularProgressIndicator()
                                  : PrimaryButton(
                                      text: 'Submit Ticket',
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            _isLoading = true; // Start loading
                                          });
                                          final response = await addTicket();
                                          if (response != null) {
                                            final status =
                                                response['status'] as bool;
                                            final message =
                                                response['message'] as String;

                                            if (status) {
                                              setState(() {
                                                _isLoading =
                                                    false; // Start loading
                                              });
                                             /* ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(' $message'),
                                                ),
                                              );*/
                                              CustomDialogBox.show(
                                                  context,
                                                  status,
                                                  "Ticket Submitted",
                                                  "Great! Your Ticket has been submitted successfully.");
                                            } else {
                                              setState(() {
                                                _isLoading =
                                                    false; // Start loading
                                              });

                                              CustomDialogBox.show(
                                                  context,
                                                  status,
                                                  "Ticket  not Submitted",
                                                  "Your Ticket has not been submitted successfully.");
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content:
                                                    Text('API request failed'),
                                              ),
                                            );
                                            setState(() {
                                              _isLoading =
                                                  false; // Stop loading
                                            });
                                          }
                                        }

                                        // Perform sign-up logic
                                      },
                                    )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

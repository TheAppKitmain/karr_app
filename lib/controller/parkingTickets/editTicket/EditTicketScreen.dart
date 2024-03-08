import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/Notes/ActivityDataClass/ActivityDataClass.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/CustomDialogBox.dart';
import 'package:kaar/widgets/CustomTextField.dart';
import 'package:kaar/widgets/PrimaryButton.dart';
import 'package:kaar/widgets/TextView.dart';
import 'package:intl/intl.dart';

import 'package:kaar/widgets/TicketSubmissionDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import '../../../widgets/date_picker.dart';

class EditTicketScreen extends StatefulWidget {
  const EditTicketScreen({super.key,required this.ticket});
  final Tickets ticket;

  @override
  State<EditTicketScreen> createState() => _EditTicketScreenState();
}

class _EditTicketScreenState extends State<EditTicketScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _pcnNumberController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _issuerController = TextEditingController();
  String? _selectedIssuer;
  List<String> _ticketsIssuerList = ["BARNET", "BEXLEY","BROMLEY ","CAMDEN","CITY OF LONDON","CROYDON","EALING","ENFIELD","GREENWICH","HACKNEY COUNCIL"
    ,"HAVERING","HILLINGDON","HOUNSLOW","ISLINGTON","HAMMERRSMITH & FULHAM","HARINGEY","HARROWCOUNCIL","KENSINGTON AND CHELSEA","KINGSTON UPON THAMES","LAMBETH"
    ,"LEWISHAM","NEWHAM","REDBRIDGE","RICHMOND","SUTTON","TRANSPORT FOR LONDON","TOWER HAMLETS","WALTHAM FOROST","WANDSWORTH","WESTMINSTER"];
  var controller = new MaskedTextController(mask: '00000');
  String? userid;
  String? pcn;
  String? amount;
  String? date;
  String? notes;
  bool _isLoading = false;
  DateTime? _date;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    loadUserDetails();
    });
  }

  void loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('ticket is ${widget.ticket.date
    }');
    setState(() {
      userid = prefs.getString('userid');
      _selectedIssuer=widget.ticket.ticketIssuer;
      _dateController.text=formatWithSuffixString(widget.ticket.date!);
      _pcnNumberController.text=widget.ticket.pcn??"";
      _amountController.text=widget.ticket.price??"";
      notes=widget.ticket.notes;

    });
  }

  Future<Map<String, dynamic>?> updateTicket() async {
    final dio = Dio();

    try {
      final response = await dio.put(
        'https://dashboard.karrcompany.co.uk/api/updateTicket',
        queryParameters: {
          'ticket_id': widget.ticket.id,
          'driver_id': userid,
          'date': _dateController.text,
          'pcn': _pcnNumberController.text,
          // 'price': double.parse(_amountController.text),
          'price': double.parse(_amountController.text),
          'ticket_issuer': _selectedIssuer,
          'notes': _selectedIssuer,
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
        // _dateController.text = DateFormat('dd-MM-yyyy')
        _dateController.text =
            formatWithSuffix(picked); // Format the date as needed
      });
    }
  }
  String formatWithSuffixString(String date) {
    DateFormat format = DateFormat('dd-MM-yyyy');
    DateTime dateTime = format.parse(date);
    String suffix = 'th';
    int day = dateTime.day;
    if (day == 1 || day == 21 || day == 31) {
      suffix = 'st';
    } else if (day == 2 || day == 22) {
      suffix = 'nd';
    } else if (day == 3 || day == 23) {
      suffix = 'rd';
    }
    return
      // DateFormat('dd')  // Format day without suffix
      //   .format(dateTime)
      //   .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},') +
      '${dateTime.day}'+suffix + ' ' + DateFormat('MMMM yyyy').format(dateTime);
  }
  String formatWithSuffix(DateTime date) {
    String suffix = 'th';
    int day = date.day;
    if (day == 1 || day == 21 || day == 31) {
      suffix = 'st';
    } else if (day == 2 || day == 22) {
      suffix = 'nd';
    } else if (day == 3 || day == 23) {
      suffix = 'rd';
    }
    return
      // DateFormat('dd')  // Format day without suffix
      //   .format(date)
      //   .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},') +
      '${date.day}'+suffix + ' ' + DateFormat('MMMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  "Update Ticket",
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
                  "update the details of your ticket manually.",
                  style: TextStyle(
                    color: AppColors.black,
                    fontFamily: "Lato-Regular",
                    fontSize: width * 0.04,
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
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

                        onChanged: (v){

                        },
                        prefix: "£ ",

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
                      Card(
                        elevation: 4, // Adjust the elevation value as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<String>(
                            value: _selectedIssuer,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedIssuer = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select an issuer';
                              }
                              return null;
                            },
                            items: _ticketsIssuerList.map((String issuer) {
                              return DropdownMenuItem<String>(
                                value: issuer,
                                child: Text(issuer),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      // CustomTextField(
                      //   controller: _issuerController,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'This field is required';
                      //     }
                      //     return null;
                      //   },
                      //   keyboardType:
                      //       TextInputType.name,
                      // ),

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
                            text: 'Update Ticket',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true; // Start loading
                                });
                                final response = await updateTicket();
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
                                    saveRecentActivity('Ticket updated pcn: ${widget.ticket.pcn}');
                                    CustomDialogBox.show(
                                        context,
                                        status,
                                        "Ticket Updated",
                                        "Great! $message");
                                  } else {
                                    setState(() {
                                      _isLoading =
                                      false; // Start loading
                                    });

                                    CustomDialogBox.show(
                                        context,
                                        status,
                                        "Ticket  Not Submitted",
                                        "Your ticket has not been submitted successfully.\n$message");
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

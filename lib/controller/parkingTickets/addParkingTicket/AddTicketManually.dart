import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
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
  String? _selectedIssuer="BARNET";
  List<String> _ticketsIssuerList = ["BARNET", "BEXLEY","BROMLEY ","CAMDEN","CITY OF LONDON","CROYDON","EALING","ENFIELD","GREENWICH","HACKNEY COUNCIL"
    ,"HAVERING","HILLINGDON","HOUNSLOW","ISLINGTON","HAMMERRSMITH & FULHAM","HARINGEY","HARROWCOUNCIL","KENSINGTON AND CHELSEA","KINGSTON UPON THAMES","LAMBETH"
    ,"LEWISHAM","NEWHAM","REDBRIDGE","RICHMOND","SUTTON","TRANSPORT FOR LONDON","TOWER HAMLETS","WALTHAM FOROST","WANDSWORTH","WESTMINSTER"];
  var controller = new MaskedTextController(mask: '00000');
  String? userid;
  bool _isLoading = false;
  DateTime? _date;

  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadUserDetails();
    });
  }

  void loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted)setState(() {
      userid = prefs.getString('userid');
    });
  }

  Future<Map<String, dynamic>?> addTicket() async {
    final dio = Dio();

    try {
      print(' date iss${revertDateFormat(_dateController.text).toString()}');
      final response = await dio.post(
        'https://dashboard.karrcompany.co.uk/api/ticket',
        queryParameters: {
          'driver_id': userid,
          'date': revertDateFormat(_dateController.text).toString(),
          'pcn':  CapitalWOrd.capitalizeWithNumbers(_pcnNumberController.text),
          // 'price': double.parse(_amountController.text),
          'price': double.parse(_amountController.text),
          'ticket_issuer': _selectedIssuer,
        },
      );
      print(response.data);

      final responseData = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final status = responseData['status'] as bool;
        final message = responseData['message'] as String;

        if (status) {
          return response.data;
        } else if(message=="The selected driver id is invalid."){
          logOut(context);
          return response.data;

        }else {
          // Handle the case where login failed
          print('Ticket failed: $message');
          return response.data;
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
      if (mounted)setState(() {
        _date = picked;
        print("date in format$picked");

        // _dateController.text = DateFormat('dd-MM-yyyy')
        _dateController.text =
            formatWithSuffix(picked); // Format the date as needed
      });
    }
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
        '${date.day}'+ suffix + ' ' + DateFormat('MMMM yyyy').format(date);
  }
  String revertDateFormat(String formattedDate) {
    // Split the formatted date string by space to separate day, suffix, month, and year
    List<String> parts = formattedDate.split(' ');

    // Extract day and remove suffix
    String day = parts[0].replaceAll(RegExp(r'[^\d]'), '');

    // Extract month and year
    String monthYear = parts[1];
    String Year = parts[2];
    if (monthYear=='January')
      monthYear='01';
    else if(monthYear=='February')
      monthYear='02';
    else if(monthYear=='March')
      monthYear='03';
    else if(monthYear=='April')
      monthYear='04';
    else if(monthYear=='May')
      monthYear='05';
    else if(monthYear=='June')
      monthYear='06';
    else if(monthYear=='July')
      monthYear='07';
    else if(monthYear=='August')
      monthYear='08';
    else if(monthYear=='September')
      monthYear='09';
    else if(monthYear=='October')
      monthYear='10';
    else if(monthYear=='November')
      monthYear='11';
    else if(monthYear=='December')
      monthYear='12';

    // Return the reverted format
    return '$day-$monthYear-$Year';
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

      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Manual Input",
                    style: TextStyle(
                      color: AppColors.black,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.06,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Enter the details of your ticket manually.",
                    style: TextStyle(
                      color: AppColors.black,
                      fontFamily: "Lato-Regular",
                      fontSize: width * 0.035,
                    ),
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
                        prefixicon:true,


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
                        text: "Date",
                        onPressed: () {},
                      ),

                      const SizedBox(height: 10),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _dateController,
                      onTap: () {
                        _selectDate(context);
                      },


                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(

                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Adjust padding as needed
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.date_range),
                          // Icon for selecting date range
                          onPressed: () {
                            _selectDate(context); // Function to open date picker
                          },
                        ),


                      ),
                      onTapOutside: (v) => FocusManager.instance.primaryFocus?.unfocus(),
                    ),
                  ),
                      // CustomTextField(
                      //   controller: _dateController,
                      //   onTap: () {
                      //     _selectDate(context);
                      //   },
                      //   focusKeypad: true,
                      //
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'This field is required';
                      //     }
                      //     return null;
                      //   },
                      //   keyboardType: TextInputType.text, // Change this to text
                      // ),
                      const SizedBox(height: 20),
                      TextView(
                        text: "Ticket Issuer",
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
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: DropdownButton2<String>(
                                isExpanded: true,

                                // hint: Expanded(
                                //   child: Text(
                                //     'Select Issuer',
                                //     style: TextStyle(
                                //       fontSize: 14,
                                //       fontFamily: 'Lato-Regular',
                                //       color: Colors.black38,
                                //     ),
                                //     overflow: TextOverflow.ellipsis,
                                //   ),
                                // ),
                                items: _ticketsIssuerList
                                    .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontFamily: 'Lato-Regular'
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                    .toList(),
                                value: _selectedIssuer,
                                onChanged: (String? value) {
                                  if (mounted)setState(() {
                                    _selectedIssuer = value;

                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: width*0.9,

                                  // padding: const EdgeInsets.only(left: 14, right: 14),


                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                  ),
                                  iconSize: 18,
                                  // iconEnabledColor: Colors.yellow,
                                  // iconDisabledColor: Colors.grey,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  width: width*0.9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white,
                                  ),
                                  offset: const Offset(-20, 0),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness: MaterialStateProperty.all<double>(6),
                                    thumbVisibility: MaterialStateProperty.all<bool>(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Card(
                      //   elevation: 4, // Adjust the elevation value as needed
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: DropdownButtonFormField<String>(
                      //       value: _selectedIssuer,
                      //       decoration: InputDecoration(border: InputBorder.none),
                      //       borderRadius: BorderRadius.circular(20),
                      //       menuMaxHeight: height*0.3,
                      //       padding: EdgeInsets.zero,
                      //       isExpanded: true,
                      //       onChanged: (String? newValue) {
                      //         if (mounted)setState(() {
                      //           _selectedIssuer = newValue;
                      //         });
                      //       },
                      //       validator: (value) {
                      //         if (value == null || value.isEmpty) {
                      //           return 'Please select an issuer';
                      //         }
                      //         return null;
                      //       },
                      //       items: _ticketsIssuerList.map((String issuer) {
                      //         return DropdownMenuItem<String>(
                      //           value: issuer,
                      //
                      //           child: Text(issuer),
                      //         );
                      //       }).toList(),
                      //     ),
                      //   ),
                      // ),
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
                      Center(
                          child:
                              _isLoading // Show progress indicator if loading
                                  ? CircularProgressIndicator()
                                  : PrimaryButton(
                                      text: 'Submit Ticket',
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          if (mounted)setState(() {
                                            _isLoading = true; // Start loading
                                          });
                                          final response = await addTicket();
                                          if (response != null) {
                                            final status =
                                                response['status'] as bool;
                                            final message =
                                                response['message'] as String;

                                            if (status) {
                                              if (mounted)setState(() {
                                                _isLoading =
                                                    false; // Start loading
                                              });
                                             /* ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(' $message'),
                                                ),
                                              );*/
                                              saveRecentActivity('PCN: ${CapitalWOrd.capitalizeWithNumbers(_pcnNumberController.text)}');
                                              CustomDialogBox.show(
                                                  context,
                                                  status,
                                                  "Ticket Submitted",
                                                  "Great! Your ticket has been submitted successfully.");
                                            } else {
                                              if (mounted)setState(() {
                                                _isLoading =
                                                    false; // Start loading
                                              });

                                              if(message=='The pcn has already been taken.')
                                                CustomDialogBox.show(
                                                    context,
                                                    status,
                                                    "Ticket Already Submitted",
                                                    "This PCN number has already been submitted");
                                              else
                                                CustomDialogBox.show(
                                                    context,
                                                    status,
                                                    "Ticket Not Submitted",
                                                    "Your ticket has not been submitted .\n$message");

                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content:
                                                    Text('Something went wrong '),
                                              ),
                                            );
                                            if (mounted)setState(() {
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

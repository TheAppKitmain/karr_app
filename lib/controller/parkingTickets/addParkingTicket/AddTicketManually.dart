import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/CustomDialogBox.dart';
import 'package:kaar/widgets/CustomTextField.dart';
import 'package:kaar/widgets/PrimaryButton.dart';
import 'package:kaar/widgets/TextView.dart';
import 'package:intl/intl.dart';
import 'package:kaar/widgets/TicketSubmissionDialog.dart';

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
  bool _isLoading = false;
  DateTime? _date;
  Future<void> _selectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked); // Format the date as needed
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
            width:double.infinity,
            child: SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Text("Manual Input",
                  style: TextStyle(
                    color: AppColors.black,
                    fontFamily: "Lato",
                    fontSize: width * 0.07,
                  ),),
                SizedBox(height: height*0.02,),
                Text("Enter the details of your ticket manually.",
                  style: TextStyle(
                    color: AppColors.black,
                    fontFamily: "Lato-Regular",
                    fontSize: width * 0.04,
                  ),),
                SizedBox(height: height*0.1,),
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
                          keyboardType:TextInputType.text,
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
                          onPressed: () {

                          },
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
                          keyboardType: TextInputType.phone,
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
                        child: _isLoading // Show progress indicator if loading
                                ? CircularProgressIndicator()
                                : PrimaryButton(
                              text: 'Submit Ticket',
                              onPressed: () async {

                                if (_formKey.currentState!.validate()) {

                                  setState(() {
                                    _isLoading = false; // Start loading
                                  });
                                  // Validation successful, navigate to the next screen
                                  String pcnNumber = _pcnNumberController.text;
                                  String amount = _amountController.text;
                                  String date = _dateController.text;

                                  CustomDialogBox.show(context, true,"Successfuly Added", "Great! Your ticket has been submitted successfully.'");
                                  // request(countryCode,password);
                                  // final user = await login(countryCode, password);


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

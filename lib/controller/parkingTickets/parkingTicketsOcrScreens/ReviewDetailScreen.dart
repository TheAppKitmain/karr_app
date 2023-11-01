

import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/Notes/ActivityDataClass/ActivityDataClass.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/AddParkingTicketCard.dart';
import 'package:kaar/widgets/CustomDialogBox.dart';
import 'package:kaar/widgets/PrimaryButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewDetailScreen extends StatefulWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final String pcn_nmuber;
  final String date;
  final String charge;
  final Tickets ticket;
  ReviewDetailScreen({required this.onPrevious, required this.onNext, required this.pcn_nmuber, required this.date, required this.charge,required this.ticket});

  @override
  State<ReviewDetailScreen> createState() => _ReviewDetailScreenState();
}

class _ReviewDetailScreenState extends State<ReviewDetailScreen> {
  String? userid;

  bool _isLoading = false;



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

  Future<Map<String, dynamic>?> addTicket(String? date,String? pcn,String? price,String? issuer) async {
    final dio = Dio();

    try {
      final response = await dio.post(
        'http://ec2-54-146-4-118.compute-1.amazonaws.com/api/ticket',
        queryParameters: {
          'driver_id': userid,
          'date': date??"",
          'pcn': pcn??"",
          'price': double.tryParse(price??'0'),
          'ticket_issuer': issuer??"",
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
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: AppColors.backgroundColorOvwhite,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Review Details",
              style: TextStyle(
              color: AppColors.black,
              fontFamily: "Lato",
              fontSize: width * 0.07,
            ),),
            SizedBox(height: height*0.02,),
            Text("Please confirm the details below are correct before submitting.",
              style: TextStyle(
              color: AppColors.black,
              fontFamily: "Lato-Regular",
              fontSize: width * 0.04,
            ),),
            SizedBox(height: height*0.07,),

            AddParkingTicketCard(tickets: widget.ticket),
            const Spacer(),
            _isLoading?CircularProgressIndicator():
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      widget.onPrevious();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                          color: AppColors.primaryColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Take Photo Again",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      final response = await addTicket(widget.ticket.date,widget.ticket.pcn,widget.ticket.price,widget.ticket.ticketIssuer);
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
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            SnackBar(
                              content: Text(' $message'),
                            ),
                          );
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
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            SnackBar(
                              content: Text(' $message'),
                            ),
                          );
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
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                          color: AppColors.primaryColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Submit Ticket",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}

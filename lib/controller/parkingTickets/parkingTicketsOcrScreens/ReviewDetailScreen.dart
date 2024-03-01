

import 'dart:convert';

import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';

import 'package:image/image.dart' as img;
import 'package:kaar/controller/Notes/ActivityDataClass/ActivityDataClass.dart';
import 'package:kaar/controller/parkingTickets/parkingTicketsOcrScreens/SubmitticketPictureScreen.dart';
import 'package:kaar/utils/Constants.dart';

import 'package:kaar/widgets/AddParkingTicketCard.dart';
import 'package:kaar/widgets/CustomDialoboxTicketPictureUpload.dart';
import 'package:kaar/widgets/CustomDialogBox.dart';

import 'package:kaar/widgets/TicketNotDetectDialog.dart';
import 'package:path/path.dart';

import 'package:shared_preferences/shared_preferences.dart';


class ReviewDetailScreen extends StatefulWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final File capturedImage;
  final Tickets ticket;
  ReviewDetailScreen({required this.onPrevious, required this.onNext,required this.ticket, required this.capturedImage});

  @override
  State<ReviewDetailScreen> createState() => _ReviewDetailScreenState();
}

class _ReviewDetailScreenState extends State<ReviewDetailScreen> {
  String? userid;
  String? adminid;

  bool _isLoading = false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserDetails();
    // checkTicketDetails(context);

  }

  Future<void> checkTicketDetails(BuildContext context) async {
    if(widget.ticket.price=='Price'||widget.ticket.pcn=='Not Recognized'||widget.ticket.date=='Date'||widget.ticket.ticketIssuer=='Ticket Issuer'){

      Future.delayed(Duration(milliseconds: 500),(){
        TicketNotDetect.show(context,"Ticket Not Recognized", "Try again or enter manually",() {

          widget.onPrevious();},);

      });

    }else{
      final response = await addTicket(widget.capturedImage,widget.ticket.date,widget.ticket.pcn,widget.ticket.price,widget.ticket.ticketIssuer,context);
      if (response != null) {
        final status =
        response['status'] as bool;
        final message =
        response['message'] as String;

        if (status) {
          // upload(widget.capturedImage!, context,message,status);
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
              "Great! Your ticket has been submitted successfully.");
          saveRecentActivity('Ticket added pcn: ${widget.ticket.pcn}');
          setState(() {
            _isLoading =
            false; // Start loading
          });

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
            Text('API request failed'),
          ),
        );
        setState(() {
          _isLoading =
          false; // Stop loading
        });
      }
    }
  }


  void loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString('userid');
      adminid = prefs.getString('adminid');
    });
  }

  Future<void> upload(File imageFile, BuildContext context,String message,bool status) async {
    // Print the file extension for debugging
    print('File extension: ${extension(imageFile.path)}');

    // string to uri
    var uri = Uri.parse("https://dashboard.karrcompany.co.uk/api/fines");
    var request = http.MultipartRequest("POST", uri);
    request.fields['driver_id'] = userid ?? "1";
    request.fields['user_id'] = adminid ?? '3';

    // Print the content type for debugging
    print('Content type: ${MediaType('image', 'jpg',)}');

    // Print the file size for debugging
    print('File size: ${await imageFile.length()} bytes');

    // Add the image to the request
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
      contentType: MediaType('image', 'jpg'),
    ));

    // Send the request
    request.send().then((response) {
      if (response.statusCode == 200) {
        response.stream.transform(utf8.decoder).listen((value) {
          print(value);
          setState(() {
            _isLoading = false;
          });
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
            "Great! Your ticket has been submitted successfully.");
        saveRecentActivity('Ticket added pcn: ${widget.ticket.pcn}');

      } else {
        setState(() {
          // _isLoading = false;
        });
        // CustomDialoboxTicketPictureUpload.show(context, false, "Ticket not Submitted", "Your Ticket has not been submitted ");
        // print('Error: ${response.statusCode}');
      }
    });
  }
  Future<Map<String, dynamic>?> addTicket(File imageFile,String? date,String? pcn,String? price,String? issuer, BuildContext context) async {
    final dio = Dio();

    print('price is ${widget.capturedImage.runtimeType}');
    try {
      final formData = FormData.fromMap({
        'driver_id': userid,
        'date': date??"",
        'pcn': pcn??"",
        'price': double.tryParse(price??'0'),
        'ticket_issuer': issuer??"",
        'image':await MultipartFile.fromFile(imageFile.path),
      });
      final response = await dio.post(
        'https://dashboard.karrcompany.co.uk/api/ticket',data:formData
        // queryParameters: {
        //   'driver_id': userid,
        //   'date': date??"",
        //   'pcn': pcn??"",
        //   'price': double.tryParse(price??'0'),
        //   'ticket_issuer': issuer??"",
        //   'image':await MultipartFile.fromFile(imageFile.path),
        // },
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

    return Scaffold(

      resizeToAvoidBottomInset: false,
      body: Container(
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

              AddParkingTicketCard(tickets: widget.ticket,isEdit: true),
              const Spacer(),
              _isLoading?Center(child: CircularProgressIndicator()):
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

                        checkTicketDetails(context);
                        _isLoading=true;
                        setState(() {

                        });
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
              ),
              SizedBox(height: 10,),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TicketCameraScreen()),
                    );
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

                      "Ticket not recognised? Submit a picture of the ticket",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height*0.04,),

            ],
          ),
        ),
      ),
    );
  }
}

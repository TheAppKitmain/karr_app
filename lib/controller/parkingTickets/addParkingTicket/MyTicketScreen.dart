import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kaar/controller/Notes/ActivityDataClass/ActivityDataClass.dart';
import 'package:kaar/controller/parkingTickets/addParkingTicket/AddTicketManually.dart';

import 'package:kaar/utils/Constants.dart';
import 'package:kaar/controller/parkingTickets/parkingTicketsOcrScreens/ReviewDetailScreen.dart';

import 'package:kaar/controller/parkingTickets/parkingTicketsOcrScreens/CameraScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../tolls/AllTolls.dart';

class MyTicketScreen extends StatefulWidget {
  @override
  _MyTicketScreenState createState() => _MyTicketScreenState();
}

class _MyTicketScreenState extends State<MyTicketScreen> {
  int currentStep = 0; // Current step index
   late String ticket_number;
   late String date;
   late String charge;
   late String issuer;
   late File captureimage;
  final t=Tickets();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      // appBar: AppBar(
      //   elevation: 0,
      //   toolbarHeight: 40,
      //   iconTheme: const IconThemeData(color: Colors.black),
      //   backgroundColor: AppColors.white,
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Platform.isAndroid?Icons.arrow_back:Icons.arrow_back_ios)),
                Spacer(),
                Text(
                  "Step ${currentStep + 1}",
                  style: TextStyle(
                      color: AppColors.black, fontFamily: "Lato", fontSize: 14),
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            CustomStepper(
              steps: 2,
              currentStep: currentStep,
            ),
            Expanded(
              child:  currentStep == 0
                      ? CameraScreen( image: (image){
                        captureimage=image;
              },onPrevious: () {
                          if (mounted)setState(() {
                            currentStep = 0;
                          });
                        },
                  onNext: () async {
                final prefs = await SharedPreferences.getInstance();
                // ticket_number = prefs.getString('Ticket_number') ?? '';
                // date = prefs.getString('Ticket_date') ?? '';
                // charge = prefs.getString('Ticket_charge') ?? '';
        
                if (mounted)setState(()  {
                  ticket_number = prefs.getString('Ticket_number') ?? '';
                  date = prefs.getString('Ticket_date') ?? '';
                  charge = prefs.getString('Ticket_charge') ?? '';
                  issuer = prefs.getString('Issuer_name') ?? '';
        
                  t.pcn=ticket_number;
                  t.date=date;
                  t.price=charge;
                  t.ticketIssuer=issuer;
                  print("scanned text is $ticket_number,$date,$charge,$issuer");
                  currentStep = 1;
                });
                        }):currentStep == 1
                      ? ReviewDetailScreen(capturedImage: captureimage,onPrevious: () {
                          if (mounted)setState(() {
                            currentStep = 0;
                          });
                        }, onNext: () {
                          if (mounted)setState(() {
                            currentStep = 2;
                          });
                        }, ticket: t,)
                      : Step3Screen(
                          onPrevious: () {
                            if (mounted)setState(() {
                              currentStep = 1;
                            });
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomStepper extends StatelessWidget {
  final int steps;
  final int currentStep;

  CustomStepper({required this.steps, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(steps, (index) {
        final isActive = index == currentStep;
        final isCompleted = index < currentStep;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 8.0,
              decoration: BoxDecoration(
                  color: isActive
                      ? Colors.black
                      : isCompleted
                          ? AppColors.primaryColor
                          : Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
            ),
          ),
        );
      }),
    );
  }
}

class Step1Screen extends StatelessWidget {

  Function(int?) onNext;
  Function(int?) onPrevious;



  Step1Screen( {required this.onNext,required this.onPrevious});


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () =>onPrevious(0),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar:CustomAppBar(fontSize: width*0.04,onBackClick: () {
          onPrevious(0);
        },title: '',),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              // Align text to the start
              children: [
                Text(
                  "How would you like to submit your tickets?",
                  style: TextStyle(
                    color: AppColors.black,
                    fontFamily: "Lato",
                    fontSize: width * 0.07,

                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  "The below options are available to submit your ticket. Please choose your preferred method.",
                  style: TextStyle(
                    color: AppColors.black,
                    fontFamily: "Lato-Regular",
                    fontSize: width * 0.04,
                  ),
                ),
                SizedBox(height: height * 0.04),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyTicketScreen()),
                    );
                  },
                  child: Card(
                    color: AppColors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          // Wrap the text with Flexible
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all( 8.0),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              child:
                              // Image.asset(
                              //   'assets/png/mobile_icon.png',
                              //   width: 40,
                              //   height: 40,
                              //   color: AppColors.primaryColor,
                              // ),
                              SvgPicture.asset(
                                width: 35,
                                height: 35,
                                'assets/svg/submitticket1.svg',
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          // Wrap the text with Flexible
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Text(
                                'Submit Ticket',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Lato",
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Take a picture of your ticket or select a photo of your ticket from the camera roll.',
                                style: TextStyle(
                                  fontSize: width * 0.03,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Flexible(
                          // Wrap the text with Flexible
                          flex: 1,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTicketManually()),
                    );
                  },
                  child: Card(
                    color: AppColors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          // Wrap the text with Flexible
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              child:  SvgPicture.asset(
                                width: 32,
                                height: 32,
                              'assets/svg/submitticket2.svg',
                                color: AppColors.primaryColor,

                            ),
                            ),
                          ),
                        ),
                        Flexible(
                          // Wrap the text with Flexible
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Text(
                                'Manual Input',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Lato",
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Enter the details of your ticket manually.',
                                style: TextStyle(
                                  fontSize: width * 0.03,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Flexible(
                          // Wrap the text with Flexible
                          flex: 1,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.primaryColor,
                          ),
                        )
                      ],
                    ),
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


class Step3Screen extends StatelessWidget {
  final VoidCallback onPrevious;

  Step3Screen({required this.onPrevious});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Step 3: Show Ticket Data'),
          ElevatedButton(
            onPressed: () {
              onPrevious();
            },
            child: Text('Back to Step 2'),
          ),
        ],
      ),
    );
  }
}

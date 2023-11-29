import 'package:flutter/material.dart';
import 'package:kaar/controller/Notes/ActivityDataClass/ActivityDataClass.dart';
import 'package:kaar/controller/parkingTickets/addParkingTicket/AddTicketManually.dart';

import 'package:kaar/utils/Constants.dart';
import 'package:kaar/controller/parkingTickets/parkingTicketsOcrScreens/ReviewDetailScreen.dart';

import 'package:kaar/controller/parkingTickets/parkingTicketsOcrScreens/CameraScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final t=Tickets();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: AppColors.white,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Spacer(),
              Text(
                "Step ${currentStep + 1}",
                style: TextStyle(
                    color: AppColors.black, fontFamily: "Lato", fontSize: 18),
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          CustomStepper(
            steps: 2,
            currentStep: currentStep,
          ),
          Expanded(
            child:  currentStep == 0
                    ? CameraScreen(onPrevious: () {
                        setState(() {
                          currentStep = 0;
                        });
                      }, onNext: () async {
              final prefs = await SharedPreferences.getInstance();
              // ticket_number = prefs.getString('Ticket_number') ?? '';
              // date = prefs.getString('Ticket_date') ?? '';
              // charge = prefs.getString('Ticket_charge') ?? '';

              setState(()  {
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
                    ? ReviewDetailScreen(onPrevious: () {
                        setState(() {
                          currentStep = 0;
                        });
                      }, onNext: () {
                        setState(() {
                          currentStep = 2;
                        });
                      }, pcn_nmuber: ticket_number, date: date, charge: charge, ticket: t,)
                    : Step3Screen(
                        onPrevious: () {
                          setState(() {
                            currentStep = 1;
                          });
                        },
                      ),
          ),
        ],
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
                  "How would you like to Submit your Tickets?",
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
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              'assets/png/mobile_icon.png',
                              width: 40,
                              height: 40,
                              color: AppColors.primaryColor,
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
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              'assets/png/parking_tickets.png',
                              width: 40,
                              height: 40,
                              color: AppColors.primaryColor,
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

class Step2Screen extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  Step2Screen({required this.onPrevious, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Step 2: Enter Data Manually'),
          ElevatedButton(
            onPressed: () {
              // Add form logic here
              // If data entered, move to the next step
              onNext();
            },
            child: Text('Enter Data'),
          ),
          ElevatedButton(
            onPressed: () {
              onPrevious();
            },
            child: Text('Back to Step 1'),
          ),
        ],
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

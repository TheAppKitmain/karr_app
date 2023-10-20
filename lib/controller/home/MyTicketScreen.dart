import 'package:flutter/material.dart';
import 'package:kaar/controller/parkingTicketsOcrScreens/ReviewDetailScreen.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/controller/parkingTicketsOcrScreens/DateGetScreen.dart';
import 'package:kaar/controller/parkingTicketsOcrScreens/ChargeGetScreen.dart';
import 'package:kaar/controller/parkingTicketsOcrScreens/CameraScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTicketScreen extends StatefulWidget {
  @override
  _MyTicketScreenState createState() => _MyTicketScreenState();
}

class _MyTicketScreenState extends State<MyTicketScreen> {
  int currentStep = 0; // Current step index
   late String ticket_number;
   late String date;
   late String charge;
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
            steps: 5,
            currentStep: currentStep,
          ),
          Expanded(
            child: currentStep == 0
                ? Step1Screen(
                    onNext: () {
                      setState(() {
                        currentStep = 1;
                      });
                    },
                  )
                : currentStep == 1
                    ? CameraScreen(onPrevious: () {
                        setState(() {
                          currentStep = 0;
                        });
                      }, onNext: () {
                        setState(() {
                          currentStep = 2;
                        });
                      }): currentStep == 2
                    ? DateGetScreen(onPrevious: () {
                        setState(() {
                          currentStep = 1;
                        });
                      }, onNext: () {
                        setState(() {
                          currentStep = 3;
                        });
                      }): currentStep == 3
                    ? ChargeGetScreen(onPrevious: () {
                        setState(() {
                          currentStep = 2;
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
                          print("scanned text is $ticket_number,$date,$charge");
                          currentStep = 4;
                        });
                      }):currentStep == 4
                    ? ReviewDetailScreen(onPrevious: () {
                        setState(() {
                          currentStep = 3;
                        });
                      }, onNext: () {
                        setState(() {
                          currentStep = 2;
                        });
                      }, pcn_nmuber: ticket_number, date: date, charge: charge,)
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
  final VoidCallback onNext;

  Step1Screen({required this.onNext});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          // Align text to the start
          children: [
            Text(
              "How Would You Like To Submit Your Tickets?",
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
                onNext();
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
              onTap: () {},
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

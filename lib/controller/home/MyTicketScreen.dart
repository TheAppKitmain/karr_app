import 'package:flutter/material.dart';
import 'package:kaar/utils/Constants.dart';


class MyTicketScreen extends StatefulWidget {
  @override
  _MyTicketScreenState createState() => _MyTicketScreenState();
}

class _MyTicketScreenState extends State<MyTicketScreen> {
  int currentStep = 0; // Current step index

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          SizedBox(height: 80,),
          Row(children: [Spacer(),Text("Step ${currentStep+1}",style: TextStyle(color: AppColors.black,fontFamily: "Lato",fontSize: 18),),SizedBox(width: 20,)],),
          SizedBox(height: 30,),
          CustomStepper(
            steps: 3,
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
                ? Step2Screen(
              onPrevious: () {
                setState(() {
                  currentStep = 0;
                });
              },
              onNext: () {
                setState(() {
                  currentStep = 2;
                });
              },
            )
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
          child:
          Padding(
            padding: const EdgeInsets.all(12.0),

            child: Container(
              height: 8.0,

              decoration: BoxDecoration(
                  color: isActive ? Colors.black : isCompleted ? AppColors.primaryColor : Colors.black,

                  borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(children: [Text("How Would You Like To Submit \nYour Ticket?",style: TextStyle(color: AppColors.black,fontFamily: "Lato",fontSize: 30),)],),
            SizedBox(height: 15,),
            Row(children: [Text("The below options are available to submit your ticket. \nPlease choose your preferred method.",style: TextStyle(color: AppColors.black,fontFamily: "Lato-Regular",fontSize: 18),)],),
            SizedBox(height: 30,),
            Card(
                color: AppColors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(

                        child: CircleAvatar(
                          radius: 60,

                          backgroundColor: Colors.white,

                          child: Image.asset(
                            'assets/png/parking_tickets.png',
                            // Replace with your image asset path
                            width: 40,
                            height: 40,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
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
                            'Take a picture of your ticket or select a\n photo of your ticket from camera roll.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.primaryColor,
                      ),




                    ],
                  ),
                ),
              ),

            ElevatedButton(
              onPressed: () {
                // Add OCR logic here
                // If successful, move to the next step
                onNext();
              },
              child: Text('Apply OCR'),
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

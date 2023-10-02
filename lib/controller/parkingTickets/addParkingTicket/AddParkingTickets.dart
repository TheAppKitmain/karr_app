import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/CustomStepper.dart';

class AddParkingTickets extends StatefulWidget {
  const AddParkingTickets({super.key});

  @override
  State<AddParkingTickets> createState() => _AddParkingTicketsState();
}

class _AddParkingTicketsState extends State<AddParkingTickets> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 80,),
            Row(children: [Spacer(),Text("Step 1",style: TextStyle(color: AppColors.black,fontFamily: "Lato",fontSize: 18),),SizedBox(width: 20,)],),
            CustomStepper(
              steps: 3,
              currentStep: 2, // Change this to control the current step
            ),
            Expanded(
              flex: 1,
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
      ),
    );
  }
}

class Step1Screen extends StatelessWidget {
  final VoidCallback onNext;

  Step1Screen({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Step 1: Scan Ticket'),
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

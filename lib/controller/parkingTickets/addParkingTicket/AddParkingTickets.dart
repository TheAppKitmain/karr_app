import 'package:camera/camera.dart';
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



class Step2Screen extends StatefulWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  Step2Screen({required this.onPrevious, required this.onNext});

  @override
  _Step2ScreenState createState() => _Step2ScreenState();
}

class _Step2ScreenState extends State<Step2Screen> {
  late CameraController _cameraController;
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await _cameraController.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: _cameraController.value.aspectRatio,
          child: CameraPreview(_cameraController),
        ),
        Positioned(
          bottom: 16,
          child: ElevatedButton(
            onPressed: () {
              // Capture the image or perform OCR logic here
            },
            child: Text('Capture Image'),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: ElevatedButton(
            onPressed: () {
              widget.onPrevious();
            },
            child: Text('Back to Step 1'),
          ),
        ),
      ],
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

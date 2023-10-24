import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'package:image/image.dart' as img;
import 'dart:io';

import 'package:kaar/utils/Constants.dart';

class DateGetScreen extends StatefulWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  DateGetScreen({required this.onPrevious, required this.onNext});

  @override
  _DateGetScreenState createState() => _DateGetScreenState(onPrevious: onPrevious,onNext:onNext );
}

class _DateGetScreenState extends State<DateGetScreen> {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  _DateGetScreenState({required this.onPrevious, required this.onNext});
  late CameraController _controller;
  bool isReady = false;
  bool textScanning = false;
  TextEditingController textController = TextEditingController();
  String scannedText = "";
  int tab = 0;
  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = TextRecognizer();
    RecognizedText recognisedText = await textRecognizer.processImage(inputImage);
    await textRecognizer.close();
    scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }
    textController.text=scannedText;
    setState(() {
      textScanning = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(scannedText),
      ),
    );
    print("scanned text is $scannedText");
    setState(() {});
  }
  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    await _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      isReady = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> captureAndCrop() async {
    try {
      final image = await _controller.takePicture();

      final RenderBox upperContainer = _upperContainerKey.currentContext!.findRenderObject() as RenderBox;
      final RenderBox bottomContainer = _bottomContainerKey.currentContext!.findRenderObject() as RenderBox;

      final double x = 0;
      final double y = upperContainer.localToGlobal(Offset(0, 0)).dy;
      final double width = MediaQuery.of(context).size.width;
      final double height = bottomContainer.localToGlobal(Offset(0, 0)).dy - upperContainer.localToGlobal(Offset(0, 0)).dy;

      final rawImage = img.decodeImage(File(image.path).readAsBytesSync())!;

      final croppedImage = img.copyCrop(rawImage, x: x.toInt(), y: y.toInt(), width: width.toInt(), height: height.toInt());


      File(image.path).writeAsBytesSync(img.encodeJpg(croppedImage));
      final croppedXFile = XFile(image.path);
      getRecognisedText(croppedXFile);
      // You can use the croppedImagePath as needed for further processing or display.
    } catch (e) {
      print(e);
    }
  }

  final GlobalKey _upperContainerKey = GlobalKey();
  final GlobalKey _bottomContainerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          if (isReady) CameraPreview(_controller),
          if (textScanning)
            Container(
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ticket Issued Date:",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.07,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white, // Border color
                        width: 2.0,           // Border width
                      ),
                      borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                    ),
                    child: TextFormField(
                      controller: textController, // Display scanned text
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.05,
                      ),
                      decoration: InputDecoration(
                        // Optional hint text
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none, // Remove the default border of the TextFormField
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () async {
                      // Handle the "Next" button click
                      String updatedText = textController.text;
                      await SharedStorage().saveStringToLocalStorage('Ticket_date', updatedText);
                      onNext();
                      // Perform further actions with the updated text
                      // ...

                      // Reset the UI for capturing the next image
                      setState(() {
                        textScanning = false;
                        textController.clear();
                      });
                    },
                    child: Text("Next"),
                  ),
                ],
              ),
            ),// Camera preview
          if (!textScanning)
            Container(
              child: Column(
                children: [
                  Container(
                    color: Colors.black,
                    key: _upperContainerKey,// Set the background color of the Center
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(),
                        SizedBox(height: height * 0.1),
                        Text(
                          "Take a picture of the ticket Date",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.07,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Point the camera to the Date",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.05,
                          ),
                        ),
                        SizedBox(height: height * 0.1),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.15),
                  Container(
                    color: Colors.black,
                    key: _bottomContainerKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(),
                        SizedBox(height: height * 0.2),
                        ElevatedButton(
                          onPressed: captureAndCrop, // Capture and crop when the button is pressed
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.transparent), // Remove background color
                            foregroundColor: MaterialStateProperty.all(Colors.white), // Set icon color to white
                          ),
                          child: Icon(
                            Icons.camera,
                            size: 60,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}

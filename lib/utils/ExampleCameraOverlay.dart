import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_camera_overlay/flutter_camera_overlay.dart';
import 'package:flutter_camera_overlay/model.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/cameraOverlayWidget.dart';



class ExampleCameraOverlay extends StatefulWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  ExampleCameraOverlay({required this.onPrevious, required this.onNext});

  @override
  _ExampleCameraOverlayState createState() => _ExampleCameraOverlayState();
}

class _ExampleCameraOverlayState extends State<ExampleCameraOverlay> {
  OverlayFormat format = OverlayFormat.simID000;
  bool textScanning = false;

  XFile? imageFile;

  String scannedText = "";
  int tab = 0;
  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    RecognizedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }
    textScanning = false;
    ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(scannedText),
            ),
          );
    print("scanned text is $scannedText");
    setState(() {});
  }
  // Future scanText() async {
  //
  //   final FirebaseVisionImage visionImage =
  //   FirebaseVisionImage.fromFile(File(_image.path));
  //   final TextRecognizer textRecognizer =
  //   FirebaseVision.instance.textRecognizer();
  //   final VisionText visionText =
  //   await textRecognizer.processImage(visionImage);
  //
  //   for (TextBlock block in visionText.blocks) {
  //     for (TextLine line in block.lines) {
  //       _text += line.text + '\n';
  //     }
  //   }
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(_text),
  //     ),
  //   );
  // //   Navigator.of(context).pop();
  // //   Navigator.of(context)
  // //       .push(MaterialPageRoute(builder: (context) => Details(_text)));
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(

          backgroundColor: Colors.white,
          body: FutureBuilder<List<CameraDescription>?>(
            future: availableCameras(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == null) {
                  return const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'No camera found',
                        style: TextStyle(color: Colors.black),
                      ));
                }
                return cameraOverlayWidget(
                    snapshot.data!.first,
                    CardOverlay.byFormat(format),
                        (XFile file) => showDialog(
                      context: context,
                      barrierColor: AppColors.black,
                      builder: (context) {
                        CardOverlay overlay = CardOverlay.byFormat(format);
                        return AlertDialog(
                            actionsAlignment: MainAxisAlignment.center,
                            backgroundColor: Colors.black,
                            title: const Text('Capture',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center),
                            actions: [
                              OutlinedButton(
                                  // onPressed: () => Navigator.of(context).pop(),
                                  onPressed: () {
                                   getRecognisedText(file);
                                  },
                                  child: const Icon(Icons.done))

                            ],
                            content: SizedBox(
                                width: double.infinity,
                                child: AspectRatio(
                                  aspectRatio: overlay.ratio!,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          alignment: FractionalOffset.center,
                                          image: FileImage(
                                            File(file.path),
                                          ),
                                        )),
                                  ),
                                )));
                      },
                    ),
                    info:
                    'Please point the camera on the ticket number.',
                    label: 'Take Photo Of Your Ticket Number');
              } else {
                return const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Fetching cameras',
                      style: TextStyle(color: Colors.black),
                    ));
              }
            },
          ),
        ));
  }
}
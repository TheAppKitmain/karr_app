import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as img;
import 'dart:io';

import 'package:kaar/utils/Constants.dart';

class CameraScreen extends StatefulWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  CameraScreen({required this.onPrevious, required this.onNext});

  @override
  _CameraScreenState createState() =>
      _CameraScreenState(onPrevious: onPrevious, onNext: onNext);
}

class _CameraScreenState extends State<CameraScreen> {
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  _CameraScreenState({required this.onPrevious, required this.onNext});

  late CameraController _controller;
  bool isReady = false;
  bool textScanning = false;
  TextEditingController textController = TextEditingController();
  File? capturedImage;

  String scannedText = "";
  String pcnNumber = "PCN Number: N/A";
  String date = "Date: N/A";
  String issuerName = "Issuer Name: N/A";
  String charge = "Charge: N/A";

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

    textController.text = scannedText;
    List<String> keywordsToExtractPcn = ["PCN Number :", "Penalty Charge Notice :","Penalty Charge Notice Number :","Notice Number :","(PCN) Number :"];

    List<String> keywordsToExtractCOMPANYNAME = ["BARNET", "BEXLEY","BROMLEY ","CAMDEN","CITY OF LONDON","CROYDON","EALING","ENFIELD","GREENWICH","HECKNEY COUNCIL"
      ,"HAVERING","HILLINGDON","HOUNSLOW","ISLINGTON","HAMMERRSMITH & FULHAM","HARINGEY","HARROWCOUNCIL","KENSINGTON AND CHELSEA","KINGSTON UPON THAMES","LAMBETH"
      ,"LEWISHAM","NEWHAM","REDBRIDGE","RICHMOND","SUTTON","TRANSPORT FOR LONDON","TOWER HAMLETS","WALTHAM FOROST","WANDSWORTH","WESTMINSTER"];

    // Extract the desired information using regex
    pcnNumber = extractText(keywordsToExtractPcn, scannedText);
    date = extractDate("Date:", scannedText);
    issuerName = extractcompanyname(keywordsToExtractCOMPANYNAME, scannedText);
    charge = extractCharge(scannedText);
    print("Scanned text is $issuerName");
    await SharedStorage().saveStringToLocalStorage('Ticket_number', pcnNumber);
    await SharedStorage().saveStringToLocalStorage('Ticket_date', date);
    await SharedStorage().saveStringToLocalStorage('Ticket_charge', charge);
    await SharedStorage().saveStringToLocalStorage('Issuer_name', issuerName);
    onNext();
    setState(() {
      textScanning = true;
    });
  }

  String extractText(List<String> keywords, String source) {
    for (String keyword in keywords) {
      RegExp regExp = RegExp('$keyword\\s*([^\\s]+)', caseSensitive: false);
      Match? match = regExp.firstMatch(source);
      if (match != null) {
        return match.group(1) ?? "N/A";
      }
    }
    return "N/A";
  }


  String extractDate(String keyword,String source) {
    RegExp regExp = RegExp(r'(\d{2}/\d{2}/\d{2,4})', caseSensitive: false);
    Match? match = regExp.firstMatch(source);
    if (match != null) {
      return '' + match.group(1)!;
    }
    return ' N/A';
  }


  String extractcompanyname(List<String> keywords, String source) {
    for (String keyword in keywords) {
      print("keyword $keyword");
      if (source.toLowerCase().contains(keyword.toLowerCase())) {
        return keyword;
      }
    }
    return "N/A";
  }

  String extractCharge(String source) {
    RegExp regExp = RegExp(r'£\s*(\d+(\.\d{1,2})?)', caseSensitive: false);
    Match? match = regExp.firstMatch(source);
    if (match != null) {
      return 'Charge: £' + match.group(1)!;
    }
    return 'Charge: N/A';
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

  Future<void> captureAndProcess() async {
    try {
      final image = await _controller.takePicture();

      final rawImage = img.decodeImage(File(image.path).readAsBytesSync())!;
      File(image.path).writeAsBytesSync(img.encodeJpg(rawImage));

      capturedImage = File(image.path);
      getRecognisedText(XFile(image.path));
    } catch (e) {
      print(e);
    }
  }

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
                    "PCN Number: ${pcnNumber}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.07,
                    ),
                  ),
                  Text(
                    "Date: ${date}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.07,
                    ),
                  ),
                  Text(
                    "Vehicle Number: ${issuerName}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.07,
                    ),
                  ),
                  Text(
                    charge,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.07,
                    ),
                  ),
                  Image.file(
                    capturedImage!,
                    width: 200, // Adjust the width as needed
                    height: 200, // Adjust the height as needed
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      // Handle the "Next" button click
                      String updatedText = textController.text;
                      await SharedStorage().saveStringToLocalStorage('Ticket_number', updatedText);
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
            ),
          if (!textScanning)
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      color: Colors.black,
                      child: ElevatedButton(
                        onPressed: captureAndProcess,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.transparent),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                        ),
                        child: Icon(
                          Icons.camera,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

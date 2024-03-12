import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as img;
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'dart:convert';

class CameraScreen extends StatefulWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final Function(File) image;
  CameraScreen({required this.onPrevious, required this.onNext, required this.image});

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
  String? userid;
  String? adminid;
  String scannedText = "";
  String pcnNumber = "PCN Number: ";
  String date = "Date: ";
  String issuerName = "Issuer Name: ";
  String charge = "Charge: ";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadUserDetails();
      initializeCamera();
    });
  }

  void loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted)setState(() {
      userid = prefs.getString('userid');
      adminid = prefs.getString('adminid');
    });
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

    print('all scanned text is $scannedText');
    textController.text = scannedText;
    List<String> keywordsToExtractPcn = ["PCN number :","PCN number:","PCN Number","PCN Number :","PCN Number:", "Penalty Charge Notice ", "Penalty Charge Notice : ", "Penalty Charge Notice: ","Penalty Charge Notice (PCN) Number :","Penalty Charge Notice (PCN) Number:","Penalty Charge Notice Number :","Penalty Charge Notice Number:","Notice Number :","Notice Number:","Notice number :","Notice number:","Notice Number","(PCN) Number :","(PCN) Number:","PCN no.: ","PCN no. : ","PCN No.: ","PCN No. : ","PCN No : ","PCN No: "];

    List<String> keywordsToExtractCOMPANYNAME = ["BARNET", "BEXLEY","BROMLEY ","CAMDEN","CITY OF LONDON","CROYDON","EALING","ENFIELD","GREENWICH","HACKNEY COUNCIL"
      ,"HAVERING","HILLINGDON","HOUNSLOW","ISLINGTON","HAMMERRSMITH & FULHAM","HARINGEY","HARROWCOUNCIL","KENSINGTON AND CHELSEA","KINGSTON UPON THAMES","LAMBETH"
      ,"LEWISHAM","NEWHAM","REDBRIDGE","RICHMOND","SUTTON","TRANSPORT FOR LONDON","TOWER HAMLETS","WALTHAM FOROST","WANDSWORTH","WESTMINSTER"];

    // Extract the desired information using regex
    // print('sacnned text is $scannedText');
    pcnNumber = extractText(keywordsToExtractPcn, scannedText);
    date = UniversalformatDate(extractDate("Date:", scannedText));
    issuerName = extractcompanyname(keywordsToExtractCOMPANYNAME, scannedText);
    charge = extractCharge(scannedText);

    await SharedStorage().saveStringToLocalStorage('Ticket_number', pcnNumber);
    await SharedStorage().saveStringToLocalStorage('Ticket_date', date);
    await SharedStorage().saveStringToLocalStorage('Ticket_charge', charge);
    await SharedStorage().saveStringToLocalStorage('Issuer_name', issuerName);
    widget.image!(capturedImage!);
    onNext();
    if (mounted)setState(() {
      textScanning = true;
    });
  }
  String UniversalformatDate(String dateString) {
    // List of possible date formats
    List<String> possibleFormats = [
      'dd/MM/yy', // 13/12/09
      'dd MMM yyyy', // 13 sep 2020
      'dd MMMM yyyy', // 13 september 2020
      'yyyy-dd-MM', //
      'dd-MM-yyyy', //
      'dd-MM-yy', //
      // Add more formats as needed
    ];

    // Iterate through possible formats and try parsing
    for (String format in possibleFormats) {
      try {
        DateTime date = DateFormat(format).parse(dateString);
        // Format the parsed date into "YYYY-MM-DD" format

        print("date in ticket format is ${DateFormat('dd-MM-yyyy').format(date)}");
        return DateFormat('dd-MM-yyyy').format(date);
      } catch (e) {
        // If parsing fails, continue to the next format
        continue;
      }
    }

    // If none of the formats match, return empty string or handle error as needed
    return '';
  }
  String extractText(List<String> keywords, String source) {
    for (String keyword in keywords) {
      print('keyword$keyword');
      RegExp regExp = RegExp('$keyword\\s*([^\\s]+)', caseSensitive: false);
      Match? match = regExp.firstMatch(source);

      if (match != null) {
        return match.group(1) ?? "";
      }
    }
    return "Not Recognized";
  }

  // String extractText(List<String> keywords, String source) {
  //
  //   for (String keyword in keywords) {
  //     print("keyword $keyword$source");
  //     RegExp regExp = RegExp('$keyword \\s*([^\\s]+)', caseSensitive: false);
  //     // RegExp regExp = RegExp('$keyword\\s*:?\\s*([^\\s]+)', caseSensitive: false);
  //     Match? match = regExp.firstMatch(source);
  //
  //     if (match != null) {
  //       return match.group(1) ?? "";
  //     }
  //   }
  //   return "Not Recognized";
  // }



  String extractDate(String keyword,String source) {
    RegExp regExp = RegExp(r'(\d{2}/\d{2}/\d{2,4})', caseSensitive: false);
    Match? match = regExp.firstMatch(source);
    if (match != null) {
      return '' + match.group(1)!;
    }
    return 'Date';
  }


  String extractcompanyname(List<String> keywords, String source) {
    for (String keyword in keywords) {

      if (source.toLowerCase().contains(keyword.toLowerCase())) {
        return keyword;
      }
    }
    return "Select Issuer";
  }

  String extractCharge(String source) {
    RegExp regExp = RegExp(r'£\s*(\d+(\.\d{1,2})?)', caseSensitive: false);
    Match? match = regExp.firstMatch(source);
    if (match != null) {
      return   "${match.group(1)!}";
    }
    return '';
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    await _controller.initialize();
    if (!mounted) {
      return;
    }
    if (mounted)setState(() {
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

    return
      Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          if (isReady) Container(height:height*0.75,child: CameraPreview(_controller)),

            Column(
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
                SizedBox(height: height*0.02,),
              ],
            ),
        ],
      ),
    );
  }
}

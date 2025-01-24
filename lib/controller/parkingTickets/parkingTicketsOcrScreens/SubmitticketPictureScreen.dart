import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:image/image.dart' as img;
import 'package:kaar/utils/Constants.dart';
import 'dart:convert';



import 'package:http_parser/http_parser.dart';
import 'package:kaar/widgets/CustomDialoboxTicketPictureUpload.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
class TicketCameraScreen extends StatefulWidget {
  const TicketCameraScreen({super.key});

  @override
  State<TicketCameraScreen> createState() => _TicketCameraScreenState();
}

class _TicketCameraScreenState extends State<TicketCameraScreen> {

  late CameraController _controller;
  bool isReady = false;
  File? capturedImage;
  String? userid;
  String? adminid;
  bool textScanning = false;
  bool _isLoading = false;
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
  Future<void> captureAndProcess() async {
    try {
      final image = await _controller.takePicture();

      final rawImage = img.decodeImage(File(image.path).readAsBytesSync())!;
      File(image.path).writeAsBytesSync(img.encodeJpg(rawImage));

      capturedImage = File(image.path);

      textScanning=true;
      if (mounted)setState(() {

      });
      // getRecognisedText(XFile(image.path));
    } catch (e) {
      print(e);
    }
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  Future<void> upload(File imageFile, BuildContext context,) async {
    // Print the file extension for debugging
    print('File extension: ${extension(imageFile.path)}');

    // string to uri
    var uri = Uri.parse("https://dashboard.karrcompany.co.uk/api/fines");
    var request = http.MultipartRequest("POST", uri);
    request.fields['driver_id'] = userid ?? "1";
    request.fields['user_id'] = adminid ?? '3';

    // Print the content type for debugging
    print('Content type: ${MediaType('image', 'jpg',)}');

    // Print the file size for debugging
    print('File size: ${await imageFile.length()} bytes');

    // Add the image to the request
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
      contentType: MediaType('image', 'jpg'),
    ));

    // Send the request
    request.send().then((response) {
      if (response.statusCode == 200) {
        response.stream.transform(utf8.decoder).listen((value) {
          print(value);
          if (mounted)setState(() {
            _isLoading = false;
          });
        });
        CustomDialoboxTicketPictureUpload.show(context, true, "Ticket Submitted", "Great! Your ticket has been submitted successfully.");
      }else if(response.statusCode == 401){
        logOut(context);
      }
        else {
        if (mounted)setState(() {
          _isLoading = false;
        });
        CustomDialoboxTicketPictureUpload.show(context, false, "Ticket not Submitted", "Your Ticket has not been submitted ");
        print('Error: ${response.statusCode}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: AppColors.white,
        ),

        body: Stack(
          children: <Widget>[

            if (isReady) Container(height:height*0.8,child: CameraPreview(_controller)),
            if (textScanning)
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Row(),
                    Image.file(
                      capturedImage!,

                    ),
                    SizedBox(height: 10),

                    _isLoading
                        ? const CircularProgressIndicator()
                        :  ElevatedButton(
                      onPressed: () async {
                        // Handle the "Next" button click
                        // String updatedText = textController.text;
                        // await SharedStorage().saveStringToLocalStorage('Ticket_number', updatedText);
                        // onNext();
                        // Perform further actions with the updated text
                        // ...

                        // Reset the UI for capturing the next image
                        if (mounted)setState(() {
                          _isLoading = true;
                        });
                        upload( capturedImage!,context);

                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("Submit Ticket",style: TextStyle(color: AppColors.white),),
                      ),
                    ),
                  ],
                ),
              ),
            if (!textScanning)
              Container(
                child: Column(


                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(

                          color: Colors.black,

                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: ElevatedButton(
                          onPressed: captureAndProcess,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.transparent),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                          ),
                          child: Icon(
                            Icons.camera,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height*0.03,),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaar/controller/home/HomeScreen.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/PrimaryButton.dart';
import 'package:lottie/lottie.dart';

class CustomDialogBox {
  static void show(BuildContext context, bool successful, String title, String description) {
    bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;
    if (isIOS) {
      showCupertinoDialog(

        context: context,

        builder: (BuildContext context) {
          double height = MediaQuery.of(context).size.height;
          double width = MediaQuery.of(context).size.width;
          return CupertinoAlertDialog(

            content: Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.transparent,
                margin: const EdgeInsets.all(16.0), // Add margin from all sides
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Lottie.asset(
                      'assets/json/success_animation.json',
                      width: width*0.2,
                      height: height*0.2,
                    ), // Add your Lottie animation widget
                    Text(title,
                      style: TextStyle(
                        color: AppColors.black,
                        fontFamily: "Lato",
                        fontSize: width * 0.06,
                      ),),
                    Text(description,
                        style: TextStyle(
                          color: AppColors.black,
                          fontFamily: "Lato-Regular",
                          fontSize: width * 0.035,
                        )),
                    SizedBox(height: height*0.08,),
                    PrimaryButton(


                      onPressed: () {
                        // Navigate to the home screen
                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute(builder: (context) => HomeScreen()),
                        // );
                      }, text: 'Go to Home Screen',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          double height = MediaQuery.of(context).size.height;
          double width = MediaQuery.of(context).size.width;
          return Dialog(
            backgroundColor: Colors.transparent,

              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),


                 // Add margin from all sides
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Lottie.asset(
                      'assets/json/success_animation.json',
                      width: width*0.3,
                      height: height*0.3,
                    ), // Add your Lottie animation widget
                    Text(title,
                      style: TextStyle(
                        color: AppColors.black,
                        fontFamily: "Lato",
                        fontSize: width * 0.06,
                      ),),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(description,
                          style: TextStyle(
                        color: AppColors.black,
                        fontFamily: "Lato-Regular",
                        fontSize: width * 0.035,
                      )),
                    ),
                    SizedBox(height: height*0.04,),
                    PrimaryButton(


                      onPressed: () {
                        // Navigate to the home screen
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomeScreen("kyle"," mt9 2291")),
                        );
                      }, text: 'Go to Home Screen',
                    ),
                  ],
                ),
              ),

          );
        },
      );
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/parkingTickets/addParkingTicket/AddTicketManually.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/MyHomePage.dart';
import 'package:kaar/widgets/PrimaryButton.dart';
import 'package:lottie/lottie.dart';

class CustomDialoboxTicketPictureUpload {
  static void show(
      BuildContext context, bool successful, String title, String description) {
    bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final animationWidth = width * 0.6;
    final animationHeight = height * 0.18;
    final fontSizeTitle = width * 0.06;
    final fontSizeDescription = width * 0.035;
    final buttonHeight = height * 0.04;

    if (isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              height: height * 0.6,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Lottie.asset(
                      successful
                          ? 'assets/json/success_animation.json'
                          : 'assets/json/cancel.json',
                      width: animationWidth,
                      height: animationHeight,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        color: AppColors.black,
                        fontFamily: "Lato",
                        fontSize: fontSizeTitle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.black,
                          fontFamily: "Lato-Regular",
                          fontSize: fontSizeDescription,
                        ),
                      ),
                    ),
                    Spacer(),
                    PrimaryButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => AddTicketManually()),
                        );
                      },
                      text: 'Enter Manually',
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
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Lottie.asset(
                    successful
                        ? 'assets/json/success_animation.json'
                        : 'assets/json/cancel.json',
                    width: animationWidth,
                    height: animationHeight,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.black,
                      fontFamily: "Lato",
                      fontSize: fontSizeTitle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.black,
                        fontFamily: "Lato-Regular",
                        fontSize: fontSizeDescription,
                      ),
                    ),
                  ),
                  Spacer(),
                  PrimaryButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => AddTicketManually()),
                      );
                    },
                    text: 'Enter Manually',
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

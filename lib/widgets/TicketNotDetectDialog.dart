import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/parkingTickets/addParkingTicket/AddTicketManually.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/MyHomePage.dart';
import 'package:kaar/widgets/PrimaryButton.dart';
import 'package:lottie/lottie.dart';

class TicketNotDetect {
  static void show(
      BuildContext context, String title, String description,Function() onprevious) {
    bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final buttonWidth = width * 0.3;
    final fontSize = width * 0.03;
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
                       'assets/json/cancel.json',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          width: buttonWidth,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => AddTicketManually()),
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(
                                  color: AppColors.primaryColor,
                                  width: 1,
                                ),
                              ),

                            ),
                            child:  Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Manual",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: fontSize,
                                  fontFamily: 'latoblack',
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 10),
                        TextButton(
                          onPressed:(){
                            Navigator.pop(context);
                            onprevious();},
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),
                            ),
                            minimumSize: Size(buttonWidth, 0),
                          ),
                          child:  Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Try again",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: fontSize,
                                fontFamily: 'latoblack',
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 30,)
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
                     'assets/json/cancel.json',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        width: buttonWidth,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => AddTicketManually()),
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),
                            ),

                          ),
                          child:  Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Manual",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: fontSize,
                                fontFamily: 'latoblack',
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 10),
                      TextButton(
                        onPressed:(){
                          Navigator.pop(context);
                          onprevious();},
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(
                              color: AppColors.primaryColor,
                              width: 1,
                            ),
                          ),
                          minimumSize: Size(buttonWidth, 0),
                        ),
                        child:  Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Try again",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: fontSize,
                              fontFamily: 'latoblack',
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 30,)

                ],
              ),
            ),
          );
        },
      );
    }
  }
}

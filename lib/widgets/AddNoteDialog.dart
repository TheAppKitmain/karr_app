import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:lottie/lottie.dart';

class AddNoteDialog {
  static void show(BuildContext context, String id, Function(String?) onSave) {
    bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;
    TextEditingController _noteController = TextEditingController();

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final buttonWidth = width * 0.3;
    final fontSize = width * 0.03;

    if (isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                height: height * 0.42,
                margin: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(width: 10),
                    Text(
                      "Add Note",
                      style: TextStyle(fontSize: 18, color: AppColors.black, fontFamily: "Lato"),
                    ),
                    SizedBox(height: height * 0.05),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _noteController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "  Notes...",
                          hintStyle: TextStyle(color: Colors.grey.shade300),
                        ),
                        maxLines: 8,
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
                              Navigator.pop(context);
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
                                "Cancel",
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
                          onPressed: () {
                            onSave!(_noteController.text);
                            Navigator.pop(context);
                          },
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
                              "Save",
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
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                height: height * 0.42,
                margin: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(width: 10),
                    Text(
                      "Add Note",
                      style: TextStyle(fontSize: 18, color: AppColors.black, fontFamily: "Lato"),
                    ),
                    SizedBox(height: height * 0.05),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _noteController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "  Notes...",
                          hintStyle: TextStyle(color: Colors.grey.shade300),
                        ),
                        maxLines: 8,
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
                                Navigator.pop(context);
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
                                  "Cancel",
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
                            onPressed: () {
                              onSave!(_noteController.text);
                              Navigator.pop(context);
                            },
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
                                "Save",
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
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}

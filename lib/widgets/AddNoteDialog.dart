import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/CustomTextField.dart';
import 'package:kaar/widgets/PrimaryButton.dart';
import 'package:lottie/lottie.dart';

class AddNoteDialog {
  static void show(BuildContext context, String id,  Function(String?) onSave) {
    bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;
    TextEditingController _noteController = TextEditingController();

    if (isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          double height = MediaQuery.of(context).size.height;
          double width = MediaQuery.of(context).size.width;
          return CupertinoAlertDialog(
            content:
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                height: height * 0.4,
                margin: const EdgeInsets.all(16.0), // Add margin from all sides
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Add Note",
                      style: TextStyle(
                          fontSize: 18,
                          color: AppColors.black,
                          fontFamily: "Lato"),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),


                    Card(
                      elevation: 4, // Adjust the elevation value as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the radius as needed
                      ),

                      child: TextFormField(
                        controller: _noteController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "  Notes...",
                        ),
                        maxLines: 8,
                      ),
                    ),


                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () { Navigator.pop(context);},
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
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Cancle",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 16,
                                  fontFamily: 'latoblack',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextButton(
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
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Save",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontFamily: 'latoblack',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
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
          double height = MediaQuery.of(context).size.height;
          double width = MediaQuery.of(context).size.width;
          return Dialog(
              backgroundColor: Colors.transparent,

              child: Card(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
            child: Container(
              height: height * 0.4,
              margin: const EdgeInsets.all(16.0), // Add margin from all sides
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Add Note",
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColors.black,
                        fontFamily: "Lato"),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),


                    Card(
                      elevation: 4, // Adjust the elevation value as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the radius as needed
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
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () { Navigator.pop(context);},
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
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Cancle",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontFamily: 'latoblack',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextButton(
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
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Save",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontFamily: 'latoblack',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
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

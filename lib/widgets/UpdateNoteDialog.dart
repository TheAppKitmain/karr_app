import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/CustomSnackBar.dart';


class UpdateNoteDialog {


  static void show(BuildContext context, String id, String initial_note, String type, Function(String?) onSave) {
    bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;
    TextEditingController _noteController = TextEditingController();
    _noteController.text=initial_note;

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
                          onPressed: () async {
                            final dio = Dio();

                            print("$type,${id}");
                            try {
                              final response = await dio.post(
                                'http://ec2-54-146-4-118.compute-1.amazonaws.com/api/add/notes',
                                queryParameters: {
                                  type: id,
                                  "notes": _noteController.text,
                                },
                              );

                              final responseData = response.data as Map<String, dynamic>;
                              print(responseData);

                              if (response.statusCode == 200) {
                                final status = responseData['status'] as bool;
                                final message = responseData['message'] as String;

                                if (status) {

                                  onSave!(_noteController.text);
                                  Navigator.pop(context);
                                  CustomSnackBar.showSnackBar(context, message);


                                } else {
                                  CustomSnackBar.showSnackBar(context, message);
                                }
                              } else {
                                CustomSnackBar.showSnackBar(context, "Some Error Occour");
                              }
                            } catch (e) {

                              CustomSnackBar.showSnackBar(context, "Api Request Failed");
                            }


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
                              "Update",
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
                          onPressed: () async {
                            final dio = Dio();

                            print("$type,${id}");
                            try {
                              final response = await dio.post(
                                'http://ec2-54-146-4-118.compute-1.amazonaws.com/api/add/notes',
                                queryParameters: {
                                  type: id,
                                  "notes": _noteController.text,
                                },
                              );

                              final responseData = response.data as Map<String, dynamic>;
                              print(responseData);

                              if (response.statusCode == 200) {
                                final status = responseData['status'] as bool;
                                final message = responseData['message'] as String;

                                if (status) {

                                  onSave!(_noteController.text);
                                  Navigator.pop(context);
                                  CustomSnackBar.showSnackBar(context, message);


                                } else {
                                  CustomSnackBar.showSnackBar(context, message);
                                }
                              } else {
                                CustomSnackBar.showSnackBar(context, "Some Error Occour");
                              }
                            } catch (e) {

                              CustomSnackBar.showSnackBar(context, "Api Request Failed");
                            }


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
                              "Update",
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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaar/utils/Constants.dart';


class DeleteDialog {
  static void show(BuildContext context) {
    bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;


    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;


    if (isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                height: height * 0.1,
                margin: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Deleting ticket",style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Center(child: CircularProgressIndicator()),
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
                height: height * 0.1,
                margin: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Deleting ticket",style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Center(child: CircularProgressIndicator()),
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

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Future<DateTime?> getDatePicker(BuildContext context) async {

  DateTime? pickedDate;
  if(Platform.isIOS)
  {
    return showCupertinoModalPopup(
      context: context, builder: (BuildContext context) {
      return Container(
        height: 400,
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5))),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text(
                  'Cancel',
                )),
                TextButton(onPressed: (){
                  Navigator.pop(context,pickedDate);
                }, child: Text(
                  'Done',
                ))

              ],),
            const SizedBox(height: 30),
            SizedBox(
              height: 300,
              child: CupertinoDatePicker(
                  initialDateTime: DateTime(1980),
                  maximumDate: DateTime.now(),
                  minimumDate: DateTime(1900),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (val) {
                    pickedDate=val;
                  }),
            ),
          ],
        ),
      );
    },
    );

  }
  pickedDate= await showDatePicker(
    context:context,
    initialDate: DateTime(1980),
    firstDate: DateTime(1900),
    //DateTime.now() - not to allow to choose before today.
    lastDate: DateTime.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme:     const ColorScheme.light(
            onPrimary: Colors.white, // <-- SEE HERE
            onSurface: Colors.black, // <-- SEE HERE
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );
  return pickedDate;
}
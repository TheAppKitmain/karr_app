import 'package:emobility/widgets/sizer.dart';
import 'package:emobility/widgets/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../src/utils/constants.dart';

Future<DateTime?> getDatePicker() async {

  DateTime? pickedDate;
  if(GetPlatform.isIOS)
  {
    return showCupertinoModalPopup(
      context: Get.context!, builder: (BuildContext context) {
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
                  Get.back();
                }, child: Text(
                  'Cancel',
                  style: StyleRefer.poppinsMedium.copyWith(fontSize: 12.sp),
                )),
                TextButton(onPressed: (){
                  Get.back(result: pickedDate);
                }, child: Text(
                  'Done',
                  style: StyleRefer.poppinsBold.copyWith(fontSize: 14.sp),
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
    context: Get.context!,
    initialDate: DateTime(1980),
    firstDate: DateTime(1900),
    //DateTime.now() - not to allow to choose before today.
    lastDate: DateTime.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme:     const ColorScheme.light(
            primary: AppColors.arsenic, // <-- SEE HERE
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
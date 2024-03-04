

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/Notes/ActivityDataClass/ActivityDataClass.dart';

import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/UpdateNoteDialog.dart';
import 'package:kaar/widgets/flutter_ticket_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class AllCityChargeItemView extends StatelessWidget {
  final Charges cityCharge;




  const AllCityChargeItemView({super.key,
    required this.cityCharge,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return
      Card(
          elevation: 1,
        color: Colors.white,
          margin: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
          ),
         child:
    Padding(
    padding: EdgeInsets.all(10.0),
        child: SizedBox(
    // Set margin of 20 from right and left
           width: double.infinity,

           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [

               Row(
                 children: [
                   Text('${cityCharge.name}',style: TextStyle(color: AppColors.black,fontSize: width*0.04,fontFamily: "Lato"),textAlign: TextAlign.left,),
                 ],
               ),
               SizedBox(height: 10,),
               Row(
                 children: [
                   Text(formatWithSuffix(cityCharge.date!),style: TextStyle(color: AppColors.black,fontSize: width*0.035,fontFamily: "Lato-Regular")),
                 ],
               ),
               SizedBox(height: 10,),
               GestureDetector (
                 onTap: () {
                   UpdateNoteDialog.show(context, cityCharge.cd.toString(),cityCharge.notes.toString(),"cd", (v) {
                     cityCharge.notes = v; //note added for this item
                   });
                 },
                 child: Row(
                   children:  [
                     Text(
                       'See Note',
                       style: TextStyle(fontSize: width*0.033, color: AppColors.primaryColor),
                     ),
                     Icon(
                       Icons.arrow_forward_ios,
                       color: AppColors.primaryColor,
                       size: 15,
                     ),
                   ],
                 ),
               ),

             ],
           ),
         ),
    ),


      );

  }
  String formatWithSuffix(String date) {
    DateFormat format = DateFormat('dd-MM-yyyy');
    DateTime dateTime = format.parse(date);
    String suffix = 'th';
    int day = dateTime.day;
    if (day == 1 || day == 21 || day == 31) {
      suffix = 'st';
    } else if (day == 2 || day == 22) {
      suffix = 'nd';
    } else if (day == 3 || day == 23) {
      suffix = 'rd';
    }
    return
      // DateFormat('dd')  // Format day without suffix
      //   .format(dateTime)
      //   .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},') +
      '${dateTime.day}'+ suffix + ' ' + DateFormat('MMMM yyyy').format(dateTime);
  }
}

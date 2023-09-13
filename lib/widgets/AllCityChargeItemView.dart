

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/flutter_ticket_widget.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/material.dart';

class AllCityChargeItemView extends StatelessWidget {
  final String CityChargeName;

  final String date;


  const AllCityChargeItemView({
    required this.CityChargeName,

    required this.date,

  });

  @override
  Widget build(BuildContext context) {
    return
      Card(
          elevation: 4, // Adjust the elevation value as needed
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
          ),
         child: Container(
    // Set margin of 20 from right and left
    width: double.infinity,
           child: Column(
             children: [
               Text("data"),
               SizedBox(height: 10,),
               Text("data",),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                   Text(
                     'NM08 WOD',
                     style: TextStyle(
                         fontSize: 16, color: AppColors.primaryColor),
                   ),
                   Icon(
                     Icons.arrow_forward_ios,
                     color: AppColors.primaryColor,
                   ),
                 ],
               ),

             ],
           ),
         ),


      );

  }
}

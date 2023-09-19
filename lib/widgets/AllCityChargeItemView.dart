

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/cityCharges/dataclass/AllCityChargesDataClass.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/flutter_ticket_widget.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/material.dart';

class AllCityChargeItemView extends StatelessWidget {
  final Charges cityCharge;




  const AllCityChargeItemView({super.key,
    required this.cityCharge,
  });

  @override
  Widget build(BuildContext context) {
    return
      Card(
          elevation: 8, // Adjust the elevation value as needed
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
          ),
         child:
    Padding(
    padding: EdgeInsets.all(20.0),
        child: SizedBox(
    // Set margin of 20 from right and left
           width: double.infinity,

           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [

               Row(
                 children: [
                   Text('${cityCharge.city}, ${cityCharge.area}',style: TextStyle(color: AppColors.black,fontSize: 18,fontFamily: "Lato"),textAlign: TextAlign.left,),
                 ],
               ),
               SizedBox(height: 20,),
               Row(
                 children: [
                   Text('${cityCharge.time}am',style: TextStyle(color: AppColors.black,fontSize: 16,fontFamily: "Lato_regular")),
                 ],
               ),
               SizedBox(height: 10,),
               Row(

                 children: const [
                   Text(
                     'See Note',
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
    ),


      );

  }
}

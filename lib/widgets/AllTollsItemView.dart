

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/cityCharges/dataclass/AllCityChargesDataClass.dart';
import 'package:kaar/controller/tolls/dataClass/TollsDataClass.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/flutter_ticket_widget.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/material.dart';

class AllTollsItemView extends StatelessWidget {
  final Toll tolls;




  const AllTollsItemView({super.key,
    required this.tolls,
  });

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                    Text('${tolls.name}',style: TextStyle(color: AppColors.black,fontSize: width*0.04,fontFamily: "Lato"),textAlign: TextAlign.left,),

                SizedBox(height: 20,),

                    Text('${tolls.days}',style: TextStyle(color: AppColors.black,fontSize: width*0.035,fontFamily: "Lato-Regular")),

                SizedBox(height: 10,),
                Row(

                  children: [
                    Text(
                      'See Note',
                      style: TextStyle(
                          fontSize: width*0.035, color: AppColors.primaryColor),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.primaryColor,
                      size: 15,
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

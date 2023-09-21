

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:kaar/controller/tolls/dataClass/TollsDataClass.dart';
import 'package:kaar/utils/Constants.dart';


class AddTollsItemView extends StatelessWidget {
  final Toll tolls;




  const AddTollsItemView({super.key,
    required this.tolls,
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

            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        Text('${tolls.name}',style: TextStyle(color: AppColors.black,fontSize: 18,fontFamily: "Lato"),textAlign: TextAlign.left,),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text('${tolls.days}am',style: TextStyle(color: AppColors.black,fontSize: 16,fontFamily: "Lato_regular")),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(

                      children: const [
                        Text(
                          'Add Note',
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
              ],
            ),
          ),
        ),


      );

  }
}

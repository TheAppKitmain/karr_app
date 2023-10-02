

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:kaar/controller/tolls/dataClass/TollsDataClass.dart';
import 'package:kaar/utils/Constants.dart';


class AddTollsItemView extends StatefulWidget {
  final Toll tolls;

  const AddTollsItemView({super.key,
    required this.tolls,
  });

  @override
  State<AddTollsItemView> createState() => _AddTollsItemViewState();
}

class _AddTollsItemViewState extends State<AddTollsItemView> {
  bool _rememberMe = false;
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
          padding: EdgeInsets.all(10.0),
          child: Container(
            // Set margin of 20 from right and left


            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        Text('${widget.tolls.name}',style: TextStyle(color: AppColors.black,fontSize: 16,fontFamily: "Lato")),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text('${widget.tolls.days}',style: TextStyle(color: AppColors.black,fontSize: 14,fontFamily: "Lato-regular")),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(

                      children: const [
                        Text(
                          'Add Note',
                          style: TextStyle(
                              fontSize: 14, color: AppColors.primaryColor),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),

                  ],
                ),
                Spacer(),
                Checkbox(
                  value: _rememberMe,
                  onChanged: (bool? value) {
                    setState(() {
                      _rememberMe =
                          value ?? false; // Update the _rememberMe variable
                    });
                  },
                ),
              ],
            ),
          ),
        ),


      );

  }
}

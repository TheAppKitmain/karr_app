

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/cityCharges/AllCityCharges.dart';
import 'package:kaar/controller/cityCharges/dataclass/AllCityChargesDataClass.dart';


import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/AddNoteDialog.dart';


class AddItemView extends StatefulWidget {
  final Charges tolls;
  final Function(Charges, bool) onTollChecked;

  const AddItemView({super.key,
    required this.tolls, required this.onTollChecked,
  });

  @override
  State<AddItemView> createState() => _AddCityChargeItemViewState();
}

class _AddCityChargeItemViewState extends State<AddItemView> {
  bool _rememberMe = false;
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
          padding: EdgeInsets.all(10.0),
          child: Container(
            // Set margin of 20 from right and left


            child: Row(
              children: [
                Flexible(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      Text('${widget.tolls.city}, ${widget.tolls.area}',style: TextStyle(color: AppColors.black,fontSize: width*0.04,fontFamily: "Lato")),

                      SizedBox(height: 10,),

                      Text('EveryDay',style: TextStyle(color: AppColors.black,fontSize: width*0.035,fontFamily: "Lato-Regular")),

                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () {
                          AddNoteDialog.show(context, "Successfully Added", (v) {
                            widget.tolls.note = v; //note added for this item
                          });
                        },
                        child: Row(
                          children:  [
                            Text(
                              'Add Note',
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
                Spacer(),
                Flexible(
                  flex: 1,
                  child: Checkbox(
                    value: _rememberMe,
                    onChanged: (bool? value) {
                      if (mounted)setState(() {
                        _rememberMe = value ?? false;
                        widget.tolls.ischecked = _rememberMe;
                        widget.onTollChecked(widget.tolls, _rememberMe); // Call the callback
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),


      );

  }
}

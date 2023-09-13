
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/PrimaryButton.dart';
import 'package:kaar/widgets/ParkingTicketCard.dart';

class TicketHistory extends StatefulWidget{
  @override
  _TicketHistoryState createState()=>_TicketHistoryState();
}
class _TicketHistoryState extends State<TicketHistory>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
        child:
        Column( children: [
          SizedBox(height: 90,),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/png/notickets.png',
                // Replace with your image asset path
                width: 200,
                height: 300,
              ),
            ),
          ),
          Center( child: Text("Haven't Added Before?",style: TextStyle(fontSize: 23,fontFamily: "Lato",color: AppColors.black),)),
          SizedBox(height: 20,),
          Center( child: Text("Click “Add New Ticket” and provide us with the ",style: TextStyle(fontSize: 18,color: AppColors.black),)),
          Center( child: Text("details to add new ticket for you. ",style: TextStyle(fontSize: 18,color: AppColors.black),)),

          Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PrimaryButton(
                  text: 'Add New Ticket',
                  onPressed: () {



                  },
                )),
          ),

          ]

        ),
        )
    );
  }
}
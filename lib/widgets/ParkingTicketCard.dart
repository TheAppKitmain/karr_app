

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/Notes/ActivityDataClass/ActivityDataClass.dart';
import 'package:kaar/utils/Constants.dart';

import 'package:kaar/widgets/flutter_ticket_widget.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/material.dart';

class ParkingTicketCard extends StatelessWidget {
  final Tickets tickets;





  // final String pcnNumber;
  // final String status;
  // final String date;
  // final String price;

  const ParkingTicketCard({
    // required this.pcnNumber,
    // required this.status,
    // required this.date,
    // required this.price,
    required this.tickets,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double fontsize=width*0.03;
    return  FlutterTicketWidget(

      width: width*0.9,
      height: height*0.26,
      isCornerRounded: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                        children: [
                          Text(
                            'PCN Number',
                            style: TextStyle(fontSize: fontsize),

                          ),
                          SizedBox(height: 8),
                          Text(
                            tickets.pcn??"N/A",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold ),

                          ),
                        ]

                    ),

                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: tickets.status == 1 ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        tickets.status == 1 ?"Paid":"Unpaid",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 20),
                // Container(
                //   height: 1,
                //   color: Colors.grey,
                //   margin: EdgeInsets.symmetric(horizontal: 16),
                // ),
                DottedLine(
                  dashColor: Colors.black,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Text(
                       "Ticket Issuer:",
                        style: TextStyle(fontSize: fontsize),
                      ),


                      Text(
                          tickets.ticketIssuer??"" ,
                          style: TextStyle(fontSize: 18,color: AppColors.black,fontWeight: FontWeight.bold )
                      ),
                      // Add any other icons or buttons here
                    ],
                  ),
                ),

                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                        Text(
                          tickets.date??"N/A",
                          style: TextStyle(fontSize: fontsize),
                        ),


                    Text(
                     " Price: ${double.tryParse(tickets.price??"0")?.toStringAsFixed(2)}",
                      // " ${tickets.price}"??"N/A",
                      style: TextStyle(fontSize: fontsize, fontWeight: FontWeight.bold),
                    ),
                    // Add any other icons or buttons here
                  ],
                ),
              ],
            ),
          ),

          // Add more widgets or custom designs below the line
        ],
      ),
    );

  }
}

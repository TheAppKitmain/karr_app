

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/Notes/ActivityDataClass/ActivityDataClass.dart';

import 'package:kaar/widgets/flutter_ticket_widget.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/material.dart';

class AddParkingTicketCard extends StatelessWidget {
  final Tickets tickets;





  // final String pcnNumber;
  // final String status;
  // final String date;
  // final String price;

  const AddParkingTicketCard({
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
                            style: TextStyle(fontSize: 14),

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

                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        tickets.ticketIssuer??"N/A" ,
                        style: TextStyle(color: Colors.black),
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
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      tickets.date??"N/A",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "Price: £${tickets.price}"??"N/A",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
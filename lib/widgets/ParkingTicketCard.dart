

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/widgets/flutter_ticket_widget.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/material.dart';

class ParkingTicketCard extends StatelessWidget {
  final String pcnNumber;
  final String status;
  final String date;
  final String price;

  const ParkingTicketCard({
    required this.pcnNumber,
    required this.status,
    required this.date,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return  FlutterTicketWidget(
      width: 400.0,
      height: 200.0,
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
                            pcnNumber,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold ),

                          ),
                        ]

                    ),

                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: status == 'Paid' ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        status,
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
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      date,
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      'Price: $price',
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

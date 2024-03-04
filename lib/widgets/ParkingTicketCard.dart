

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/Notes/ActivityDataClass/ActivityDataClass.dart';
import 'package:kaar/utils/Constants.dart';

import 'package:kaar/widgets/flutter_ticket_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:intl/intl.dart';
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
      height: height*0.24,
      isCornerRounded: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                        children: [
                          Text(
                            'PCN Number',
                            style: TextStyle(fontSize: fontsize),

                          ),
                          const SizedBox(height: 8),
                          Text(
                          CapitalWOrd.capitalizeWithNumbers(tickets.pcn!)??"N/A",
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold ),

                          ),
                        ]

                    ),

                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: tickets.status == 1 ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        tickets.status == 1 ?"Paid":"Unpaid",
                        style:  TextStyle(color: Colors.white,fontSize: width*0.03),
                      ),
                    ),

                  ],
                ),

                const SizedBox(height: 20),
                // Container(
                //   height: 1,
                //   color: Colors.grey,
                //   margin: EdgeInsets.symmetric(horizontal: 16),
                // ),
                const DottedLine(
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
                          CapitalWOrd.capitalizeWords(tickets.ticketIssuer!)??"" ,
                          style:  TextStyle(fontSize: width*0.035,color: AppColors.black,fontWeight: FontWeight.bold )
                      ),
                      // Add any other icons or buttons here
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                        Text(
                          formatWithSuffix(tickets.date!)??"N/A",
                          // tickets.date??"",
                          style: TextStyle(fontSize: fontsize),
                        ),


                    Text(
                     " Price: £${double.tryParse(tickets.price??"0")?.toStringAsFixed(2)}",
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
  String formatWithSuffix(String date) {
    DateFormat format = DateFormat('dd-MM-yyyy');
    DateTime dateTime = format.parse(date);
    String suffix = 'th';
    int day = dateTime.day;
    if (day == 1 || day == 21 || day == 31) {
      suffix = 'st';
    } else if (day == 2 || day == 22) {
      suffix = 'nd';
    } else if (day == 3 || day == 23) {
      suffix = 'rd';
    }
    return
      // DateFormat('dd')  // Format day without suffix
      //   .format(dateTime)
      //   .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},') +
      '${dateTime.day}'+suffix + ' ' + DateFormat('MMMM yyyy').format(dateTime);
  }

}

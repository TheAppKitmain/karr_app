

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/Notes/ActivityDataClass/ActivityDataClass.dart';
import 'package:kaar/controller/parkingTickets/parkingTicketsOcrScreens/EditTicketDialog.dart';
import 'package:kaar/widgets/date_picker.dart';
import 'package:intl/intl.dart';

import 'package:kaar/widgets/flutter_ticket_widget.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/material.dart';

class AddParkingTicketCard extends StatefulWidget {
  final Tickets tickets;
  final bool isEdit;





  // final String pcnNumber;
  // final String status;
  // final String date;
  // final String price;

  const AddParkingTicketCard({
    // required this.pcnNumber,
    // required this.status,
    // required this.date,
    required this.isEdit,
    required this.tickets,
  });

  @override
  State<AddParkingTicketCard> createState() => _AddParkingTicketCardState();
}

class _AddParkingTicketCardState extends State<AddParkingTicketCard> {
  @override
  Widget build(BuildContext context) {
    DateTime? _date;
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
                          GestureDetector(
                            onTap: (){
                              EditTicketDialog.show(context, widget.tickets.pcn??"N/A","PCN Number", (p0) =>{
                                widget.tickets.pcn=p0,
                              setState(() {

                              })
                              } );
                            },
                            child: Text(
                              widget.tickets.pcn??"N/A",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold ),

                            ),
                          ),
                        ]

                    ),

                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: GestureDetector(
                        onTap: (){
                          EditTicketDialog.show(context, widget.tickets.ticketIssuer??"N/A","Ticket Issuer", (p0) =>{
                            widget.tickets.ticketIssuer=p0,
                            setState(() {

                            })
                          } );
                        },
                        child: Text(
                          widget.tickets.ticketIssuer??"N/A" ,
                          style: TextStyle(color: Colors.black),
                        ),
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
                    GestureDetector(
                      onTap:() async {
                        final DateTime? picked = await getDatePicker(context);
                        if (picked != null && picked != _date) {
                          setState(() {
                            _date = picked;
                            widget.tickets.date = DateFormat('yyyy-MM-dd')
                                .format(picked); // Format the date as needed
                          });
                        }
                      },
                      child: Text(
                        widget.tickets.date??"N/A",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        EditTicketDialog.show(context, widget.tickets.price??"N/A","Ticket Price", (p0) =>{
                          widget.tickets.price=p0,
                          setState(() {

                          })
                        } );
                      },
                      child: Text(
                        "Price: £${widget.tickets.price}"??"N/A",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
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

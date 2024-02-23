

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
                          Row(
                            children: [
                              Text(
                                'PCN Number',
                                style: TextStyle(fontSize: 14),
                                
                              ),
                              SizedBox(width: 8,),
                              GestureDetector(  onTap: (){
                                EditTicketDialog.show(context, widget.tickets.pcn??"","PCN Number", (p0) =>{
                                  widget.tickets.pcn=p0,
                                  setState(() {

                                  })
                                } );
                              },child: Icon(Icons.edit,size: 15,))
                            ],
                          ),
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: (){
                              EditTicketDialog.show(context, widget.tickets.pcn??"","PCN Number", (p0) =>{
                                widget.tickets.pcn=p0,
                              setState(() {

                              })
                              } );
                            },
                            child: Text(
                              widget.tickets.pcn??"",
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
                      child: Column(
                        children:[

                          Row(
                            children:[ GestureDetector(
                            onTap: (){
                              EditTicketDialog.show(context, widget.tickets.ticketIssuer??"","Ticket Issuer", (p0) =>{
                                widget.tickets.ticketIssuer=p0,
                                setState(() {

                                })
                              } );
                            },
                            child: Text(
                              widget.tickets.ticketIssuer??"" ,
                              style: TextStyle(color: Colors.black),
                            ),
                                                    ),
                              SizedBox(width: 8,),
                              GestureDetector(child: Icon(Icons.edit,size: 15,),onTap: (){
    EditTicketDialog.show(context, widget.tickets.ticketIssuer??"","Ticket Issuer", (p0) =>{
    widget.tickets.ticketIssuer=p0,
    setState(() {

    })
    } );
    },)
    ]
                          ),
      ]
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
                    Column(
                      children:[

                        Row(
                          children:[ GestureDetector(
                          onTap:() async {
                            final DateTime? picked = await getDatePicker(context);
                            if (picked != null && picked != _date) {
                              setState(() {
                                _date = picked;
                                widget.tickets.date = DateFormat('dd-MM-yyyy')
                                    .format(picked); // Format the date as needed
                              });
                            }
                          },
                          child: Text(

                            widget.tickets.date?.isNotEmpty ?? false ? formatWithSuffixString(widget.tickets.date!) : "Date",
                            style: TextStyle(fontSize: 14),
                          ),

                                                ),
                            SizedBox(width: 8,),
                            GestureDetector( onTap:() async {
                              final DateTime? picked = await getDatePicker(context);
                              if (picked != null && picked != _date) {
                                setState(() {
                                  _date = picked;
                                  widget.tickets.date = DateFormat('dd-MM-yyyy')
                                      .format(picked); // Format the date as needed
                                });
                              }
                            },child: Icon(Icons.edit,size: 15,))
    ]
                        ),
    ]
                    ),
                    Row(
                      children:[ GestureDetector(
                        onTap: (){
                          EditTicketDialog.show(context, widget.tickets.price??"","Ticket Price", (p0) =>{
                            widget.tickets.price=p0,
                            setState(() {

                            })
                          } );
                        },
                        child:Text(
                         'Price: £${widget.tickets.price}'??'' ,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),


                      ),
                        SizedBox(width: 8,),
                        GestureDetector( onTap: (){
                          EditTicketDialog.show(context, widget.tickets.price??"","Ticket Price", (p0) =>{
                            widget.tickets.price=p0,
                            setState(() {

                            })
                          } );
                        },child: Icon(Icons.edit,size: 15,))
    ]
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
  String formatWithSuffixString(String date) {
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
    return DateFormat('dd')  // Format day without suffix
        .format(dateTime)
        .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},') +
        suffix + ' ' + DateFormat('MMMM yyyy').format(dateTime);
  }
  String revertDateFormat(String formattedDate) {
    // Split the formatted date string by space to separate day, suffix, month, and year
    List<String> parts = formattedDate.split(' ');

    // Extract day and remove suffix
    String day = parts[0].replaceAll(RegExp(r'[^\d]'), '');

    // Extract month and year
    String monthYear = parts[1];
    String Year = parts[2];
    if (monthYear=='January')
      monthYear='01';
    else if(monthYear=='February')
      monthYear='02';
    else if(monthYear=='March')
      monthYear='03';
    else if(monthYear=='April')
      monthYear='04';
    else if(monthYear=='May')
      monthYear='05';
    else if(monthYear=='June')
      monthYear='06';
    else if(monthYear=='July')
      monthYear='07';
    else if(monthYear=='August')
      monthYear='08';
    else if(monthYear=='September')
      monthYear='09';
    else if(monthYear=='October')
      monthYear='10';
    else if(monthYear=='November')
      monthYear='11';
    else if(monthYear=='December')
      monthYear='12';

    // Return the reverted format
    return '$day-$monthYear-$Year';
  }
}

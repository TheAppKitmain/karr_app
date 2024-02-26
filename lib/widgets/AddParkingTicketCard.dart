

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

  const AddParkingTicketCard({
    required this.isEdit,
    required this.tickets,
  });

  @override
  State<AddParkingTicketCard> createState() => _AddParkingTicketCardState();
}

class _AddParkingTicketCardState extends State<AddParkingTicketCard> {
  List<String> _ticketsIssuerList = [
    "Select Issuer",
    "BARNET", "BEXLEY", "BROMLEY", "CAMDEN", "CITY OF LONDON", "CROYDON", "EALING", "ENFIELD", "GREENWICH", "HACKNEY COUNCIL",
    "HAVERING", "HILLINGDON", "HOUNSLOW", "ISLINGTON", "HAMMERRSMITH & FULHAM", "HARINGEY", "HARROWCOUNCIL", "KENSINGTON AND CHELSEA", "KINGSTON UPON THAMES", "LAMBETH",
    "LEWISHAM", "NEWHAM", "REDBRIDGE", "RICHMOND", "SUTTON", "TRANSPORT FOR LONDON", "TOWER HAMLETS", "WALTHAM FOROST", "WANDSWORTH", "WESTMINSTER"
  ];
  late String? selectedIssuer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if(widget.tickets.ticketIssuer=='Ticket Issuer')
    //   selectedIssuer='Select Issuer';
    // else
      selectedIssuer=widget.tickets.ticketIssuer;
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FlutterTicketWidget(
      width: width * 0.9,
      height: height * 0.26,
      isCornerRounded: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                            children: [
                               Text(
                                'PCN Number',
                                style:  TextStyle(fontSize: width*0.05, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 8,),
                              GestureDetector(
                                onTap: () {
                                  EditTicketDialog.show(context, widget.tickets.pcn ?? "", "PCN Number", (p0) {
                                    setState(() {
                                      widget.tickets.pcn = p0;
                                    });
                                  });
                                },
                                child: const Icon(Icons.edit, size: 15),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              EditTicketDialog.show(context, widget.tickets.pcn ?? "", "PCN Number", (p0) {
                                setState(() {
                                  widget.tickets.pcn = p0;
                                });
                              });
                            },
                            child: Text(
                              widget.tickets.pcn ?? "",
                              style:  TextStyle(fontSize: width*0.039),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 30),
                    Flexible(

                      child: Column(
                        children:[ DropdownButton<String>(
                          underline: Offstage(),
                          menuMaxHeight: height*0.5,

                          isExpanded: true,
                          value: selectedIssuer,
                          hint: const Text('Select Issuer'),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedIssuer = newValue;
                              widget.tickets.ticketIssuer = newValue;
                            });
                          },
                          items: _ticketsIssuerList.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,

                              child: Text(value, style: TextStyle(fontSize: width * 0.04)),
                            );
                          }).toList(),
                        ),

                          Text(
                            "",
                            style:  TextStyle(fontSize: width*0.04),
                          ),
      ]
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 20),
                const DottedLine(
                  dashColor: Colors.black,
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final DateTime? picked = await getDatePicker(context);
                                if (picked != null) {
                                  setState(() {
                                    widget.tickets.date = DateFormat('dd-MM-yyyy').format(picked);
                                  });
                                }
                              },
                              child: Text(
                                widget.tickets.date?.isNotEmpty ?? false ? formatWithSuffixString(widget.tickets.date!) : "Date",
                                  style:  TextStyle(fontSize: width*0.04, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 8,),
                            GestureDetector(
                              onTap: () async {
                                final DateTime? picked = await getDatePicker(context);
                                if (picked != null) {
                                  setState(() {
                                    widget.tickets.date = DateFormat('dd-MM-yyyy').format(picked);
                                  });
                                }
                              },
                              child: const Icon(Icons.edit, size: 15),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            EditTicketDialog.show(context, widget.tickets.price ?? "", "Ticket Price", (p0) {
                              setState(() {
                                widget.tickets.price = p0;
                              });
                            });
                          },
                          child: Text(
                            'Price: £${widget.tickets.price ?? ""}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 8,),
                        GestureDetector(
                          onTap: () {
                            EditTicketDialog.show(context, widget.tickets.price ?? "", "Ticket Price", (p0) {
                              setState(() {
                                widget.tickets.price = p0;
                              });
                            });
                          },
                          child: const Icon(Icons.edit, size: 15),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
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
    return DateFormat('dd')
        .format(dateTime)
        .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},') +
        suffix + ' ' + DateFormat('MMMM yyyy').format(dateTime);
  }
}


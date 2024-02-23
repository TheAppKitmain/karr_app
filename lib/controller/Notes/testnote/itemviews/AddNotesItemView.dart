import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/Notes/testnote/dataclass.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/UpdateNoteDialog.dart';
import 'package:intl/intl.dart';
class AddNotesItemView extends StatefulWidget {
  final List<Toll> allTolls;
  final List<Charge> cityCharges;
  final List<Ticket> allTickets;
  final String selectedCategory;

  AddNotesItemView({
    required this.allTolls,
    required this.cityCharges,
    required this.allTickets,
    required this.selectedCategory,
  });

  @override
  State<AddNotesItemView> createState() => _AddNotesItemViewState();
}

class _AddNotesItemViewState extends State<AddNotesItemView> {
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
    return DateFormat('dd')  // Format day without suffix
        .format(dateTime)
        .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},') +
        suffix + ' ' + DateFormat('MMMM yyyy').format(dateTime);
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> noteItems = [];

    if (widget.selectedCategory == "Tolls") {
      noteItems = widget.allTolls
          .map((toll) => buildNoteItem(
          id: toll.id.toString(),
          name: toll.name,
          date: toll.date,
          note: toll.note??"",
          updateNoteValue: (value) {
            toll.note=value;
            setState(() {

            });
          },
          type: "pd",

          context: context

      ))
          .toList();
    } else if (widget.selectedCategory == "City charges") {
      noteItems = widget.cityCharges
          .map((charge) => buildNoteItem(
          id: charge.id.toString(),
          name: charge.name,
          date: charge.date,
          note: charge.note??"",
          type: "cd",
          updateNoteValue: (value) {
            charge.note=value;
            setState(() {

            });
          },
          context: context
      ))
          .toList();
    } else if (widget.selectedCategory == "Tickets") {
      noteItems = widget.allTickets
          .map((ticket) => buildNoteItem(
          id: ticket.id.toString(),
          name: ticket.pcnNumber,
          date: ticket.date,
          note: ticket.note??"",
          type: "ticket_id",
          updateNoteValue: (value) {
            ticket.note=value;
            setState(() {

            });
          },
          context: context
      ))
          .toList();
    }else if (widget.selectedCategory == "All") {
      List<dynamic> allItems = [];
      allItems.addAll(widget.allTolls);
      allItems.addAll(widget.cityCharges);
      allItems.addAll(widget.allTickets);
      noteItems = allItems
          .map((item) => buildNoteItem(
        id: item.id.toString(),
        name: item is Toll ? item.name : (item is Charge ? item.name : item.pcnNumber),
        date: item.date,
        note: item.note ?? "",
        type: item is Toll
            ? "pd"
            : (item is Charge ? "cd" : "ticket_id"),
        context: context,
      ))
          .toList();
    }

    return Column(
      children: noteItems.isEmpty
          ? [Text("${widget.selectedCategory} list is empty")]
          : noteItems,
    );
  }

  Widget buildNoteItem({
    required String id,
    required String name,
    required String date,
    required String note,
    required String type,
    required BuildContext context,
    Function(String)? updateNoteValue,
  }) {
    return Card(
      elevation: 8, // Adjust the elevation value as needed
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
      ),
      child:  Padding(
        padding: EdgeInsets.all(15.0),
        child: SizedBox(
          // Set margin of 20 from right and left
          width: double.infinity,

          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Row(
                children: [
                  Text('${name}',style: TextStyle(color: AppColors.black,fontSize: 13,fontFamily: "Lato"),textAlign: TextAlign.left,),
                ],
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  Text(formatWithSuffix(date),style: TextStyle(color: AppColors.black,fontSize: 13,fontFamily: "Lato-Regular")),
                ],
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () {
                  UpdateNoteDialog.show(context, id,note.toString(),type, (v) {
                    note = v!;
                    if(updateNoteValue!=null) updateNoteValue(v);
                    setState(() {

                    });
                    //note added for this item
                  });
                },
                child: Row(
                  children: const [
                    Text(
                      'Add Note',
                      style: TextStyle(fontSize: 14, color: AppColors.primaryColor),
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
      ),
    );
  }
}

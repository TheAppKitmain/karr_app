import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/Notes/testnote/dataclass.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/UpdateNoteDialog.dart';

class AllNotesItemView extends StatefulWidget {
  final List<Toll> allTolls;
  final List<Charge> cityCharges;
  final List<Ticket> allTickets;
  final String selectedCategory;

  AllNotesItemView({
    required this.allTolls,
    required this.cityCharges,
    required this.allTickets,
    required this.selectedCategory,
  });

  @override
  State<AllNotesItemView> createState() => _AllNotesItemViewState();
}

class _AllNotesItemViewState extends State<AllNotesItemView> {
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
        context: context
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
  }) {
    return Card(
        elevation: 8, // Adjust the elevation value as needed
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
        ),
      child:  Padding(
    padding: EdgeInsets.all(20.0),
    child: SizedBox(
    // Set margin of 20 from right and left
    width: double.infinity,

    child:
        Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Row(
            children: [
              Text('${name}',style: TextStyle(color: AppColors.black,fontSize: 18,fontFamily: "Lato"),textAlign: TextAlign.left,),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Text('${date}',style: TextStyle(color: AppColors.black,fontSize: 16,fontFamily: "Lato-Regular")),
            ],
          ),
          SizedBox(height: 10,),
          GestureDetector(
            onTap: () {
              UpdateNoteDialog.show(context, id,note.toString(),type, (v) {
                note = v!;
                setState(() {

                });
                //note added for this item
              });
            },
            child: Row(
              children: const [
                Text(
                  'See Note',
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
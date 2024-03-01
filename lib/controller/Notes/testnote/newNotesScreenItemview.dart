

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kaar/controller/Notes/ActivityDataClass/ActivityDataClass.dart';
import 'package:kaar/controller/Notes/testnote/itemviews/newDataClass.dart';


import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/UpdateNoteDialog.dart';
import 'package:intl/intl.dart';

class NotesItemView extends StatelessWidget {
  final Note notes;


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

  const NotesItemView({super.key,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    String? type;
    String? id;
    if(notes.notes==null){
      notes.notes='';
    }

    if(notes.type=="toll"){

      type='pd';

    }else if(notes.type=='ticket'){
      type='ticket_id';

    }else{
      type='cd';

    }
    return
      Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset(
                    'assets/svg/vector.svg',
                    width: 32,
                    height: 32,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 18.0),
                  height: 60,
                  width: 1,
                  color: Colors.grey,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          formatWithSuffix((notes.date)),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: "Lato-Regular",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${notes.name}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: "Lato",
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    UpdateNoteDialog.show(context, notes.noteId.toString(),notes.notes.toString(),type!, (v) {
                      notes.notes = v; //note added for this item
                    });
                  },
                  child: SvgPicture.asset(
                    'assets/svg/edit_svg.svg',
                    width: 15,
                    height: 15,
                    color: AppColors.primaryColor, // Change the color as needed
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  }
  String UniversalformatDate(String dateString) {
    // List of possible date formats
    List<String> possibleFormats = [
      'dd/MM/yy', // 13/12/09
      'dd MMM yyyy', // 13 sep 2020
      'dd MMMM yyyy', // 13 september 2020
      'yyyy-dd-MM', //
      'dd-MM-yyyy', //
      'dd-MM-yy', //
      // Add more formats as needed
    ];

    // Iterate through possible formats and try parsing
    for (String format in possibleFormats) {
      try {
        DateTime date = DateFormat(format).parse(dateString);
        // Format the parsed date into "YYYY-MM-DD" format
        return DateFormat('dd-MM-yyyy').format(date);
      } catch (e) {
        // If parsing fails, continue to the next format
        continue;
      }
    }

    // If none of the formats match, return empty string or handle error as needed
    return '';
  }

}

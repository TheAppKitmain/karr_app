import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import 'package:kaar/controller/Notes/testnote/dataclass.dart';
import 'package:kaar/controller/Notes/testnote/itemviews/AddNotesItemView.dart';
import 'package:kaar/controller/Notes/testnote/itemviews/newDataClass.dart';
import 'package:kaar/controller/Notes/testnote/newNotesScreenItemview.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../tolls/AllTolls.dart';

class TestNoteScreen extends StatefulWidget {


  Function(int?) onNext;
  Function(int?) onPrevious;



  TestNoteScreen( {required this.onNext,required this.onPrevious});

  @override
  State<TestNoteScreen> createState() => _TestNoteScreenState();
}

class _TestNoteScreenState extends State<TestNoteScreen> {

  List<Note> notes = [];
  List<Note> cityCharges = [];
  List<Note> allTolls = [];
  List<Note> allTickets = [];

  bool isLoading = true;
  List<String> gameList = ["Tolls", "City charges", "Tickets"];
  var selectedValue;
  String? userid;
  String? totalNotesCount='0';

  @override
  void initState() {
    super.initState();
    loadUserDetails();
  }

  void loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString('userid');

      fetchallNotes();
    });
  }


  Future<void> fetchallNotes() async {
    final dio = Dio();

    try {
      final response = await dio.get(
        'https://dashboard.karrcompany.co.uk/api/driver/data',
        queryParameters: {
          "id": userid,
        },
      );

      final responseData = response.data as Map<String, dynamic>;
      print(responseData);

      if (response.statusCode == 200) {
        final status = responseData['status'] as bool;

        if (status) {
          final notesJson = responseData['notes'];
          if (notesJson != null) {
            notesJson.forEach((v) {
              if (Note.fromJson(v).notes==null){
                notes.add(Note.fromJson(v));
                if(Note.fromJson(v).type=='ticket'){
                  allTickets.add(Note.fromJson(v));
                }
                if(Note.fromJson(v).type=='toll'){
                  allTolls.add(Note.fromJson(v));
                }
                if(Note.fromJson(v).type=='city charges'){
                  cityCharges.add(Note.fromJson(v));
                }
              }

            });
          }

          totalNotesCount=(notes.length).toString();
          print('total notes count$totalNotesCount');
          isLoading = false;
          setState(() {});
        } else {
          isLoading = false;
          setState(() {});
        }
      } else {
        isLoading = false;
        setState(() {});
      }
    } catch (e) {
      isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    final fontSize = width * 0.04;
    return WillPopScope(
      onWillPop: () =>widget.onPrevious(0),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: CustomAppBar(fontSize: fontSize,onBackClick: () {
          widget.onPrevious(0);
        },title: 'Add Notes',),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text('$totalNotesCount Total Notes',style: TextStyle(fontFamily: 'Lato'),),
                  Spacer(),
                  Card(
                    elevation: 4,
                    color: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: DropdownButton<String>(
                        // decoration: InputDecoration(border: InputBorder.none),
                        borderRadius: BorderRadius.circular(20),

                        value: selectedValue,
                        underline: Offstage(),
                        hint: Text(
                          "Sort By",
                            style: TextStyle(color: AppColors.black,fontSize: fontSize,fontFamily: 'Lato-Regular',fontWeight: FontWeight.normal),
                        ),
                        items: gameList.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style: TextStyle(color: AppColors.black,fontSize: fontSize,fontFamily: 'Lato-Regular',fontWeight: FontWeight.normal),),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue;
                            if(selectedValue=='Tolls'){
                              notes=allTolls;
                            }else if(selectedValue=='City charges'){
                              notes=cityCharges;
                            }else if(selectedValue=='Tickets'){
                              notes=allTickets;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? CircularProgressIndicator()
            :notes.isNotEmpty?
            Expanded(
              flex: 1,
              child: GroupedListView(elements: notes, groupBy:  (element) => (element.date), groupComparator: (value1, value2) => value2.compareTo(value1),
                itemComparator: (item1, item2) =>
                    item1.noteId.toString().compareTo(item2.noteId.toString()),
                order: GroupedListOrder.DESC,

                groupSeparatorBuilder: (String value) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWithLines(text: formatDate(value)),
                  // Text(
                  //
                  //   textAlign: TextAlign.center,
                  //   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  // ),
                ),itemBuilder: (c, element) {
                  return NotesItemView(notes: element
                              );
                },),
            ):Text("no data found")

            // :Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child:   ListView.builder(
            //     itemCount: notes.length,
            //     scrollDirection: Axis.vertical,
            //     shrinkWrap: true,
            //     itemBuilder: (context, index) {
            //       return NotesItemView(notes: notes[index]
            //         );
            //     },) ,
            //
            // )
          ],
        ),
      ),
    );
  }
  String formatDate(String dateString) {
    // Parse the input date string
    DateTime date = DateFormat('dd-MM-yyyy').parse(dateString);

    // Get the current date
    DateTime now = DateTime.now();

    // Compare the input date with the current date
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today';
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day - 1) {
      return 'Yesterday';
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day + 1) {
      return 'Tomorrow';
    } else {
      // If the date is not today, yesterday, or tomorrow, format it using a date formatter
      return formatWithSuffix(dateString);
    }
  }
  String formatWithSuffix(String date) {
    DateFormat format = DateFormat('dd-MM-yyyy');
    DateTime dateTime = format.parse(date);
    String suffix = 'th';
    int day = dateTime.day;

    // Check if the day is between 11 and 19
    if (day % 100 >= 11 && day % 100 <= 13) {
      suffix = 'th';
    } else {
      switch (day % 10) {
        case 1:
          suffix = 'st';
          break;
        case 2:
          suffix = 'nd';
          break;
        case 3:
          suffix = 'rd';
          break;
        default:
          suffix = 'th';
      }
    }

    return '${dateTime.day}$suffix ${DateFormat('MMMM ').format(dateTime)}';
  }




}
class TextWithLines extends StatelessWidget {
  final String text;

  const TextWithLines({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            text,
            style: TextStyle(fontSize: width*0.03),
          ),
        ),

      ],
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:kaar/controller/Notes/ActivityDataClass/ActivityDataClass.dart';

import 'package:kaar/controller/parkingTickets/addParkingTicket/MyTicketScreen.dart';
import 'package:kaar/controller/parkingTickets/editTicket/EditTicketScreen.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/AppLoading.dart';
import 'package:kaar/widgets/DeleteDialog.dart';
import 'package:kaar/widgets/ParkingTicketCard.dart';
import 'package:kaar/widgets/PrimaryButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
class TicketsPaidDetails extends StatefulWidget {
  const TicketsPaidDetails({Key? key}) : super(key: key);

  @override
  State<TicketsPaidDetails> createState() => _TicketsPaidDetailsState();
}

class _TicketsPaidDetailsState extends State<TicketsPaidDetails> {
  List<Tickets> allTickets = [];
  String? userid;
  bool isLoading = true; // Add a loading state

  @override
  void initState() {
    super.initState();
    loadUserDetails();
  }

  void loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString('userid');
      fetchallTickets();
    });
  }

  Future<void> fetchallTickets() async {
    final dio = Dio();

    try {
      final response = await dio.post(
        'https://dashboard.karrcompany.co.uk/api/driver/ticket',
        queryParameters: {
          "driver_id": userid,
        },
      );

      final responseData = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final status = responseData['status'] as bool;

        if (status) {
          final chargeJson = responseData['tickets'];
          if (chargeJson != null) {
            allTickets.clear(); // Clear the existing list
            chargeJson.forEach((v) {
              if (Tickets.fromJson(v).status == 0) {
                allTickets.add(Tickets.fromJson(v));
              }
            });
          }

          isLoading = false; // Set loading to false after data is fetched
          setState(() {});
        } else {
          isLoading = false; // Set loading to false even on failure
          setState(() {});
        }
      } else {
        isLoading = false; // Set loading to false on API request failure
        setState(() {});
      }
    } catch (e) {
      isLoading = false; // Set loading to false on error
      setState(() {});
    }
  }
  Future<void> deleteTickets(int ticket_id) async {

    final dio = Dio();

    try {
      final response = await dio.delete(
        'https://dashboard.karrcompany.co.uk/api/deleteTicket',
        queryParameters: {
          "ticket_id": ticket_id,
        },
      );

      final responseData = response.data as Map<String, dynamic>;

      print(response);
      if (response.statusCode == 200) {
        final status = responseData['status'] as bool;
        final message = responseData['message'] as String;

        if (status) {
          allTickets.removeWhere((ticket) => ticket.id == ticket_id);
          isLoading = true;
          setState(() {
            fetchallTickets();
          });
          Navigator.pop(context);
          ToastUtils.showToast(context, message);

           // Set loading to true before fetching tickets

        } else {
          Navigator.pop(context); // Close the dialog
          ToastUtils.showToast(context, message);
        }
      } else {
        Navigator.pop(context); // Close the dialog
        ToastUtils.showToast(context, "else");
      }
    } catch (e) {
      Navigator.pop(context); // Close the dialog
      ToastUtils.showToast(context, "catch");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: isLoading // ßShow a circular progress indicator while loading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : allTickets.isNotEmpty
          ?
      GroupedListView(elements: allTickets, groupBy:  (element) => element.date!, groupComparator: (value1, value2) => value2.compareTo(value1),
        itemComparator: (item1, item2) =>
            item1.id.toString().compareTo(item2.id.toString()),
        order: GroupedListOrder.ASC,
        useStickyGroupSeparators: true,
        groupSeparatorBuilder: (String value) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextWithLines(text: formatDate(value)),
          // Text(
          //
          //   textAlign: TextAlign.center,
          //   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          // ),
        ),itemBuilder: (c, element) {
          return Slidable(
              key: ValueKey(0),
              // The end action pane is the one at the right or the bottom side.
              endActionPane:  ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    flex: 1,

                    onPressed:(context) {
                      DeleteDialog.show(context);
                      deleteTickets(element.id!);

                    },
                    backgroundColor: Colors.red,
                    borderRadius: BorderRadius.circular(5),

                    foregroundColor: AppColors.white,

                    icon: Icons.delete,
                    label: "delete",
                  ),
                  SlidableAction(
                    onPressed: (context){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditTicketScreen(ticket: element)),
                      );
                    },
                    borderRadius: BorderRadius.only(topRight: Radius.circular(25),bottomRight: Radius.circular(25)),
                    backgroundColor: Color(0xFF21B7CA),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'edit',
                  ),
                ],
              ),
              child:Center(child: ParkingTicketCard(tickets: element)));
        },)
      // Padding(
      //   padding: EdgeInsets.all(10.0),
      //   child: ListView.builder(
      //     itemCount: allTickets.length,
      //     scrollDirection: Axis.vertical,
      //     shrinkWrap: true,
      //     itemBuilder: (context, index) {
      //       return Slidable(
      //           key: ValueKey(0),
      //       // The end action pane is the one at the right or the bottom side.
      //       endActionPane:  ActionPane(
      //       motion: ScrollMotion(),
      //       children: [
      //       SlidableAction(
      //       flex: 1,
      //       padding: const EdgeInsets.all(10),
      //       onPressed:(context) {
      //        DeleteDialog.show(context);
      //         deleteTickets(allTickets[index].id!);
      //
      //       },
      //       backgroundColor: Colors.red,
      //       borderRadius: BorderRadius.circular(5),
      //
      //       foregroundColor: AppColors.white,
      //       spacing: 10,
      //       icon: Icons.delete,
      //       label: "delete",
      //       ),
      //         SlidableAction(
      //           onPressed: (context){
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                   builder: (context) => EditTicketScreen(ticket: allTickets[index])),
      //             );
      //           },
      //           borderRadius: BorderRadius.only(topRight: Radius.circular(25),bottomRight: Radius.circular(25)),
      //           backgroundColor: Color(0xFF21B7CA),
      //           foregroundColor: Colors.white,
      //           icon: Icons.edit,
      //           label: 'edit',
      //         ),
      //       ],
      //       ),
      //       child:ParkingTicketCard(tickets: allTickets[index]));
      //     },
      //   ),
      // )
          :   Column( children: [
        SizedBox(height: 90,),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              'assets/png/notickets.png',
              // Replace with your image asset path
              width: width*0.3,
              height: height*0.2,
            ),
          ),
        ),
        SizedBox(height: 20,),
        Center( child: Text("Haven't Added Before?",style: TextStyle(fontSize: width*0.07,fontFamily: "Lato",color: AppColors.black),)),
        SizedBox(height: 20,),
        Center( child: Text("Click “Add New Ticket” and provide us with the ",style: TextStyle(fontSize: width*0.04,color: AppColors.black),textAlign: TextAlign.center,)),
        Center( child: Text("details to add new ticket for you. ",style: TextStyle(fontSize: width*0.04,color: AppColors.black),textAlign: TextAlign.center)),

        Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PrimaryButton(
                text: 'Add New Ticket',

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyTicketScreen(),
                    ),
                  );


                },
              )),
        ),

      ]


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



}
class TextWithLines extends StatelessWidget {
  final String text;

  const TextWithLines({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: Colors.black38,
            height: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            text,
            style: TextStyle(fontSize: width*0.03),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.black38,
            height: 1,
          ),
        ),
      ],
    );
  }
}
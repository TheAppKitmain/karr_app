import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kaar/controller/Notes/ActivityDataClass/ActivityDataClass.dart';

import 'package:kaar/controller/parkingTickets/addParkingTicket/MyTicketScreen.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/PrimaryButton.dart';
import 'package:kaar/widgets/ParkingTicketCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketHistory extends StatefulWidget {
  @override
  _TicketHistoryState createState() => _TicketHistoryState();
}

class _TicketHistoryState extends State<TicketHistory> {
  List<Tickets> allTickets = [];
  String? userid;
  bool isLoading = true;

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
            allTickets.clear();
            chargeJson.forEach((v) {
              if (Tickets.fromJson(v).status == 1) {
                allTickets.add(Tickets.fromJson(v));
              }
            });
          }

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: isLoading
          ? Center(
        child:
        CircularProgressIndicator(),

      )
          : allTickets.isNotEmpty
          ? Padding(
        padding: EdgeInsets.all(10.0),
        child: Expanded(
          child: ListView.builder(
            itemCount: allTickets.length,

            itemBuilder: (BuildContext context, int index) {
              return  ParkingTicketCard(tickets: allTickets[index]);
            },
          ),
        ),
      ) : Column(
        children: [
          SizedBox(height: 90),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/png/notickets.png',
                width: width * 0.3,
                height: height * 0.2,
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              "Haven't Added Before?",
              style: TextStyle(
                fontSize: width * 0.07,
                fontFamily: "Lato",
                color: AppColors.black,
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              "Click “Add New Ticket” and provide us with the ",
              style: TextStyle(
                fontSize: width * 0.04,
                color: AppColors.black,
              ),
                textAlign: TextAlign.center
            ),
          ),
          Center(
            child: Text(
              "details to add a new ticket for you. ",
              style: TextStyle(
                fontSize: width * 0.04,
                color: AppColors.black,
              ),
                textAlign: TextAlign.center
            ),
          ),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

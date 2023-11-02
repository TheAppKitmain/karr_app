import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/parkingTickets/TicketsPaidDetails.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/controller/parkingTickets/TicketsHistory.dart';

class ParkingTickets extends StatelessWidget {

  Function(int?) onNext;
  Function(int?) onPrevious;



  ParkingTickets( {required this.onNext,required this.onPrevious});


  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: WillPopScope(

        onWillPop: () =>onPrevious(0),
        child: Scaffold(
          backgroundColor: AppColors.white,

          appBar: AppBar(
            toolbarHeight: height*0.09,

            title: const Text(
              "All Tickets",
              style: TextStyle(
                  fontSize: 18,
                  color: AppColors.black// Adjust the title text size as needed
              ),

            ),
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: true, // Center the title horizontally,
            backgroundColor: AppColors.white,
            bottom: TabBar(
              tabs: [
                Tab(
                  text: ("Tickets History"),height: height*0.05,
                ),
                const Tab(
                  text: ("Tickets"),
                ),

              ],
              labelColor: AppColors.primaryColor,         // Color of the selected tab's text
              unselectedLabelColor: Colors.black,

              labelStyle: TextStyle(
                fontSize: width*0.04, // Increase the font size for the selected tab's label
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: width*0.03, // Increase the font size for unselected tabs' labels
              ),
            ),
          ),
          body: TabBarView(children: [
            TicketHistory(),
            TicketsPaidDetails(),

          ]),
        ),
      ),
    );
  }
}



class TabBardemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
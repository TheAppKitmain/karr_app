import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/controller/parkingTickets/TicketsHistory.dart';

class ParkingTickets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(

        length: 2,

        child: Scaffold(
          backgroundColor: AppColors.white,

          appBar: AppBar(
            automaticallyImplyLeading: true, // Set to true if you want the default back arrow
            toolbarHeight: 80,
            title: Text(
              "All Tickets",
              style: TextStyle(
                fontSize: 18,
                color: AppColors.black// Adjust the title text size as needed
              ),

            ),
            centerTitle: true, // Center the title horizontally,
            backgroundColor: AppColors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: AppColors.black,// Use your custom icon here
              onPressed: () {
                // Add your navigation logic here
              },
            ),

            bottom: TabBar(
              tabs: [
                Tab(
                  text: ("Tickets History"),



                ),
                Tab(
                  text: ("Tickets"),
                ),

              ],
              labelColor: AppColors.primaryColor,         // Color of the selected tab's text
              unselectedLabelColor: Colors.black,

              labelStyle: TextStyle(
                fontSize: 18, // Increase the font size for the selected tab's label
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 16, // Increase the font size for unselected tabs' labels
              ),
            ),
          ),
          body: TabBarView(children: [
            TicketHistory(),
            Center( child: Text("Two",style: TextStyle(fontSize: 50),)),

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
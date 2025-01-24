import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/parkingTickets/TicketsPaidDetails.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/controller/parkingTickets/TicketsHistory.dart';

import '../tolls/AllTolls.dart';

class ParkingTickets extends StatelessWidget {

  Function(int?) onNext;
  Function(int?) onPrevious;



  ParkingTickets( {required this.onNext,required this.onPrevious});


  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    final fontSize = width * 0.04;
    return DefaultTabController(
      length: 2,
      child: Builder(builder: (context) {

        return WillPopScope(
          onWillPop: () =>onPrevious(0),
          child: Scaffold(

            appBar: CustomAppBar(fontSize: fontSize,onBackClick: () {
              onPrevious(0);
            },title: 'Parking Fines',

              tabBar: TabBar(
              indicatorColor: AppColors.primaryColor,
              tabs: [
                Tab(
                  child: Text('Pending Tickets',style: TextStyle(color: Colors.black),),

                ),
                Tab(
                  child: Text('Paid Tickets',style: TextStyle(color: Colors.black),),

                ),


              ],
            ),),
            body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
              TicketsPaidDetails(),
              TicketHistory(),


            ]),
          ),
        );
      },),
    );
  }
}



class TabBardemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
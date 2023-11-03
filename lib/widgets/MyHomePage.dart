import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/Notes/testnote/TestNoteScreen.dart';
import 'package:kaar/controller/cityCharges/AddCityCharges.dart';
import 'package:kaar/controller/cityCharges/AllCityCharges.dart';
import 'package:kaar/controller/home/HomeScreen.dart';
import 'package:kaar/controller/parkingTickets/ParkingTickets.dart';
import 'package:kaar/controller/parkingTickets/addParkingTicket/MyTicketScreen.dart';
import 'package:kaar/controller/profile/ProfileScreen.dart';
import 'package:kaar/controller/tolls/AddTolls.dart';
import 'package:kaar/controller/tolls/AllTolls.dart';
import 'package:kaar/utils/Constants.dart';

class MyHomePage extends StatefulWidget {


  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',


    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',

    ),
  ];
  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {

    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics:  NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          HomeScreen(onNext: (v) {
            setState(() {

              // _currentIndex=v??0;
              _pageController.animateToPage(v??0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          },),
          Step1Screen(onNext: (v) {
            setState(() {

              // _currentIndex=v??0;
              _pageController.animateToPage(v??0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          },onPrevious: (v) {
            setState(() {

              // _currentIndex=v??0;
              _pageController.animateToPage(v??0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          }),
          ProfileScreen(),
          ParkingTickets(onNext: (v) {
            setState(() {

              // _currentIndex=v??0;
              _pageController.animateToPage(v??0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          },onPrevious: (v) {
            setState(() {

              // _currentIndex=v??0;
              _pageController.animateToPage(v??0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          }),//3
          AddTolls(onNext: (v) {
            setState(() {

              // _currentIndex=v??0;
              _pageController.animateToPage(v??0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          },onPrevious: (v) {
            setState(() {

              // _currentIndex=v??0;
              _pageController.animateToPage(v??0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          }),//4
          AllTolls(onNext: (v) {
            setState(() {

              // _currentIndex=v??0;
              _pageController.animateToPage(v??0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          },onPrevious: (v) {
            setState(() {

              // _currentIndex=v??0;
              _pageController.animateToPage(v??0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          }),//5
          CityCharges(onNext: (v) {
            setState(() {

              // _currentIndex=v??0;
              _pageController.animateToPage(v??0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          },onPrevious: (v) {
            setState(() {

              // _currentIndex=v??0;
              _pageController.animateToPage(v??0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          }),//6
    AddCityCharges(onNext: (v) {
            setState(() {

              // _currentIndex=v??0;
              _pageController.animateToPage(v??0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          },onPrevious: (v) {
            setState(() {

              // _currentIndex=v??0;
              _pageController.animateToPage(v??0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          }),//7
    TestNoteScreen(onNext: (v) {
            setState(() {

              // _currentIndex=v??0;
              _pageController.animateToPage(v??0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          },onPrevious: (v) {
            setState(() {

              // _currentIndex=v??0;
              _pageController.animateToPage(v??0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          }),//8

        ],
        // onPageChanged: (index) {
        //   setState(() {
        //     _currentIndex = index;
        //   });
        // },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primaryColor,
        items: bottomNavigationBarItems,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:  Padding(
        padding: const EdgeInsets.only(top: 50),
        child: FloatingActionButton(
            onPressed: () {
              setState(() {
                _currentIndex = 1;
                _pageController.animateToPage(1,
                    duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
              });
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Step1Screen()),
              // );
            },
            backgroundColor:
            AppColors.primaryColor,

            child: Icon(Icons.add) // Set FAB background color
          // Set a different color when not selected
        ),
      ),
    );
  }
}

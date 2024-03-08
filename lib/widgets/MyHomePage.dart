import 'package:flutter/material.dart';
import 'package:kaar/controller/Notes/testnote/AddNoteScreen.dart';
import 'package:kaar/controller/Notes/testnote/ViewAllNotesScreen.dart';
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
  int _currentbottomIndex = 0;
  PageController _pageController = PageController();
  //
  // @override
  // void dispose() {
  //   _pageController.dispose();
  //   super.dispose();
  // }

  Future<void> _onItemTapped(int index) async {
    if(_currentIndex==index){

    }else{
    if (mounted)setState(() {
        _currentIndex = index;
        _currentbottomIndex=index;
      });
      _pageController.jumpToPage((index ?? 0)-1);
      await  _pageController.animateToPage(index??0,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(

        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          HomeScreen(
            onNext: (v) async {

              print('next from home $v');
                _currentIndex=v??0;

                // _pageController.jumpToPage(v ?? 0,
                // );

                _pageController.jumpToPage((v ?? 0)-1);
              await  _pageController.animateToPage(v??0,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut);
                if (mounted) setState(()  {

              });
            },
          ),
          Step1Screen(onNext: (v) async {

              // _currentIndex=v??0;
              _pageController.jumpToPage((v ?? 0)-1);
              await  _pageController.animateToPage(v??0,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
              if (mounted)setState(()  { });
          }, onPrevious: (v) {
            if (mounted)setState(() {
              print('page index $v');
              _currentIndex=v??0;
              _pageController.animateToPage(v ?? 0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          }),
          ProfileScreen(),
          ParkingTickets(onNext: (v) {
            if (mounted) setState(() {
              // _currentIndex=v??0;
              _pageController.animateToPage(v ?? 0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          }, onPrevious: (v) {
            if (mounted) setState(() {
              // _currentIndex=v??0;
              _pageController.animateToPage(v ?? 0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          }), //3
          Container(
            child: AddTolls(onNext: (v) {
              if (mounted)setState(() {
                // _currentIndex=v??0;
                _pageController.animateToPage(v ?? 0,
                    duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
              });
            }, onPrevious: (v) {
              if (mounted) setState(() {
                print('back from add tolls $v');
                _currentIndex=v??0;
                _pageController.animateToPage(v ?? 0,
                    duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
              });
            }),
          ), //4
          Container(
            child: AllTolls(onNext: (v) {
              if (mounted) setState(() {
                // _currentIndex=v??0;
                _pageController.animateToPage(v ?? 0,
                    duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
              });
            }, onPrevious: (v) {
              if (mounted)setState(() {
                print('back from all tolls $v');
                _currentIndex=v??0;
                _pageController.animateToPage(v ?? 0,
                    duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
              });
            }),
          ), //5
          CityCharges(onNext: (v) {
            if (mounted) setState(() {
              // _currentIndex=v??0;
              _pageController.animateToPage(v ?? 0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          }, onPrevious: (v) {
            if (mounted)setState(() {
              // _currentIndex=v??0;
              _pageController.animateToPage(v ?? 0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          }), //6
          AddCityCharges(onNext: (v) {
            if (mounted) setState(() {
              // _currentIndex=v??0;
              _pageController.animateToPage(v ?? 0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          }, onPrevious: (v) {
            if (mounted)setState(() {
              // _currentIndex=v??0;
              _pageController.animateToPage(v ?? 0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          }), //7
          ViewAllNotesScreen(onNext: (v) {
            if (mounted)setState(() {
              // _currentIndex=v??0;
              _pageController.animateToPage(v ?? 0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          }, onPrevious: (v) {
            if (mounted)setState(() {
              // _currentIndex=v??0;
              _pageController.animateToPage(v ?? 0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          }), //8
          TestNoteScreen(onNext: (v) {
            if (mounted) setState(() {
              // _currentIndex=v??0;
              _pageController.animateToPage(v ?? 0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          }, onPrevious: (v) {
            if (mounted)setState(() {
              // _currentIndex=v??0;
              _pageController.animateToPage(v ?? 0,
                  duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
            });
          }), //8
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primaryColor,
        items: bottomNavigationBarItems,
        currentIndex: _currentbottomIndex ,
        onTap: _onItemTapped,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: FloatingActionButton(
            onPressed: () {
              if (mounted) setState(() {
                _currentIndex = 1;
                _pageController.animateToPage(1,
                    duration: Duration(milliseconds: 1),
                    curve: Curves.bounceIn);
              });
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Step1Screen()),
              // );
            },
            backgroundColor: AppColors.primaryColor,
            child: Icon(Icons.add) // Set FAB background color
            // Set a different color when not selected
            ),
      ),
    );
  }


}

import 'package:flutter/material.dart';
import 'package:kaar/controller/carDetails/CarDetails.dart';
import 'package:kaar/controller/cityCharges/AddCityCharges.dart';
import 'package:kaar/controller/parkingTickets/addParkingTicket/MyTicketScreen.dart';
import 'package:kaar/controller/parkingTickets/ParkingTickets.dart';
import 'package:kaar/controller/profile/ProfileScreen.dart';
import 'package:kaar/controller/tolls/AddTolls.dart';
import 'package:kaar/controller/tolls/AllTolls.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/CustomBottomNavigation.dart';
import 'package:kaar/widgets/TextView.dart';

import '../cityCharges/AllCityCharges.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  final String car_number;

  HomeScreen(this.username, this.car_number, {super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState(username, car_number);
}

class _HomeScreenState extends State<HomeScreen> {
  final String _username;

  final String _car_number;

  _HomeScreenState(this._username, this._car_number);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(height: height * 0.04),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextView(
                text: "Welcome, $_username!",
                onPressed: () {},
              ),
            ),
          ),
          SizedBox(height: height * 0.01),
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CarDetails()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: 170,
                  height: height * 0.060,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _car_number,
                        style: TextStyle(
                            fontSize: width * 0.04,
                            color: AppColors.primaryColor),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.020),
          Wrap(
            runSpacing: height * .010,
            spacing: 10,
            children: [
              HomeScreenCard(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ParkingTickets(),
                  ),
                ),
                addNew: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Step1Screen(),
                  ),
                ),
              ),
              HomeScreenCard(
                  image: 'assets/png/tolls.png',
                  title: 'Toll',
                  des: 'Create new tolls and check all tolls.',
                  cardColor: AppColors.blue,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllTolls(),
                  ),
                ),
                addNew: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTolls(),
                  ),
                ),
              ),
              HomeScreenCard(
                  image: 'assets/png/city_charges.png',
                  title: 'City Charges',
                  des: 'Create new Charges and check status of all chargess',
                  cardColor: AppColors.yellow,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CityCharges(),
                  ),
                ),
                addNew: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCityCharges(),
                  ),
                ),
              ),
              HomeScreenCard(
                  image: 'assets/png/notes.png',
                  title: 'Notes',
                  des: 'Create new notes and check all notes your created.',
                  cardColor: AppColors.pink,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ParkingTickets(),
                  ),
                ),
                addNew: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyTicketScreen(),
                  ),
                ),)
            ],
          ),
          /*Row(
            children: [
              // Card 1
              Expanded(
                flex: 1,
                child: HomeScreenCard(),
              ),
              SizedBox(width: 8),
              // Card 2
              Expanded(
                flex: 1,
                child: HomeScreenCard(
                    image: 'assets/png/tolls.png',
                    title: 'Toll',
                    des: 'Create new tolls and check all tolls.',
                    cardColor: AppColors.blue),
              ),
            ],
          ),
          Row(
            children: [
              // Card 3
              Expanded(
                flex: 1,
                child: HomeScreenCard(
                    image: 'assets/png/city_charges.png',
                    title: 'City Charges',
                    des: 'Create new Charges and check status of all chargess',
                    cardColor: AppColors.yellow),
              ),
              SizedBox(width: 8),
              // Card 4
              Expanded(
                flex: 1,
                child: HomeScreenCard(
                    image: 'assets/png/notes.png',
                    title: 'Notes',
                    des: 'Create new notes and check all notes your created.',
                    cardColor: AppColors.pink),
              ),
            ],
          ),*/
        ]),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        onHomeTap: () {
          // Handle Home tap
          print('Home tapped and');
        },
        onFabTap: () {
          // Handle FAB tap
          print('FAB tapped');
        },
        onProfileTap: () {
          // Handle Profile tap

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
          print('Profile tappeda');
        },
      ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    floatingActionButton:  Padding(
      padding: const EdgeInsets.only(top: 50),
      child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyTicketScreen()),
            );
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

class HomeScreenCard extends StatelessWidget {
  const HomeScreenCard({
    super.key,
    this.image,
    this.title,
    this.des,
    this.cardColor,
    this.onTap,
    this.addNew,
  });

  final String? image, title, des;
  final Color? cardColor;
  final VoidCallback? onTap, addNew;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width / 2.1,
      child: Card(
        margin: EdgeInsets.only(top: height * 0.01),
        color: cardColor ?? AppColors.primaryColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Image.asset(
                  image ?? 'assets/png/parking_tickets.png',
                  // Replace with your image asset path
                  width: 40,
                  height: 40,
                  color: cardColor ?? AppColors.primaryColor,
                ),
              ),
              SizedBox(height: height * 0.020),
              Text(
                title ?? 'Parking Ticket',
                style: TextStyle(
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: height * 0.020),
              Text(
                des ?? 'Create new tickets and check status of all tickets',
                style: TextStyle(
                  fontSize: width * 0.03,
                  color: Colors.white,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: height * 0.020),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: addNew,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      child: Text(
                        'Add New',
                        style: TextStyle(
                          fontSize: width * 0.025,
                          color: cardColor ??
                              AppColors.primaryColor, // Button text color
                          // Add this line
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: onTap,
                      child: Text(
                        'View All', // Adjust text as needed
                        style: TextStyle(
                          fontSize: width * 0.035,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

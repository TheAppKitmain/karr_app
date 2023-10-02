import 'package:flutter/material.dart';
import 'package:kaar/controller/carDetails/CarDetails.dart';
import 'package:kaar/controller/cityCharges/AddCityCharges.dart';
import 'package:kaar/controller/home/MyTicketScreen.dart';
import 'package:kaar/controller/cityCharges/AllCityCharges.dart';
import 'package:kaar/controller/parkingTickets/addParkingTicket/AddParkingTickets.dart';
import 'package:kaar/controller/tolls/AllTolls.dart';
import 'package:kaar/controller/tolls/AddTolls.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/CustomBottomNavigation.dart';
import 'package:kaar/widgets/TextView.dart';
import 'package:kaar/controller/parkingTickets/ParkingTickets.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  final String car_number;
  HomeScreen(this.username,this.car_number, {super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState(username,car_number);
}

class _HomeScreenState extends State<HomeScreen> {

  final String _username;

  final String _car_number;

  _HomeScreenState( this._username,  this._car_number);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextView(
                  text: "Welcome, $_username!",
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CarDetails()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: 170,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Text(
                          _car_number,
                          style: TextStyle(
                              fontSize: 16, color: AppColors.primaryColor),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(

                  children: [
                    // Card 1
                    Expanded(
                      flex: 1,
                      child: Card(
                        color: AppColors.primaryColor,
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
                                  'assets/png/parking_tickets.png',
                                  // Replace with your image asset path
                                  width: 40,
                                  height: 40,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              const SizedBox(height: 40),
                              const Text(
                                'Parking Ticket',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Create new tickets and check status of all tickets',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MyTicketScreen(),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                      ),
                                      child: Text(
                                        'Add New',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.primaryColor, // Button text color
                                           // Add this line
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ParkingTickets(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'View All',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          decoration: TextDecoration.underline,
                                          overflow: TextOverflow.ellipsis, // Add this line
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
                    ),
                    const SizedBox(width: 8),
                    // Card 2
                    Expanded(
                      flex: 1,
                      child: Card(
                        color: AppColors.blue,
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
                                  'assets/png/tolls.png',
                                  // Replace with your image asset path
                                  width: 40,
                                  height: 40,
                                  color: AppColors.blue,
                                ),
                              ),
                              const SizedBox(height: 40),
                              const Text(
                                'Toll',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 30),
                              const Text(
                                'Create new tolls and check all tolls.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Handle button tap
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddTolls()),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary:
                                        Colors.white, // Button background color
                                      ),
                                      child: const Text(
                                        'Add New',
                                        style: TextStyle(

                                          color: AppColors
                                              .blue, // Button text color
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AllTolls()),
                                        );
                                        // Add your onPressed logic here
                                        // This function will be executed when the text is tapped.
                                      },
                                      child: const Text(
                                        'View All', // Adjust text as needed
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(

                  children: [
                    // Card 3
                    Expanded(
                      flex: 1,
                      child: Card(
                        color: AppColors.yellow,
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
                                  'assets/png/city_charges.png',
                                  // Replace with your image asset path
                                  width: 40,
                                  height: 40,
                                  color: AppColors.yellow,
                                ),
                              ),
                              const SizedBox(height: 40),
                              const Text(
                                'City Charges',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Create new Charges and check status of all chargess',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Handle button tap

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddCityCharges()),
                                        );

                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary:
                                        Colors.white, // Button background color
                                      ),
                                      child: const Text(
                                        'Add New',
                                        style: TextStyle(

                                          color: AppColors
                                              .yellow, // Button text color
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CityCharges()),
                                        );
                                        // Add your onPressed logic here
                                        // This function will be executed when the text is tapped.
                                      },
                                      child: const Text(
                                        'View All', // Adjust text as needed
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Card 4
                    Expanded(
                      flex: 1,
                      child: Card(
                        color: AppColors.pink,
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
                                  'assets/png/notes.png',
                                  // Replace with your image asset path
                                  width: 40,
                                  height: 40,
                                  color: AppColors.pink,
                                ),
                              ),
                              const SizedBox(height: 40),
                              const Text(
                                'Notes',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Create new notes and check all notes your created.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Handle button tap
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary:
                                        Colors.white, // Button background color
                                      ),
                                      child: const Text(
                                        'Add New',
                                        style: TextStyle(

                                          color: AppColors
                                              .pink, // Button text color
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        // Add your onPressed logic here
                                        // This function will be executed when the text is tapped.
                                      },
                                      child: const Text(
                                        'View All', // Adjust text as needed
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]
            )
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
          print('Profile tapped');
        },
      ),
    );
  }
}

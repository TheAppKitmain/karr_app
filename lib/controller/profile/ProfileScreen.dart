import 'package:flutter/material.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userName;
  String? userEmail;
  String? phoneNumber;
  String? licensePlate;

  @override
  void initState() {
    super.initState();
    // Load user details from shared preferences when the screen is initialized
    loadUserDetails();
  }

  // Function to load user details from shared preferences
  void loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name');
      userEmail = prefs.getString('email');
      phoneNumber = prefs.getString('usernumber');
      licensePlate = prefs.getString('license_number');
    });
  }

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // Set to true if you want the default back arrow
        toolbarHeight: height*0.09,
        title: Text(
          "Profile",
          style: TextStyle(
              fontSize: 18,
              color: AppColors.black// Adjust the title text size as needed
          ),

        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true, // Center the title horizontally,
        backgroundColor: AppColors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Text(
                'User Profile Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildProfileDetail('User Name', userName),
                ],
              ),
              buildProfileDetail('Email', userEmail),
              buildProfileDetail('Phone Number', phoneNumber),
              buildProfileDetail('License Plate', licensePlate),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileDetail(String label, String? value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value ?? 'N/A', // Display 'N/A' if the value is not available
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

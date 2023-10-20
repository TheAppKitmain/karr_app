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
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),

                  child: Image.asset(
                    'assets/png/kaar_logo.png',
                    // Replace with your image asset path
                    width: 200,
                    height: 80,
                  ),
                ),
              ),
              SizedBox(height: 40),

              buildProfileDetail('User Name', userName),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: double.infinity, // Make the container full width
          padding: EdgeInsets.all(12.0), // Add 12 units of padding inside the card
          child: Card(
            elevation: 4, // Adjust the elevation value as needed
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                value ?? 'N/A', // Display 'N/A' if the value is not available
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),

        SizedBox(height: 20),
      ],
    );
  }
}

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final fontSize = width * 0.03;
    return Scaffold(
      backgroundColor: Colors.grey.shade100 ,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // Set to true if you want the default back arrow
        toolbarHeight: height * 0.09,
        title: Text(
          "Profile",
          style: TextStyle(
              fontSize: fontSize * 1.5,
              color: AppColors.black // Adjust the title text size as needed
              ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        // Center the title horizontally,
        backgroundColor: AppColors.white,
      ),
      body: Center(
        child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Center(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/png/profile_test.png',
                          // Replace with your image asset path
                          width: 200,
                          height: 80,
                        ),
                        SizedBox(height: 15),
                        Text(
                          userName ?? "Ajony Houst",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade500, // Border color
                              // Border width
                            ),
                            borderRadius: BorderRadius.circular(
                                25), // Adjust the radius as needed
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child:
                            Row(
                              children: [
                                const Icon(
                                  Icons.edit,
                                  color: AppColors.black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                      fontSize: width * 0.04,
                                      color: AppColors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Container(
                color: AppColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(

                    children: [
                      const Icon(
                        Icons.email,
                        color: AppColors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        userEmail??"test@gmail.com",
                        style: TextStyle(
                            fontSize: fontSize*1.4,
                            color: AppColors.black),
                      ),



                    ],
                  ),
                ),
              ),
              Container(
                color: AppColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(

                    children: [
                      const Icon(
                        Icons.phone,
                        color: AppColors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        phoneNumber??"+91 3047907372",
                        style: TextStyle(
                            fontSize: fontSize*1.4,
                            color: AppColors.black),
                      ),



                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                color: AppColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(

                    children: [
                      const Icon(
                        Icons.lock,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                            fontSize: fontSize*1.4,
                            color: AppColors.black),
                      ),

                      Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.black,
                        size: 17,
                      ),


                    ],
                  ),
                ),
              ),
              Container(
                color: AppColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(

                    children: [
                    Image.asset(
                    'assets/png/license_plate.png',
                    ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "License Plate",
                        style: TextStyle(
                            fontSize: fontSize*1.4,
                            color: AppColors.black),
                      ),

                      Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.black,
                        size: 17,
                      ),


                    ],
                  ),
                ),
              ),
              Container(
                color: AppColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(

                    children: [
                      const Icon(
                        Icons.support_agent,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Customer support",
                        style: TextStyle(
                            fontSize: fontSize*1.4,
                            color: AppColors.black),
                      ),

                      Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.black,
                        size: 17,
                      ),


                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),

                child: Container(

                  height: 1, // Adjust the width of the line as needed
                  color: Colors.black, // Adjust the color of the line as needed
                ),
              ),
              Container(
                color: AppColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(

                    children: [
                      const Icon(
                        Icons.logout,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: fontSize*1.4,
                            color: AppColors.black),
                      ),

                      Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.black,
                        size: 17,
                      ),


                    ],
                  ),
                ),
              ),
            ],
          ),

      ),
    );
  }


}

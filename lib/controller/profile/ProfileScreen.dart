import 'package:flutter/material.dart';
import 'package:kaar/controller/UpdatePassword/UpdatePassword.dart';
import 'package:kaar/controller/carDetails/CarDetails.dart';
import 'package:kaar/controller/login/Login.dart';
import 'package:kaar/controller/profile/EditProfile.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userName;
  String? logo;
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
      logo = prefs.getString('logo');
    });
  }
  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login(),), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final fontSize = width * 0.03;
    return Scaffold(
      backgroundColor: AppColors.white,

      body: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: height*0.15,),

            Center(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage:
                        NetworkImage("${logo}"),
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        userName ?? "Ajony Houst",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 25),
                      // Container(
                      //   width: 150,
                      //   decoration: BoxDecoration(
                      //     border: Border.all(
                      //       color: Colors.grey.shade500, // Border color
                      //       // Border width
                      //     ),
                      //     borderRadius: BorderRadius.circular(
                      //         25), // Adjust the radius as needed
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(12),
                      //     child:
                      //     Row(
                      //       children: [
                      //         const Icon(
                      //           Icons.edit,
                      //           color: AppColors.black,
                      //         ),
                      //         SizedBox(
                      //           width: 10,
                      //         ),
                      //         Text(
                      //           "Edit Profile",
                      //           style: TextStyle(
                      //               fontSize: width * 0.04,
                      //               color: AppColors.black),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
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
                    const SizedBox(
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
                    const SizedBox(
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
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CarDetails()),
                );
              },
              child: Container(
                color: AppColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(

                    children: [
                      Image.asset(
                        'assets/png/license_plate.png',
                        color: AppColors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        licensePlate??"License plate",
                        style: TextStyle(
                            fontSize: fontSize*1.4,
                            color: AppColors.black),
                      ),

                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.black,
                        size: 17,
                      ),

                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfile()),
                  // MaterialPageRoute(builder: (context) => UpdatePassword()),
                );
              },
              child: Container(

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
            ),


            const Divider(color: Colors.grey,height: 1,),
            GestureDetector(
              onTap: logOut,
              child: Container(
                color: AppColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(

                    children: [
                      const Icon(
                        Icons.logout,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: fontSize*1.4,
                            color: AppColors.black),
                      ),

                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.black,
                        size: 17,
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }


}

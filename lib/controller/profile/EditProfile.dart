import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      backgroundColor: AppColors.primaryColor,

      body: Center(
        child:  Stack(
            children:[
              SvgPicture.asset(

                'assets/svg/profile_back.svg',

              ),


              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: height*0.15,),

                  Stack(
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0,right: 18),
                            child: Container(
                              margin: EdgeInsets.only(top: 48),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.0),
                              ),

                              // Add more widgets here
                              child: Column(
                                children: [
                                  const SizedBox(height: 80),
                                  Text(
                                    userName ?? "Ajony Houst",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade400, // Border color
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
                                            size: 17,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Edit Profile",
                                            style: TextStyle(
                                                fontSize: width * 0.035,
                                                color: AppColors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height*0.04,),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(16.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _buildSegment('assets/svg/ticket.svg', 'Parking Tickets', '20'),
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: 18.0),
                                            height: 30.0,
                                            width: 2,
                                            color: AppColors.white, // Color of the vertical line
                                          ),// First segment
                                          _buildSegment('assets/svg/tol.svg', 'City Tolls', '30'),
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: 18.0),
                                            height: 30.0,
                                            width: 2,
                                            color: AppColors.white, // Color of the vertical line
                                          ),// Second segment
                                          _buildSegment('assets/svg/city.svg', 'City Charges', '40'), // Third segment
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Add more widgets as needed
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white24, // Set the border color here
                                  width: 1.0, // Set the border width here
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 50.0,
                                backgroundImage: NetworkImage("${logo}"),
                                backgroundColor: Colors.transparent,
                              ),
                            )

                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            GestureDetector(
                              onTap: logOut,
                              child: SvgPicture.asset(
                                'assets/svg/logout.svg',
                              ),
                            ),
                            SizedBox(width: 40,)
                          ],
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: height*0.15,),


                  // Container(
                  //   color: AppColors.white,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(12),
                  //     child: Row(
                  //
                  //       children: [
                  //         const Icon(
                  //           Icons.email,
                  //           color: AppColors.black,
                  //         ),
                  //         const SizedBox(
                  //           width: 10,
                  //         ),
                  //         Text(
                  //           userEmail??"test@gmail.com",
                  //           style: TextStyle(
                  //               fontSize: fontSize*1.4,
                  //               color: AppColors.black),
                  //         ),
                  //
                  //
                  //
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   color: AppColors.white,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(12),
                  //     child: Row(
                  //
                  //       children: [
                  //         const Icon(
                  //           Icons.phone,
                  //           color: AppColors.black,
                  //         ),
                  //         const SizedBox(
                  //           width: 10,
                  //         ),
                  //         Text(
                  //           phoneNumber??"+91 3047907372",
                  //           style: TextStyle(
                  //               fontSize: fontSize*1.4,
                  //               color: AppColors.black),
                  //         ),
                  //
                  //
                  //
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: (){
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => CarDetails()),
                  //     );
                  //   },
                  //   child: Container(
                  //     color: AppColors.white,
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(12),
                  //       child: Row(
                  //
                  //         children: [
                  //           Image.asset(
                  //             'assets/png/license_plate.png',
                  //             color: AppColors.black,
                  //           ),
                  //           const SizedBox(
                  //             width: 10,
                  //           ),
                  //           Text(
                  //             licensePlate??"License plate",
                  //             style: TextStyle(
                  //                 fontSize: fontSize*1.4,
                  //                 color: AppColors.black),
                  //           ),
                  //
                  //           const Spacer(),
                  //           const Icon(
                  //             Icons.arrow_forward_ios,
                  //             color: AppColors.black,
                  //             size: 17,
                  //           ),
                  //
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 10,),
                  // GestureDetector(
                  //   onTap: (){
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => EditProfile()),
                  //       // MaterialPageRoute(builder: (context) => UpdatePassword()),
                  //     );
                  //   },
                  //   child: Container(
                  //
                  //     color: AppColors.white,
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(12),
                  //       child: Row(
                  //
                  //         children: [
                  //           const Icon(
                  //             Icons.lock,
                  //             color: AppColors.primaryColor,
                  //           ),
                  //           SizedBox(
                  //             width: 10,
                  //           ),
                  //           Text(
                  //             "Password",
                  //             style: TextStyle(
                  //                 fontSize: fontSize*1.4,
                  //                 color: AppColors.black),
                  //           ),
                  //
                  //           Spacer(),
                  //           const Icon(
                  //             Icons.arrow_forward_ios,
                  //             color: AppColors.black,
                  //             size: 17,
                  //           ),
                  //
                  //
                  //
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  //
                  //
                  // const Divider(color: Colors.grey,height: 1,),
                  // GestureDetector(
                  //   onTap: logOut,
                  //   child: Container(
                  //     color: AppColors.white,
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(12),
                  //       child: Row(
                  //
                  //         children: [
                  //           const Icon(
                  //             Icons.logout,
                  //             color: AppColors.primaryColor,
                  //           ),
                  //           const SizedBox(
                  //             width: 10,
                  //           ),
                  //           Text(
                  //             "Logout",
                  //             style: TextStyle(
                  //                 fontSize: fontSize*1.4,
                  //                 color: AppColors.black),
                  //           ),
                  //
                  //           const Spacer(),
                  //           const Icon(
                  //             Icons.arrow_forward_ios,
                  //             color: AppColors.black,
                  //             size: 17,
                  //           ),
                  //
                  //
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ]
        ),

      ),
    );
  }
  Widget _buildSegment(String iconData, String title, String number) {
    return Column(
      children: [
        SvgPicture.asset(
          iconData,
          width: 20,
          height: 20,
          color: Colors.white,),
        SizedBox(height: 8.0),
        Text(
          title,
          style: TextStyle(fontSize: 12.0,color: AppColors.white),
        ),
        SizedBox(height: 4.0),
        Text(
          number,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold,color: AppColors.white),
        ),
        // Divider line
      ],
    );
  }

}
class SegmentWidget extends StatefulWidget {
  @override
  _SegmentWidgetState createState() => _SegmentWidgetState();
}

class _SegmentWidgetState extends State<SegmentWidget> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
                  (index) => GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                  setState(() {
                    _currentPage = index;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Text(
                        index == _currentPage
                            ? "Selected Title"
                            : "Unselected Title",
                        style: TextStyle(
                          fontWeight: index == _currentPage
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Container(
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == _currentPage
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              ListView(
                children: [
                  ListTile(
                    title: Text("Parking Ticket 1"),
                  ),
                  ListTile(
                    title: Text("Parking Ticket 2"),
                  ),
                  // Add more list items as needed
                ],
              ),
              ListView(
                children: [
                  ListTile(
                    title: Text("Toll 1"),
                  ),
                  ListTile(
                    title: Text("Toll 2"),
                  ),
                  // Add more list items as needed
                ],
              ),
              ListView(
                children: [
                  ListTile(
                    title: Text("City Charge 1"),
                  ),
                  ListTile(
                    title: Text("City Charge 2"),
                  ),
                  // Add more list items as needed
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

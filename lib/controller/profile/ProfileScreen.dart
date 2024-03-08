import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kaar/controller/Notes/ActivityDataClass/ActivityDataClass.dart';
import 'package:kaar/controller/Notes/testnote/newNotesScreenItemview.dart';
import 'package:kaar/controller/UpdatePassword/UpdatePassword.dart';
import 'package:kaar/controller/carDetails/CarDetails.dart';
import 'package:kaar/controller/login/Login.dart';
import 'package:kaar/controller/profile/EditProfile.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/AllCityChargeItemView.dart';
import 'package:kaar/widgets/AllTollsItemView.dart';
import 'package:kaar/widgets/ParkingTicketCard.dart';
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
  String? _ticket_count;
  String? _toll_count;
  String? _city_count;
  bool? _isSelectedparking=true;
  bool? _isSelectedcity=false;
  bool? _isSelectedtoll=false;
  String? userid;
  List<Tolls> allTolls = [];
  List<Tickets> allTickets = [];
  List<Charges> cityCharges = [];
  @override
  void initState() {
    super.initState();
    // Load user details from shared preferences when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadUserDetails();
    });
  }

  // Function to load user details from shared preferences
  void loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted)setState(() {
      userName = prefs.getString('name');
      userEmail = prefs.getString('email');
      phoneNumber = prefs.getString('usernumber');
      licensePlate = prefs.getString('license_number');
      logo = prefs.getString('logo');
      userid = prefs.getString('userid');
      fetchallCount();
      fetchallTolls();
      fetchallTickets();
      fetchCityCharges();

    });
  }



  Future<void> fetchallTolls() async {
    final dio = Dio();

    try {
      final response = await dio.post(
        'https://dashboard.karrcompany.co.uk/api/recent/activity',
        queryParameters: {
          "driver_id": userid,
        },
      );

      final responseData = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {

        final status = responseData['status'] as bool;
        final message = responseData['message'] as String;

        if (status) {
          final chargeJson = responseData['tolls'];
          if (chargeJson != null) {
            chargeJson.forEach((v) {
              allTolls.add( Tolls.fromJson(v));
            });
          }
          print(' tolls screen :Data fetched successfully: $message');



          // isLoading = false;
          if(mounted)setState(() {});
          // Clear the existing list


        } else {
          // Handle the case where fetching data failed
          // isLoading = false;
          if (mounted) setState(() {});
          print('tolls screen :Data fetch failed: $message');
        }
      } else {
        // Handle error status codes (e.g., show an error message)
        // isLoading = false;
        if (mounted) setState(() {});
        print('tolls screen :API request failed with status code ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors or exceptions
      // isLoading = false;
      if (mounted)setState(() {});
      print('tolls screen :API request error: $e');
    }
  }
  Future<void> fetchCityCharges() async {
    final dio = Dio();

    try {
      final response = await dio.post(
        'https://dashboard.karrcompany.co.uk/api/recent/activity',
        queryParameters: {
          "driver_id": userid,
        },
      );

      final responseData = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final status = responseData['status'] as bool;
        final message = responseData['message'] as String;

        if (status) {
          final chargeJson = responseData['charges'];
          if (chargeJson != null) {
            chargeJson.forEach((v) {
              cityCharges.add(Charges.fromJson(v));
            });
          }
          print('Data fetched successfully: $message');
          // isLoading = false;
          if (mounted)setState(() {});
          // Clear the existing list
        } else {
          // Handle the case where fetching data failed
          // isLoading = false;
          if (mounted)setState(() {});
          print('Data fetch failed: $message');
        }
      } else {
        // Handle error status codes (e.g., show an error message)
        // isLoading = false;
        if (mounted)setState(() {});
        print('API request failed with status code ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors or exceptions
      // isLoading = false;
      if (mounted)setState(() {});
      print('API request error: $e');
    }
  }
  Future<void> fetchallTickets() async {
    final dio = Dio();

    try {
      final response = await dio.post(
        'https://dashboard.karrcompany.co.uk/api/driver/ticket',
        queryParameters: {
          "driver_id": userid,
        },
      );

      final responseData = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final status = responseData['status'] as bool;

        if (status) {
          final chargeJson = responseData['tickets'];
          if (chargeJson != null) {
            allTickets.clear(); // Clear the existing list
            chargeJson.forEach((v) {
              if (Tickets.fromJson(v).status == 0) {
                allTickets.add(Tickets.fromJson(v));
              }
            });
          }

          // isLoading = false; // Set loading to false after data is fetched
          if (mounted)setState(() {});
        } else {
          // isLoading = false; // Set loading to false even on failure
          if (mounted)setState(() {});
        }
      } else {
        // isLoading = false; // Set loading to false on API request failure
        if (mounted)setState(() {});
      }
    } catch (e) {
      // isLoading = false; // Set loading to false on error
      if (mounted)setState(() {});
    }
  }
  Future<void> fetchallCount() async {
    final dio = Dio();

    try {
      final response = await dio.get(
        'https://dashboard.karrcompany.co.uk/api/driver/record',
        queryParameters: {
          "id": userid,
        },
      );

      final responseData = response.data as Map<String, dynamic>;


      if (response.statusCode == 200) {
        final status = responseData['status'] as bool;

        if (status) {

          final ticket_count=responseData['tickets'];
          final toll_count=responseData['tolls'];
          final city_count=responseData['city charges'];
          _ticket_count=ticket_count.toString();
          _toll_count=toll_count.toString();
          _city_count=city_count.toString();



          // isLoading = false; // Set loading to false after data is fetched
          if (mounted)setState(() {});
        } else {
          // isLoading = false; // Set loading to false even on failure
          if (mounted)setState(() {});
        }
      } else {
        // isLoading = false; // Set loading to false on API request failure
        if (mounted)setState(() {});
      }
    } catch (e) {
      // isLoading = false; // Set loading to false on error
      if (mounted)setState(() {});
    }
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
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryColor,

      body: Center(
        child:  Stack(
            children:[
              SvgPicture.asset(

                'assets/svg/profile_back.svg',

              ),


              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: height*0.08,),

                    Stack(
                      children: [

                        Column(

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
                                            _buildSegment('assets/svg/ticket.svg', 'Parking Tickets', _ticket_count??"",width*0.03),
                                            Container(
                                              margin: EdgeInsets.symmetric(horizontal: 18.0),
                                              height: 30.0,
                                              width: 2,
                                              color: AppColors.white, // Color of the vertical line
                                            ),// First segment
                                            _buildSegment('assets/svg/tol.svg', 'City Tolls', _toll_count??"",width*0.03),
                                            Container(
                                              margin: EdgeInsets.symmetric(horizontal: 18.0),
                                              height: 30.0,
                                              width: 2,
                                              color: AppColors.white, // Color of the vertical line
                                            ),// Second segment
                                            _buildSegment('assets/svg/city.svg', 'City Charges', _city_count??"",width*0.03), // Third segment
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
                                                CapitalWOrd.capitalizeWithNumbers(licensePlate??"")??"License plate",
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
                                          // MaterialPageRoute(builder: (context) => newAllNotesItemView()),
                                          MaterialPageRoute(builder: (context) => UpdatePassword()),
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
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: EdgeInsets.only(left:16.0,right:16),
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                if (mounted)setState(() {
                                                  _isSelectedcity=false;
                                                  _isSelectedtoll=false;
                                                  _isSelectedparking=true;
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Parking Tickets',
                                                    style: TextStyle(
                                                      color: _isSelectedparking! ? AppColors.primaryColor : Colors.black,
                                                      fontSize: width*0.03,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Visibility(
                                                    visible: _isSelectedparking!,
                                                    child: Container(
                                                      width: 8,
                                                      height: 8,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppColors.primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            GestureDetector(
                                              onTap: (){
                                                if (mounted)setState(() {
                                                  _isSelectedcity=false;
                                                  _isSelectedtoll=true;
                                                  _isSelectedparking=false;
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Tolls',
                                                    style: TextStyle(
                                                      color: _isSelectedtoll! ? AppColors.primaryColor : Colors.black,
                                                      fontSize: width*0.03,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Visibility(
                                                    visible: _isSelectedtoll!,
                                                    child: Container(
                                                      width: 8,
                                                      height: 8,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppColors.primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            GestureDetector(
                                              onTap: (){
                                                if (mounted)setState(() {
                                                  _isSelectedcity=true;
                                                  _isSelectedtoll=false;
                                                  _isSelectedparking=false;
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'City Charges',
                                                    style: TextStyle(
                                                      color: _isSelectedcity! ? AppColors.primaryColor : Colors.black,
                                                      fontSize: width*0.03,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Visibility(
                                                    visible: _isSelectedcity!,
                                                    child: Container(
                                                      width: 8,
                                                      height: 8,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppColors.primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ), // Third segment
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:MainAxisAlignment.start,
                                      children: [
                                        Visibility(
                                          visible: _isSelectedcity!,
                                            child:cityCharges.isNotEmpty? Container(
                                              height: 160,
                                              padding: EdgeInsets.only(left:16.0,right:16,top:0),
                                              child: ListView.builder(
                                                itemCount: cityCharges.length,
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return AllCityChargeItemView(
                                                      cityCharge: cityCharges[index]);
                                                },
                                              ),
                                            ):Container(height: 160,child: Text("No city charges found"))),
                                        Visibility(
                                          visible: _isSelectedtoll!,
                                            child: allTolls.isNotEmpty?Container(
                                              height: 160,
                                              padding: EdgeInsets.only(left:16.0,right:16,top:0),
                                              child: ListView.builder(
                                                itemCount: allTolls.length,
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return AllTollsItemView(tolls: allTolls[index]);
                                                },
                                              ),
                                            ):Container(height: 160,child: Text("No tolls found"))),
                                        Visibility(
                                          visible: _isSelectedparking!,
                                            child:allTickets.isNotEmpty? Container(
                                              height: 160,
                                              padding: EdgeInsets.only(left:16.0,right:16,top:0),
                                              child: ListView.builder(
                                                itemCount: allTickets.length,
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return ParkingTicketCard(tickets: allTickets[index]);
                                                },
                                              ),
                                            ):Container(height: 160,child: Text("No Tickets found"))),
                                      ],
                                    )

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

                                child: ClipOval(
                                  child: Container(
                                    width: 100,
                                    height:  100,
                                    color: Colors.grey,

                                    child:Image.network(
                                      "${logo}",
                                      width: 100,
                                      height: 100,

                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.amber,
                                              value: loadingProgress.expectedTotalBytes != null
                                                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                                  : null,
                                            ),
                                          );
                                        }
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        // If there is an error loading the network image, show a placeholder image
                                        return  Center(
                                          child: Icon(
                                            Icons.person,
                                            size: 50.0,
                                            color: AppColors.primaryColor, // Color of the person icon
                                          ),
                                        );// You can replace this with your custom error widget
                                      },
                                    ),
                                  ),
                                ),

                                //
                                // child: CircleAvatar(
                                //   radius: 50.0,
                                //   backgroundImage: Image.network("${logo}",
                                //
                                //     loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                //       if (loadingProgress == null) {
                                //         return child;
                                //       } else {
                                //         return Center(
                                //           child: CircularProgressIndicator(
                                //             value: loadingProgress.expectedTotalBytes != null
                                //                 ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                //                 : null,
                                //           ),
                                //         );
                                //       }
                                //     },
                                //     errorBuilder: (context, error, stackTrace) {
                                //       // If there is an error loading the network image, show a placeholder image
                                //       return  Center(
                                //         child: Icon(
                                //           Icons.person,
                                //           size: 50.0,
                                //           color: AppColors.color_primary, // Color of the person icon
                                //         ),
                                //       );// You can replace this with your custom error widget
                                //     },),
                                //   backgroundColor: Colors.transparent,
                                // ),
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





                  ],
                ),
              ),
            ]
        ),

      ),
    );
  }
  Widget _buildSegment(String iconData, String title, String number,double fontsize) {
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
          style: TextStyle(fontSize: fontsize,color: AppColors.white),
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

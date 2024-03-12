import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kaar/controller/UpdatePassword/UpdatePassword.dart';
import 'package:kaar/controller/carDetails/CarDetails.dart';
import 'package:kaar/controller/login/Login.dart';
import 'package:kaar/controller/profile/EditProfile.dart';
import 'package:kaar/controller/tolls/AllTolls.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/TextView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? userName;
  String? logo;
  String? password;
  String? userEmail;
  String? phoneNumber;
  String? licensePlate;

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
      password = prefs.getString('password');

    });
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final fontSize = width * 0.03;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: 'Edit Profile',fontSize: width*0.04,onBackClick: (){
        Navigator.pop(context);
      },) ,

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
        
            
            Center(
              child: ClipOval(
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey,
                  child: Image.network(
                    "${logo}",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context,
                        Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.amber,
                            value:
                            loadingProgress.expectedTotalBytes !=
                                null
                                ? loadingProgress
                                .cumulativeBytesLoaded /
                                (loadingProgress
                                    .expectedTotalBytes ??
                                    1)
                                : null,
                          ),
                        );
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      // If there is an error loading the network image, show a placeholder image
                      return Center(
                        child: Icon(
                          Icons.person,
                          size: 50.0,
                          color: AppColors
                              .primaryColor, // Color of the person icon
                        ),
                      ); // You can replace this with your custom error widget
                    },
                  ),
                ),
              ),
            ),
        

            CustomWidget(title: 'Name', value: userName,),
            CustomWidget(title: 'Email', value: userEmail,),
            CustomWidget(title: 'Phone', value: phoneNumber,),
            CustomWidget(title: 'License Plate', value: CapitalWOrd.capitalizeWithNumbers(licensePlate??""),),

            CustomWidget(title: 'Password', value: password != null ? '*' * password!.length : '',endtitle: 'Change Password'),
        
        
        
        
          ],
        ),
      ),
    );
  }


}



class CustomWidget extends StatelessWidget {
  final String? title;
  final String? endtitle;
  final String? value;

  const CustomWidget({super.key, this.title, this.value, this.endtitle});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: Text(
            title??"",
            style: TextStyle(
              fontSize: width*0.04,
              fontFamily: 'Lato-Regular'
            ),
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            elevation: 1,
            margin:EdgeInsets.zero,
            color: Colors.white,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    value??"",
                    style: TextStyle(fontSize: width*0.035, fontFamily: 'Lato'),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UpdatePassword()),
                      );
                    },
                    child: Text(
                      endtitle??"",
                      style: TextStyle(fontSize: width*0.035, fontFamily: 'Lato-Regular',color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

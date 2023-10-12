import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/utils/Constants.dart';

class CarDetails extends StatefulWidget {
  @override
  _CarDetailsState createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  String? param_name;
  String? param_value;
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          // Set to true if you want the default back arrow
          toolbarHeight: height*0.09,
          title: Text(
            "Vehicle Details",
            style: TextStyle(
                fontSize: 18, color: AppColors.black, fontFamily: "Lato"),
          ),
          centerTitle: true,
          // Center the title horizontally,
          backgroundColor: AppColors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: AppColors.black, // Use your custom icon here
            onPressed: () {
              // Add your navigation logic here
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(children: [
              SizedBox(height: 30),
              Card(
                color: AppColors.primaryColor,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Container(
                  // Set margin of 20 from right and left
                  width: double.infinity,
                  // Match parent width
                  child: Image.asset(
                    'assets/png/car_image.png',
                    fit: BoxFit
                        .cover, // Optional: Adjust the image fit as needed
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "NM08 WUD",
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: height*0.03,
                    fontFamily: "Lato",
                fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50),
    Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Center(
    child: Column(children: [
            CustomVehicleDetailWidget(param_name: "Vehicle Make", param_value: "BMW"),
      SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Date of Registration", param_value: "November 2013"),
      SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Year of Manufacture", param_value: "2013"),
      SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Cylinder Capacity", param_value: "1598 Cc"),
      SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "CO2 Emissions", param_value: "131 G/Km"),
      SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Fuel Type", param_value: "Petrol"),
      SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Euro Status", param_value: "Not Applicable"),
      SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Real Driving Emissions", param_value: "Not Applicable"),
      SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Export Maker", param_value: "No"),
      SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Vehicle Status", param_value: "Taxed"),
      SizedBox(height: 30),
    ]
    )
    )
    )
            ]
            ),
          ),
        )
        )
    );
  }
}

class CustomVehicleDetailWidget extends StatelessWidget {
  CustomVehicleDetailWidget({
    super.key,
    required this.param_name,
    required this.param_value,
  });

  final  param_name;
  final  param_value;

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Row(children: [
      Text(param_name, style: TextStyle(
          fontSize: width*0.04 , fontFamily: "Lato-Regular", color: AppColors.black),),

      Spacer(),
      Text(param_value, style: TextStyle(
          fontSize: width*0.04, fontFamily: "Lato", color: AppColors.black),),
      ]
    );
  }
}

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
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          // Set to true if you want the default back arrow
          toolbarHeight: 80,
          title: const Text(
            "Vehicle Details",
            style: TextStyle(
                fontSize: 22, color: AppColors.black, fontFamily: "Lato"),
          ),
          centerTitle: true,
          // Center the title horizontally,
          backgroundColor: AppColors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppColors.black, // Use your custom icon here
            onPressed: () {
              // Add your navigation logic here
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(children: [
              const SizedBox(height: 30),
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
              const SizedBox(height: 30),
              const Text(
                "NM08 WUD",
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 40,
                    fontFamily: "Lato",
                fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Center(
    child: Column(children: [
            CustomVehicleDetailWidget(param_name: "Vehicle Make", param_value: "BMW"),
      const SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Date of Registration", param_value: "November 2013"),
      const SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Year of Manufacture", param_value: "2013"),
      const SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Cylinder Capacity", param_value: "1598 Cc"),
      const SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "CO2 Emissions", param_value: "131 G/Km"),
      const SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Fuel Type", param_value: "Petrol"),
      const SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Euro Status", param_value: "Not Applicable"),
      const SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Real Driving Emissions", param_value: "Not Applicable"),
      const SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Export Maker", param_value: "No"),
      const SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Vehicle Status", param_value: "Taxed"),
      const SizedBox(height: 30),
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
  const CustomVehicleDetailWidget({
    super.key,
    required this.param_name,
    required this.param_value,
  });

  final  param_name;
  final  param_value;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(param_name, style: TextStyle(
          fontSize: 20, fontFamily: "Lato-Regular", color: AppColors.black),),

      Spacer(),
      Text(param_value, style: TextStyle(
          fontSize: 22, fontFamily: "Lato", color: AppColors.black),),
      ]
    );
  }
}

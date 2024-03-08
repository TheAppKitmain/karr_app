import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/carDetails/carDetailDataClass/CarDetailDataClass.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarDetails extends StatefulWidget {
  @override
  _CarDetailsState createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  String? param_name;
  String? param_value;
  String? licensePlate;
  bool is_loading=true;
  CarDetailDataClass? cardetailResponse;

  void loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted)setState(() {

      licensePlate = prefs.getString('license_number');
    });
  }
  Future<CarDetailDataClass?> fetchCarDetails() async {
    final dio = Dio();

    try {
      final response = await dio.post(
        'https://dvlasearch.appspot.com/DvlaSearch',
        queryParameters: {
          'apikey': "LkN2tlDSFnZZ5zQp",
          'licencePlate': "mt09nks",

        },
      );

      final responseData = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {


        final cardetailresponse=CarDetailDataClass.fromJson(responseData);
        if (mounted)setState(() {
          is_loading=false;
        });
        cardetailResponse=CarDetailDataClass.fromJson(responseData);
        return cardetailresponse;


      } else {
        if (mounted)setState(() {
          is_loading=false;
        });
        // Handle error status codes (e.g., show an error message)
        print('API request failed with status code ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle network errors or exceptions
      print('API request error: $e');
      if (mounted)setState(() {
        is_loading=false;
      });
      return null;
    }
  }
  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadUserDetails();
      fetchCarDetails();
    });

  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
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
        ),
        body: is_loading?Center(child: CircularProgressIndicator()):SingleChildScrollView(
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
                CapitalWOrd.capitalizeWithNumbers(licensePlate!)??"N/A",
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: height*0.03,
                    fontFamily: "Lato",
                fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50),
    Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Center(
    child: Column(children: [
            CustomVehicleDetailWidget(param_name: "Vehicle Make", param_value: cardetailResponse?.make??'N/A' ),
      SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Date of Registration", param_value: cardetailResponse?.dateOfFirstRegistration??"N/A"),
      SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Year of Manufacture", param_value: cardetailResponse?.yearOfManufacture??"N/A"),
      SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Cylinder Capacity", param_value: cardetailResponse?.cylinderCapacity??"N/A"),
      SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "CO2 Emissions", param_value: cardetailResponse?.co2Emissions??"N/A"),
      SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Fuel Type", param_value: cardetailResponse?.fuelType??"N/A"),
      SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "WheelPlan", param_value: cardetailResponse?.wheelPlan??"N/A"),
      SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Colour", param_value: cardetailResponse?.colour??"N/A"),
      SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Model", param_value: cardetailResponse?.model??"N/A"),
      SizedBox(height: 30),
            CustomVehicleDetailWidget(param_name: "Vehicle taxed Status", param_value: cardetailResponse?.taxed.toString()??"N/A"),
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
          fontSize: width*0.035 , fontFamily: "Lato-Regular", color: AppColors.black),),

      Spacer(),
      Text(param_value, style: TextStyle(
          fontSize: width*0.035, fontFamily: "Lato", color: AppColors.black),),
      ]
    );
  }
}

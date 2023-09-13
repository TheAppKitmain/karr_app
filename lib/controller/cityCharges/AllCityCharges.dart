import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/cityCharges/AddCityCharges.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/PrimaryButton.dart';
import 'package:kaar/widgets/ParkingTicketCard.dart';

class CityCharges extends StatefulWidget {
  @override
  _CityChargesState createState() => _CityChargesState();
}

class _CityChargesState extends State<CityCharges> {
  List<String> gameList = [ "Date", "City"];
  var selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // Set to true if you want the default back arrow
        toolbarHeight: 80,
        title: Text(
          "All City Charges",
          style: TextStyle(
              fontSize: 20,
              color: AppColors.black // Adjust the title text size as needed
          ),

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

          child: Column(children: [
            Padding(
              padding: EdgeInsets.all(30.0),
              child:
          Row(children: [
           Text("All Charges", style: TextStyle(
              fontSize: 18, fontFamily: "Lato", color: AppColors.black),),

            Spacer(),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black), // Set the black outline border
                borderRadius: BorderRadius.circular(10),
                // Set border radius if needed
              ),
              padding: EdgeInsets.symmetric(horizontal: 35), // Add horizontal padding
              child: DropdownButton<String>(
                value: selectedValue,
                underline: null,
                hint: Text("Sort By",style: TextStyle(color: AppColors.black),),

                items: gameList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
              ),
            )


          ],),
    ),
    SizedBox(height: 90,),
    Center(
    child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Image.asset(
    'assets/png/nocitycharges.png',
    // Replace with your image asset path
    width: 200,
    height: 300,
    ),
    ),
    ),
    Center( child: Text("Haven't Added Before?",style: TextStyle(fontSize: 23,fontFamily: "Lato",color: AppColors.black),)),
    SizedBox(height: 20,),
    Center( child: Text("Click “Add City Charge” and provide us with the ",style: TextStyle(fontSize: 18,fontFamily: "fonts/Lato-BoldItalic",color: AppColors.black),)),
    Center( child: Text("details to add new charge for you. ",style: TextStyle(fontSize: 18,fontFamily: "fonts/Lato-BoldItalic",color: AppColors.black),)),

    Center(
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: PrimaryButton(
    text: 'Add City Charge',
    onPressed: () {


    },
    )),
    ),

    ]
    ),


    ),
      floatingActionButton: FloatingActionButton(
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddCityCharges()),
        );
      },
      backgroundColor: AppColors.primaryColor,
      child: const Icon(Icons.add),
    ),
    );
  }
}
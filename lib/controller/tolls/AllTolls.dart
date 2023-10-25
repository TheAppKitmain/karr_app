import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:kaar/controller/cityCharges/dataclass/AllCityChargesDataClass.dart';
import 'package:kaar/controller/tolls/AddTolls.dart';
import 'package:kaar/controller/tolls/dataClass/TollsDataClass.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/AllTollsItemView.dart';
import 'package:kaar/widgets/PrimaryButton.dart';


class AllTolls extends StatefulWidget {
  @override
  _AllTollsState createState() => _AllTollsState();
}

class _AllTollsState extends State<AllTolls> {
  List<String> gameList = [ "Date", "City"];
  List<Toll> allTolls = [];


  var selectedValue;


  Future<void> fetchallTolls() async {
    final dio = Dio();

    try {
      final response = await dio.get(
        'http://ec2-54-146-4-118.compute-1.amazonaws.com/api/toll',
      );

      final responseData = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {

        final status = responseData['status'] as bool;
        final message = responseData['message'] as String;

        if (status) {
          final chargeJson = responseData['tolls'];
          if (chargeJson != null) {
            chargeJson.forEach((v) {
              allTolls.add( Toll.fromJson(v));
            });
          }
          print(' tolls screen :Data fetched successfully: $message');


          setState(() {
          });
          // Clear the existing list


        } else {
          // Handle the case where fetching data failed
          print('tolls screen :Data fetch failed: $message');
        }
      } else {
        // Handle error status codes (e.g., show an error message)
        print('tolls screen :API request failed with status code ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors or exceptions
      print('tolls screen :API request error: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchallTolls();
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // Set to true if you want the default back arrow
        toolbarHeight: height*0.08,
        elevation: 0,
        title: Text(
          "All Tolls",
          style: TextStyle(
              fontSize: width*0.05,
              color: AppColors.black,
            fontFamily: "Lato"
          ),

        ),
        centerTitle: true,
        // Center the title horizontally,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(

        child: Column(children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child:
            Row(children: [
              Text("All Tolls", style: TextStyle(
                  fontSize: width*0.045, fontFamily: "Lato", color: AppColors.black),),

              Spacer(),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black), // Set the black outline border
                  borderRadius: BorderRadius.circular(10),
                  // Set border radius if needed
                ),
                padding: EdgeInsets.symmetric(horizontal:25), // Add horizontal padding
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


          allTolls.isNotEmpty?

          Padding(
              padding: EdgeInsets.all(10.0),child: ListView.builder(
            itemCount: allTolls.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return AllTollsItemView(tolls: allTolls[index]);
            },)
          )
              :Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    'assets/png/notolls.png',
                    // Replace with your image asset path
                    width: width*0.3,
                    height: height*0.2,
                  ),
                ),
              ),
              Center( child: Text("Haven't Added Before?",style: TextStyle(fontSize: width*0.07,fontFamily: "Lato",color: AppColors.black),)),
              SizedBox(height: 20,),
              Center( child: Text("Click “Add Toll” and provide us with the details to ",style: TextStyle(fontSize: width*0.04,fontFamily: "Lato-Regular",color: AppColors.black),)),
              Center( child: Text("add toll for you.",style: TextStyle(fontSize: width*0.04,fontFamily: "Lato-Regular",color: AppColors.black),)),

              Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PrimaryButton(
                      text: 'Add New Toll',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddTolls()),
                        );

                      },
                    )),
              ),
            ],

          ),



        ]
        ),


      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddTolls()),
          );
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
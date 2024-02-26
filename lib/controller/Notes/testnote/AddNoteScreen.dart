import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:kaar/controller/Notes/testnote/dataclass.dart';
import 'package:kaar/controller/Notes/testnote/itemviews/AddNotesItemView.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../tolls/AllTolls.dart';

class TestNoteScreen extends StatefulWidget {


  Function(int?) onNext;
  Function(int?) onPrevious;



  TestNoteScreen( {required this.onNext,required this.onPrevious});

  @override
  State<TestNoteScreen> createState() => _TestNoteScreenState();
}

class _TestNoteScreenState extends State<TestNoteScreen> {
  List<Charge> cityCharges = [];
  List<Toll> allTolls = [];
  List<Ticket> allTickets = [];

  bool isLoading = true;
  List<String> gameList = ["Tolls", "City charges", "Tickets"];
  var selectedValue;
  String? userid;

  @override
  void initState() {
    super.initState();
    loadUserDetails();
  }

  void loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString('userid');
      fetchallData();
    });
  }

  Future<void> fetchallData() async {
    final dio = Dio();

    try {
      final response = await dio.post(
        'https://dashboard.karrcompany.co.uk/api/recent/activity',
        queryParameters: {
          "driver_id": userid,
        },
      );

      final responseData = response.data as Map<String, dynamic>;
      print(responseData);

      if (response.statusCode == 200) {
        final status = responseData['status'] as bool;

        if (status) {
          final chargeJson = responseData['charges'];
          if (chargeJson != null) {
            chargeJson.forEach((v) {
              if (Charge.fromJson(v).note=='{}'){
                cityCharges.add(Charge.fromJson(v));
              }

            });
          }
          final tollJson = responseData['tolls'];
          if (tollJson != null) {
            tollJson.forEach((v) {
              if (Toll.fromJson(v).note=='{}'){
                allTolls.add(Toll.fromJson(v));
              }

            });
          }
          final ticketsJson = responseData['tickets'];
          if (ticketsJson != null) {
            ticketsJson.forEach((v) {
              if (Ticket.fromJson(v).note=='{}'){
                allTickets.add(Ticket.fromJson(v));
              }

            });
          }

          isLoading = false;
          setState(() {});
        } else {
          isLoading = false;
          setState(() {});
        }
      } else {
        isLoading = false;
        setState(() {});
      }
    } catch (e) {
      isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    final fontSize = width * 0.04;
    return WillPopScope(
      onWillPop: () =>widget.onPrevious(0),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade200,
        appBar: CustomAppBar(fontSize: fontSize,onBackClick: () {
          widget.onPrevious(0);
        },title: 'Add Notes',),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Spacer(),
                    Card(
                      elevation: 4,
                      color: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: DropdownButton<String>(
                          value: selectedValue,
                          underline: Offstage(),
                          hint: Text(
                            "Sort By",
                              style: TextStyle(color: AppColors.black,fontSize: fontSize,fontFamily: 'Lato-Regular',fontWeight: FontWeight.normal),
                          ),
                          items: gameList.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,style: TextStyle(color: AppColors.black,fontSize: fontSize,fontFamily: 'Lato-Regular',fontWeight: FontWeight.normal),),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : Padding(
                padding: const EdgeInsets.all(8.0),
                child: AddNotesItemView(
                  allTolls: allTolls,
                  cityCharges: cityCharges,
                  allTickets: allTickets,
                  selectedCategory: selectedValue ?? "All",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

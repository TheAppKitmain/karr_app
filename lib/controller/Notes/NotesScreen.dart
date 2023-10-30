import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kaar/controller/Notes/ActivityDataClass/ActivityDataClass.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/AllCityChargeItemView.dart';
import 'package:kaar/widgets/AllTollsItemView.dart';
import 'package:kaar/widgets/ParkingTicketCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Charges> cityCharges = [];
  List<Tolls> allTolls = [];
  List<Tickets> allTickets = [];

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
        'http://ec2-54-146-4-118.compute-1.amazonaws.com/api/recent/activity',
        queryParameters: {
          "driver_id": userid,
        },
      );

      final responseData = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final status = responseData['status'] as bool;

        if (status) {
          final chargeJson = responseData['charges'];
          if (chargeJson != null) {
            chargeJson.forEach((v) {
              cityCharges.add(Charges.fromJson(v));
            });
          }
          final tollJson = responseData['tolls'];
          if (tollJson != null) {
            tollJson.forEach((v) {
              allTolls.add(Tolls.fromJson(v));
            });
          }
          final ticketsJson = responseData['tickets'];
          if (ticketsJson != null) {
            ticketsJson.forEach((v) {
              allTickets.add(Tickets.fromJson(v));
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

  List<Widget> buildSelectedList() {
    if (selectedValue == "Tolls") {
      return allTolls.isEmpty
          ? [Text("Tolls list is empty")]
          : allTolls
          .map((toll) => AllTollsItemView(tolls: toll))
          .toList();
    } else if (selectedValue == "City charges") {
      return cityCharges.isEmpty
          ? [Text("City charges list is empty")]
          : cityCharges
          .map((charge) => AllCityChargeItemView(cityCharge: charge))
          .toList();
    }
    else {
      return allTickets.isEmpty
          ? [Text("Tickets list is empty")]
          : allTickets
          .map((ticket) => ParkingTicketCard(tickets: ticket))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        toolbarHeight: 60,
        title: Text(
          "All Notes",
          style: TextStyle(
            fontSize: 20,
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Spacer(), Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: DropdownButton<String>(
                    value: selectedValue,
                    underline: null,
                    hint: Text("Sort By", style: TextStyle(color: AppColors.black),),
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
                )],
              ),
            ),
            isLoading
                ? CircularProgressIndicator()
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: buildSelectedList()),
                )
          ],
        ),
      ),
    );
  }
}

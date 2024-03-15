import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:kaar/controller/Notes/ActivityDataClass/ActivityDataClass.dart';
import 'package:kaar/controller/cityCharges/AddCityCharges.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/AllCityChargeItemView.dart';
import 'package:kaar/widgets/PrimaryButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../tolls/AllTolls.dart';

class CityCharges extends StatefulWidget {
  Function(int?) onNext;
  Function(int?) onPrevious;



  CityCharges( {required this.onNext,required this.onPrevious});
  @override
  _CityChargesState createState() => _CityChargesState();
}

class _CityChargesState extends State<CityCharges> {
  List<String> gameList = ["All","Date", "City"];
  List<Charges> cityCharges = [];
  bool isLoading = true;
  bool isdateSelected = true;
  var selectedValue='All';

  String? userid;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadUserDetails();
    });
  }

  void loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted)setState(() {
      userid = prefs.getString('userid');
      fetchCityCharges();
    });
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
          isLoading = false;
          if (mounted)setState(() {});
          // Clear the existing list
        } else if(message=="No Driver found for this driver_id"){
          if(mounted)
            setState(() {
              isLoading=false;
            });
          logOut(context);
          return response.data;

        }else {
          // Handle the case where fetching data failed
          isLoading = false;
          if (mounted)setState(() {});
          print('Data fetch failed: $message');
        }
      } else {
        // Handle error status codes (e.g., show an error message)
        isLoading = false;
        if (mounted)setState(() {});
        print('API request failed with status code ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors or exceptions
      isLoading = false;
      if (mounted)setState(() {});
      print('API request error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final fontSize = width * 0.04;
    return WillPopScope(
      onWillPop: () =>widget.onPrevious(0),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(fontSize: fontSize,onBackClick: () {
          widget.onPrevious(0);
        },title: 'All City Charges',),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  "All Charges",
                  style: TextStyle(
                      fontSize: fontSize,
                      fontFamily: "Lato",
                      color: AppColors.black),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(

                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.only(right: 5),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      // hint: Expanded(
                      //   child: Text(
                      //     'Sort By',
                      //     style: TextStyle(
                      //       fontSize: 14,
                      //       fontFamily: 'Lato-Regular',
                      //       color: Colors.black,
                      //     ),
                      //     overflow: TextOverflow.ellipsis,
                      //   ),
                      // ),
                      items: gameList
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Lato-Regular'
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (String? value) {
                        if (mounted)setState(() {
                          selectedValue = value!;
                          if(value=='Date')
                            isdateSelected=true;
                          else if(value=='City')
                            isdateSelected=false;

                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: 160,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black,
                          ),
                          color: Colors.white,
                        ),

                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                        ),
                        iconSize: 18,
                        // iconEnabledColor: Colors.yellow,
                        // iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        offset: const Offset(-20, 0),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all<double>(6),
                          thumbVisibility: MaterialStateProperty.all<bool>(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ), isLoading
              ? Center(
            child:
            CircularProgressIndicator(),

          ):
          cityCharges.isNotEmpty
              ?isdateSelected?
              Expanded(
                child: GroupedListView(elements: cityCharges, groupBy:  (element) => element.date!, groupComparator: (value1, value2) => value2.compareTo(value1),
                  itemComparator: (item1, item2) =>
                      item1.id.toString().compareTo(item2.id.toString()),
                  order: GroupedListOrder.DESC,
                
                  groupSeparatorBuilder: (String value) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextWithLines(text: formatDate(value)),
                    // Text(
                    //
                    //   textAlign: TextAlign.center,
                    //   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    // ),
                  ),itemBuilder: (c, element) {
                  return AllCityChargeItemView(
                                      cityCharge: element);
                },),
              ):Expanded(
            child: GroupedListView(elements: cityCharges, groupBy:  (element) => element.name!, groupComparator: (value1, value2) => value2.compareTo(value1),
              itemComparator: (item1, item2) =>
                  item1.id.toString().compareTo(item2.id.toString()),
              order: GroupedListOrder.DESC,

              groupSeparatorBuilder: (String value) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWithLines(text: value),
                // Text(
                //
                //   textAlign: TextAlign.center,
                //   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
              ),itemBuilder: (c, element) {
                return AllCityChargeItemView(
                    cityCharge: element);
              },),
          )
          // Expanded(
          //         child: ListView.builder(
          //           itemCount: cityCharges.length,
          //           scrollDirection: Axis.vertical,
          //           shrinkWrap: true,
          //           itemBuilder: (context, index) {
          //             return AllCityChargeItemView(
          //                 cityCharge: cityCharges[index]);
          //           },
          //         ),
          //       )
              : Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          'assets/png/nocitycharges.png',
                          // Replace with your image asset path
                          width: width*0.3,
                          height: height*0.2,
                        ),
                      ),
                    ),
                    Center(
                        child: Text(
                      "Haven't Added Before?",
                      style: TextStyle(
                          fontSize: width * 0.07,
                          fontFamily: "Lato",
                          color: AppColors.black),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(
                      "Click Add City Charge and provide us with the ",
                      style: TextStyle(
                          fontSize: fontSize,
                          fontFamily: "fonts/Lato-Regular",
                          color: AppColors.black),
                    )),
                    Center(
                        child: Text(
                      "details to add new charge for you. ",
                      style: TextStyle(
                          fontSize: fontSize,
                          fontFamily: "fonts/Lato-Regular",
                          color: AppColors.black),
                    )),
                    Center(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: PrimaryButton(
                            text: 'Add City Charge',
                            onPressed: () {
                              widget.onNext(7);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => AddCityCharges()),
                              // );
                            },
                          )),
                    ),
                  ],
                ),
        ]),
        // floatingActionButton: Visibility(
        //   visible: cityCharges.isEmpty?false:true,
        //   child: FloatingActionButton(
        //     onPressed: () {
        //       widget.onNext(7);
        //       // Navigator.push(
        //       //   context,
        //       //   MaterialPageRoute(builder: (context) => AddCityCharges()),
        //       // );
        //     },
        //     backgroundColor: AppColors.primaryColor,
        //     child: const Icon(Icons.add),
        //   ),
        // ),
      ),
    );
  }

  String formatDate(String dateString) {
    // Parse the input date string
    DateTime date = DateFormat('dd-MM-yyyy').parse(dateString);

    // Get the current date
    DateTime now = DateTime.now();

    // Compare the input date with the current date
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today';
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day - 1) {
      return 'Yesterday';
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day + 1) {
      return 'Tomorrow';
    } else {
      // If the date is not today, yesterday, or tomorrow, format it using a date formatter
      return formatWithSuffix(dateString);
    }
  }
  String formatWithSuffix(String date) {
    DateFormat format = DateFormat('dd-MM-yyyy');
    DateTime dateTime = format.parse(date);
    String suffix = 'th';
    int day = dateTime.day;
    if (day == 1 || day == 21 || day == 31) {
      suffix = 'st';
    } else if (day == 2 || day == 22) {
      suffix = 'nd';
    } else if (day == 3 || day == 23) {
      suffix = 'rd';
    }
    return
      // DateFormat('dd')  // Format day without suffix
      //   .format(dateTime)
      //   .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},') +
        '${dateTime.day}'+suffix + ' ' + DateFormat('MMMM yyyy').format(dateTime);
  }



}
class TextWithLines extends StatelessWidget {
  final String text;

  const TextWithLines({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: Colors.black38,
            height: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            text,
            style: TextStyle(fontSize: width*0.03),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.black38,
            height: 1,
          ),
        ),
      ],
    );
  }
}

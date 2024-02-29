import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:kaar/controller/Notes/ActivityDataClass/ActivityDataClass.dart';

import 'package:kaar/controller/cityCharges/dataclass/AllCityChargesDataClass.dart';
import 'package:kaar/controller/tolls/AddTolls.dart';

import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/AllTollsItemView.dart';
import 'package:kaar/widgets/PrimaryButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class AllTolls extends StatefulWidget {

  Function(int?) onNext;
  Function(int?) onPrevious;



  AllTolls( {required this.onNext,required this.onPrevious});
  @override
  _AllTollsState createState() => _AllTollsState();
}

class _AllTollsState extends State<AllTolls> {
  List<String> gameList = [ "Date", "City"];
  List<Tolls> allTolls = [];
  bool isLoading = true;

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
      fetchallTolls();
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



          isLoading = false;
          setState(() {});
          // Clear the existing list


        } else {
          // Handle the case where fetching data failed
          isLoading = false;
          setState(() {});
          print('tolls screen :Data fetch failed: $message');
        }
      } else {
        // Handle error status codes (e.g., show an error message)
        isLoading = false;
        setState(() {});
        print('tolls screen :API request failed with status code ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors or exceptions
      isLoading = false;
      setState(() {});
      print('tolls screen :API request error: $e');
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
        backgroundColor: Colors.white,
        appBar: CustomAppBar(fontSize: fontSize,onBackClick: () {
          widget.onPrevious(0);
        }, title: 'All Tolls',),
        body:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children: [

          Padding(
            padding: EdgeInsets.all(20.0),
            child:
            Row(children: [
              Text("All Tolls", style: TextStyle(
                  fontSize: fontSize, fontFamily: "Lato", color: AppColors.black),),

              Spacer(),
              Card(
                elevation: 4,
                color: Colors.white,
                child: Container(

                  decoration: BoxDecoration(
                      color: Colors.white,
                    border: Border.all(color: Colors.white), // Set the black outline border
                    borderRadius: BorderRadius.circular(10),
                    // Set border radius if needed
                  ),
                  padding: EdgeInsets.symmetric(horizontal:25), // Add horizontal padding
                  child: DropdownButton<String>(
                    value: selectedValue,
                    underline: Offstage(),
                    hint: Padding(
                      padding:  EdgeInsets.only(right: width*0.09),
                      child: Text("Sort By",style: TextStyle(color: AppColors.black,fontSize: fontSize,fontFamily: 'Lato-Regular',fontWeight: FontWeight.normal),),
                    ),

                    items: gameList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style: TextStyle(color: AppColors.black,fontSize: fontSize,fontFamily: 'Lato-Regular',fontWeight: FontWeight.normal)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue;
                      });
                    },
                  ),
                ),
              )


            ],),
          ),
              isLoading
                  ? Center(
                child:
                CircularProgressIndicator(),

              ):

          allTolls.isNotEmpty?
          Expanded(
            child: GroupedListView(elements: allTolls, groupBy:  (element) => element.date!, groupComparator: (value1, value2) => value2.compareTo(value1),
              itemComparator: (item1, item2) =>
                  item1.id.toString().compareTo(item2.id.toString()),
              order: GroupedListOrder.ASC,
              useStickyGroupSeparators: true,
              groupSeparatorBuilder: (String value) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWithLines(text: formatDate(value)),
                // Text(
                //
                //   textAlign: TextAlign.center,
                //   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
              ),itemBuilder: (c, element) {
                return AllTollsItemView(tolls: element);
              },),
          )

          // Expanded(
          //   child: ListView.builder(
          //   itemCount: allTolls.length,
          //   scrollDirection: Axis.vertical,
          //   shrinkWrap: true,
          //   itemBuilder: (context, index) {
          //   return AllTollsItemView(tolls: allTolls[index]);
          //   },),
          // )
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
              Center( child: Text("Haven't Added Before?",style: TextStyle(fontSize: width*0.05,fontFamily: "Lato",color: AppColors.black),)),
              SizedBox(height: 20,),
              Center( child: Text("Click 'Add Toll' and provide us with the details to ",style: TextStyle(fontSize:fontSize,fontFamily: "Lato-Regular",color: AppColors.black),)),
              Center( child: Text("add toll for you.",style: TextStyle(fontSize: fontSize,fontFamily: "Lato-Regular",color: AppColors.black),)),

              Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PrimaryButton(
                      text: 'Add New Toll',
                      onPressed: () {
                        widget.onNext(4);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => AddTolls(onPrevious: (v){widget.onPrevious(0);},onNext: (v){})),
                        // );

                      },
                    )),
              ),
            ],

          ),



        ]
        ),
        floatingActionButton: Visibility(
          visible: allTolls.isNotEmpty?true:false,
          child: FloatingActionButton(
            onPressed: (){
              widget.onNext(4);

            },
            backgroundColor: AppColors.primaryColor,
            child: const Icon(Icons.add),
          ),
        ),
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
    return DateFormat('dd')  // Format day without suffix
        .format(dateTime)
        .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},') +
        suffix + ' ' + DateFormat('MMMM yyyy').format(dateTime);
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

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.fontSize, required this.onBackClick, required this.title,this.tabBar,
  });

  final double fontSize;
  final String title;
  final VoidCallback onBackClick;
  final PreferredSizeWidget? tabBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Set to true if you want the default back arrow
      elevation: 0,
      leading: IconButton(onPressed: onBackClick, icon: Icon(Platform.isAndroid?Icons.arrow_back:Icons.arrow_back_ios)),
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,

      title: Text(
        title,
        style: TextStyle(
            fontSize: fontSize,
            color: AppColors.black,
          fontFamily: "Lato"
        ),

      ),
      centerTitle: true,
      bottom:tabBar,

      // Center the title horizontally,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(90.0);
}
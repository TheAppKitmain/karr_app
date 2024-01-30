import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kaar/utils/Constants.dart';
import 'package:kaar/widgets/TextView.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatefulWidget {

 Function(int?) onNext;

 

HomeScreen( {required this.onNext});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool is_recent=false;
  bool is_recent_length1=false;
    String? _username;
    String? _recent_value2='';
    String? _recent_value1='';
     List<String> recent_activities= [];


    Future<List<String>> getRecentActivities() async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String> activities = prefs.getStringList('recent_activities') ?? [];
        return activities;
      } catch (e) {
        print('Error getting recent activities: $e');
        return []; // Return an empty list in case of error
      }
    }

  @override
  void initState() {
    super.initState();
    loadUserDetails();



  }

  void loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('name')!;
      recent_activities=prefs.getStringList('recent_activities') ?? [];
      if (recent_activities.length<1){
        is_recent=false;
        _recent_value1='';
      }else{
        if(recent_activities.length==1){
          is_recent_length1=false;
          _recent_value2='';
        }else{
          is_recent_length1=true;
          _recent_value2=recent_activities.elementAt(recent_activities.length-2);
        }
        _recent_value1=recent_activities.elementAt(recent_activities.length-1);
        is_recent=true;
      }
      print('recent activity $recent_activities');
    });
  }




  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, children: [

            Center(
              child:  Image.asset(
                  'assets/png/kaar_logo.png',
                  // Replace with your image asset path
                  width: width*0.37,
                  height: 120,
                ),

            ),

          //   Row(
          //     children:[
          //
          //       Align(
          //       alignment: Alignment.topLeft,
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 10),
          //         child: TextView(
          //           text: "Welcome, $_username!",
          //
          //           onPressed: () {},
          //         ),
          //       ),
          //     ),
          //       Spacer(),
          //       CircleAvatar(
          //
          //         backgroundColor: Colors.white,
          //         child: Image.asset(
          //           'assets/png/profile_test.png',
          //           // Replace with your image asset path
          //           width: 40,
          //           height: 40,
          //
          //         ),
          //       ),
          //       SizedBox(width: 20,),
          // ]
          //   ),
          //   SizedBox(height: height * 0.01),
          //
          //   SizedBox(height: height * 0.020),
            Wrap(
              runSpacing: height * .010,
              spacing: 10,
              children: [
                HomeScreenCard(
                  onTap: () => widget.onNext(3),
                  //     Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ParkingTickets(),
                  //   ),
                  // ),
                  addNew: () => widget.onNext(1),
      // Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => Step1Screen(),
      //               ),
      //             ),
                ),
                HomeScreenCard(
                    image: 'assets/svg/tol.svg',
                    title: 'Toll',
                    des: 'Create new toll entries and check all tolls.',
                    cardColor: AppColors.blue,
                  onTap: () =>widget.onNext(5),
                  //     Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AllTolls(),
                  //   ),
                  // ),
                  addNew: () => widget.onNext(4),
                  //     Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AddTolls(),
                  //   ),
                  // ),
                ),
                HomeScreenCard(
                    image: 'assets/svg/city.svg',
                    title: 'City Charges',
                    des: 'Create new charge entries and check status of all charges.',
                    cardColor: AppColors.yellow,
                  onTap: () =>widget.onNext(6),
                  //     Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => CityCharges(),
                  //   ),
                  // ),
                  addNew: () => widget.onNext(7)
                  //     Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AddCityCharges(),
                  //   ),
                  // ),
                ),
                HomeScreenCard(
                    image: 'assets/svg/note.svg',
                    title: 'Notes',
                    des: 'Create new notes and check all notes you\'ve created.',
                    cardColor: AppColors.pink,
                  onTap: () => widget.onNext(8),
                  //     Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => TestNoteScreen(),
                  //   ),
                  // ),
                  addNew: () => widget.onNext(9),
                  //     Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => TestNoteScreen(),
                  //   ),
                  // ),
                )
              ],
            ),
            
            Visibility(
              visible: is_recent,
              child: Row(
                children:[
                  Padding(
                    padding: const EdgeInsets.only(left:12.0,top: 12.0),
                    child: TextView(
                    text: "Recent Activity",
              
                    onPressed: () {},
                ),
                  ),
                        ]
              ),
            ),
            Visibility(
              visible: is_recent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                  ),
                  child: Column(children: [
                    RecentActivityCard(
                      title: _recent_value1??'',
                      showDivider: is_recent_length1,
                    ),

                    Visibility(
                      visible: is_recent_length1,
                      child: RecentActivityCard(
                        title: _recent_value2??'',
                        showDivider: false,
                      ),
                    ),
                  ],),
                ),
              ),
            ),

          ]),
        ),
      ),


    );
  }
}

class HomeScreenCard extends StatelessWidget {
  const HomeScreenCard({
    super.key,
    this.image,
    this.title,
    this.des,
    this.cardColor,
    this.onTap,
    this.addNew,
  });

  final String? image, title, des;
  final Color? cardColor;
  final VoidCallback? onTap, addNew;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width / 2.1,

      child: Card(
        margin: EdgeInsets.only(top: height * 0.01),
        color: cardColor ?? AppColors.primaryColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: SvgPicture.asset(
                  image ??'assets/svg/ticket.svg',
                  semanticsLabel: 'otp logo',
                ),
                // Image.asset(
                //   image ?? 'assets/png/parking_tickets.png',
                //   // Replace with your image asset path
                //   width: 40,
                //   height: 40,
                //   color: cardColor ?? AppColors.primaryColor,
                // ),
              ),
              SizedBox(height: height * 0.020),
              Text(
                title ?? 'Parking Ticket',
                style: TextStyle(
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: height * 0.020),
              Text(
                des ?? 'Create new ticket entries and check status of all tickets.',
                style: TextStyle(
                  fontSize: width * 0.026,
                  color: Colors.white,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: height * 0.020),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: addNew,

                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      ),
                      child: Text(
                        'Add New',
                        style: TextStyle(
                          fontSize: width * 0.028,
                          color: cardColor ??
                              AppColors.primaryColor, // Button text color
                          // Add this line
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,

                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      ),
                      child: Text(
                        'View All', // Adjust text as needed
                        style: TextStyle(
                          fontSize: width * 0.028,
                          color: cardColor ??
                              AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
class RecentActivityCard extends StatelessWidget {
  final String title;
  final bool showDivider;

  RecentActivityCard({required this.title, required this.showDivider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 12.0, // Adjust the size of the circle image
                backgroundColor: AppColors.primaryColor, // Change the background color
                child: Icon(
                  Icons.circle, // You can use an image here
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 16.0), // Adjust the spacing
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,

                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Row(
            children:[ Container(
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              height: 30.0,
              width: 2,
              color: AppColors.primaryColor, // Color of the vertical line
            ),
    ]
          ),
      ],
    );
  }
}
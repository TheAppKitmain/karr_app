import 'package:flutter/material.dart';
import 'package:kaar/utils/Constants.dart';

class CustomBottomNavigation extends StatefulWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onFabTap;
  final VoidCallback onProfileTap;

  CustomBottomNavigation({
    required this.onHomeTap,
    required this.onFabTap,
    required this.onProfileTap,
  });

  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int selectedIndex = 0; // Store the currently selected index

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80, // Adjust the height as needed
      // Set the background color
      color: Colors.white, // Set the background color
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildNavItem(0, Icons.home, 'Home', widget.onHomeTap),
          FloatingActionButton(

            onPressed: () {

              widget.onFabTap();
            },

            child: Icon(Icons.add),
            backgroundColor:
                 AppColors.primaryColor // Set FAB background color
                // Set a different color when not selected
          ),
          buildNavItem(2, Icons.person, 'Profile', widget.onProfileTap),
        ],
      ),
    );
  }

  Widget buildNavItem(int index, IconData icon, String label, VoidCallback onTap) {
    final isSelected = selectedIndex == index; // Check if this item is selected
    final color = isSelected ? AppColors.primaryColor : Colors.grey; // Define color based on selection

    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index; // Update the selected index
        });
        onTap(); // Call the provided onTap callback
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          Text(label, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectableCard extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final bool selected;
  final Function(bool) onSelected;

  SelectableCard({
    required this.title,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelected(!selected);
      },
      child: Card(
        elevation: 4,
        color: selected ? backgroundColor : Colors.white, // Use the default color here
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              Image.asset(
                'assets/png/one_way.png',
                width: 24,
                height: 24,
                color: selected ? iconColor : Colors.white, // Use the default icon color here
              ),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: selected ? textColor : Colors.black, // Use the default text color here
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

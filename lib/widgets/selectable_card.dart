import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectableCard extends StatelessWidget {
  final String title;
  final String icon;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final bool selected;
  final Function(bool) onSelected;

  SelectableCard({
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final iconSize = width * 0.06; // Adjust as needed
    final fontSize = width * 0.03; // Adjust as needed

    return GestureDetector(
      onTap: () {
        onSelected(!selected);
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.zero,
        color: selected ? backgroundColor : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              // Image.asset(
              //   icon,
              //   width: iconSize,
              //   height: iconSize,
              //   color: selected ? iconColor : Colors.black,
              // ),
              SvgPicture.asset(
                icon ??'assets/svg/ticket.svg',
                semanticsLabel: 'otp logo',
                // height: iconSize,
                // width: iconSize,
                color: selected ? iconColor : Colors.black,
              ),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: fontSize,
                  color: selected ? textColor : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

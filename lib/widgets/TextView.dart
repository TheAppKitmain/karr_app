import 'package:flutter/material.dart';


class TextView extends StatelessWidget {
  final String text;


  final VoidCallback onPressed;

  const TextView({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return   Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        text,
        style:  TextStyle(
          color: Colors.black,
          fontSize: width*0.04,
          fontWeight: FontWeight.normal,
          fontFamily: 'Lato',
        ),
         textAlign:TextAlign.left,
      ),
    );
  }

  }
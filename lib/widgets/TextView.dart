import 'package:flutter/material.dart';


class TextView extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const TextView({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {

    return   Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontFamily: 'Lato',
      ),
       textAlign:TextAlign.left,
    );
  }

  }
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const CustomTextField({
    required this.controller,
    required this.hintText,
    required this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return
      Card(
        elevation: 4, // Adjust the elevation value as needed
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
    ),
     child: TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,

      decoration: InputDecoration(

        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    )
    );
  }
}

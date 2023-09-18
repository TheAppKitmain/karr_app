import 'package:flutter/material.dart';
import 'package:kaar/utils/Constants.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container( width: double.infinity, // Match parent width
      padding: const EdgeInsets.symmetric(vertical:40,horizontal: 30),
    child:TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(

        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Adjust the radius as needed
        ),

      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:10),
        child: Text(

          text,
          style: const TextStyle(
            color: AppColors.backgroundColor,
            fontSize: 16,
            fontFamily: 'latoblack',

          ),

        ),
      )

    ) ,);

  }
}

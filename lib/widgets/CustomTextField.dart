import 'package:flutter/material.dart';

import '../utils/Constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool? obscureText;
  final VoidCallback? onTogglePasswordStatus;


  const CustomTextField({
    required this.controller,
     this.hintText,
    required this.validator,
    this.keyboardType = TextInputType.text, this.obscureText, this.onTogglePasswordStatus,
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
       autofocus: false,
      keyboardType: keyboardType,
      obscureText:obscureText??false,


      decoration: InputDecoration(
        hintText: hintText,

        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        suffixIcon: obscureText != null
            ? IconButton(
          icon: Icon(
              obscureText == true
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: !obscureText!
                  ? AppColors.primaryColor
                  : AppColors.primaryColor.withOpacity(0.2)),
          onPressed: onTogglePasswordStatus,
          color: AppColors.primaryColor.withOpacity(0.2),
        )
            : null,

      ),
       onTapOutside: (v) => FocusManager.instance.primaryFocus?.unfocus(),

    )
    );
  }
}

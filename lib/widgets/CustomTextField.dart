import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/Constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final double? height;
  final String? hintText;
  final Icons? icon;
  final Icons? icon2;
  final String? initialvalue;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool? obscureText;
  final bool? prefixicon;
  final String? prefix;
  final bool? focusKeypad;
  final VoidCallback? onTogglePasswordStatus;
  final VoidCallback? onTap;
  final Function(String?)? onChanged;

  const CustomTextField({
    required this.controller,
    this.hintText,
    this.height,
    this.initialvalue,
    this.prefix,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText,
    this.onTogglePasswordStatus,
    this.onTap,
    this.focusKeypad,
    this.onChanged, this.icon, this.icon2, this.prefixicon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        autofocus: false,
        autocorrect: false,
        onTap: onTap,
        readOnly: focusKeypad ?? false,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Adjust padding as needed
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          prefixText: prefix,
          prefixIcon: prefixicon!=null?IconButton(icon: Icon(Icons.currency_pound,size: 15,), onPressed: () {  },):null,
          suffixIcon: obscureText != null
              ? IconButton(
            icon: Icon(
              obscureText == true ? Icons.visibility_off : Icons.visibility,
              color: !obscureText! ? AppColors.primaryColor : AppColors.primaryColor.withOpacity(0.2),
            ),
            onPressed: onTogglePasswordStatus,
            color: AppColors.primaryColor.withOpacity(0.2),
          )
              : null,
        ),
        onTapOutside: (v) => FocusManager.instance.primaryFocus?.unfocus(),
      ),
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatelessWidget {
  final TextEditingController controller;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final TextInputType textInputType;
  final Function(String) validator;
  final bool obscureText;
  const CustomTextFormFiled(
      {super.key,
      required this.controller,
      this.prefixIcon,
      this.suffixIcon,
      required this.hintText,
      this.textInputType = TextInputType.name,
      required this.validator,
      this.obscureText = false});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: textInputType,
      controller: controller,
      validator: (String? value) {
        return validator(value!);
      },
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: suffixIcon,
          hintStyle: TextStyle(color: Colors.grey.shade600),
          hintText: hintText),
    );
  }
}

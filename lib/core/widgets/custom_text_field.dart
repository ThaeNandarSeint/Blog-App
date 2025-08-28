import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.isObscureText = false,
    this.isReadOnly = false,
    this.onTap,
  });

  final String hintText;
  final TextEditingController? controller;
  final bool isObscureText;
  final bool isReadOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: isReadOnly,
      decoration: InputDecoration(hintText: hintText),
      controller: controller,
      obscureText: isObscureText,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "$hintText is required";
        }
        return null;
      },
    );
  }
}

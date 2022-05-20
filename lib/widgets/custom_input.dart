import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key, 
    required this.icon, 
    required this.hintText, 
    required this.textEditingController, 
    this.keyboardType = TextInputType.text, 
    this.obscureText = false,
  }) : super(key: key);

  final IconData icon;
  final String hintText;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 5.0,
        left: 5.0,
        bottom: 5.0,
        right: 20.0
      ),
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0.0, 5.0),
            blurRadius: 5.0
          )
        ]
      ),
      child: TextField(
        controller: textEditingController,
        autocorrect: false,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
          ),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: hintText
        ),
      ),
    );
  }
}
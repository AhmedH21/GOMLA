import 'package:ecom/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String initialValue;
  final IconData icon;
  final Function onSaved;

  String errorMsg(String value) {
    switch (hint) {
      case "Enter your name":
        return "name not found";
      case "Enter your e-mail":
        return "e-mail not found";
      case "Enter your password":
        return "password not found";
    }
  }

  CustomTextField({
    this.hint,
    this.icon,
    this.onSaved,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(initialValue:initialValue ,
        validator: (value) {
          if (value.isEmpty) {
            return errorMsg(value);
          }
        },
        onSaved: onSaved,
        obscureText: hint == "Enter your password" ? true : false,
        cursorColor: kMainColor,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: Colors.black,
          ),
          filled: true,
          fillColor: Colors.white60,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

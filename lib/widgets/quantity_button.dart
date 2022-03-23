import 'package:flutter/material.dart';

import '../constants.dart';

class QuantityButton extends StatefulWidget {
  final Function press;
  final IconData icon;

  QuantityButton({this.press, this.icon});

  @override
  State<QuantityButton> createState() => _QuantityButtonState();
}

class _QuantityButtonState extends State<QuantityButton> {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: GestureDetector(
        onTap: widget.press,
        child: Container(
          height: 30,
          width: 30,
          color: Colors.red,
          child: Icon(widget.icon,color: Colors.white,),
        ),
      ),
    );
  }
}

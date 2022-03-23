import 'package:ecom/constants.dart';
import 'package:flutter/material.dart';


class DefaultButton extends StatelessWidget {
  const DefaultButton({
     this.width,
     this.text,
     this.press,
  }) ;

  final String text;
  final VoidCallback press;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*width,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.red, // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

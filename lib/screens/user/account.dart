import 'package:ecom/widgets/navigationDrawer.dart';
import 'package:flutter/material.dart';
class AccountScreen extends StatelessWidget {
  static String id = 'AccountScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
backgroundColor: Colors.red,
      ),
      drawer: NavDrawer(),
    );
  }
}

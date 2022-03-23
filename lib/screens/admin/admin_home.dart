import 'package:ecom/constants.dart';
import 'package:ecom/screens/admin/add_product.dart';
import 'package:ecom/screens/admin/manage_product.dart';
import 'package:ecom/screens/admin/view_orders.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  static String id = 'AdminPage';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backGroundImage("adminBG"),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProduct.id);
              },
              child: Text("Add Product"),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, ManageProduct.id);
              },
              child: Text("Manage Products"),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, ViewOrders.id);
              },
              child: Text("View Orders"),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

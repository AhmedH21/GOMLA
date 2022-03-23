import 'package:ecom/screens/auth/login_screen.dart';
import 'package:ecom/screens/user/account.dart';
import 'package:ecom/screens/user/cart_screen.dart';
import 'package:ecom/screens/user/home_page.dart';
import 'package:ecom/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'createDrawerBodyItem.dart';
import 'createDrawerHeader.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Auth _auth = Auth();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerBodyItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () => Navigator.pushReplacementNamed(context, HomePage.id),
          ),
          createDrawerBodyItem(
              icon: Icons.shopping_cart_rounded,
              text: 'Cart',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, CartScreen.id)),

          Divider(),
          createDrawerBodyItem(
              icon: Icons.exit_to_app,
              text: 'Sign Out',
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.clear();
                await _auth.signOut();
                Navigator.popAndPushNamed(context,LoginScreen.id);
              }),

          ListTile(
            title: Text('App version 1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

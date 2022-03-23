import 'package:ecom/constants.dart';
import 'package:ecom/models/product.dart';
import 'package:ecom/screens/user/cart_screen.dart';
import 'package:ecom/services/auth.dart';
import 'package:ecom/services/store.dart';
import 'package:ecom/widgets/createDrawerBodyItem.dart';
import 'package:ecom/widgets/createDrawerHeader.dart';
import 'package:ecom/widgets/navigationDrawer.dart';
import 'package:ecom/widgets/product_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User _loggedUser;

  final _auth = Auth();
  int bottomNavIndex = 0;
  List<Product> _products;

  getCurrentUser() async {
    _loggedUser = await _auth.getUser();
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(title: Text("DISCOVER"),
          actions: [
            IconButton(icon: Icon(Icons.shopping_cart) ,onPressed: (){
              Navigator.pushReplacementNamed(context, CartScreen.id);
            },)
          ],
          centerTitle: true,
          backgroundColor: Colors.red,

          bottom: TabBar(labelColor: Colors.white,unselectedLabelColor: Colors.white54,
            labelPadding: EdgeInsets.zero,
            indicatorColor: Colors.red,
            tabs: [
              Text("men"),
              Text("women"),
              Text("jewelery"),
              Text("electronics"),
            ],
          ),
        ),
        drawer: NavDrawer(),
        body: TabBarView(
          children: [
            productsView(kMensClothing, _products),
            productsView(kWomenClothing, _products),
            productsView(kJewelery, _products),
            productsView(kElectronics, _products),
          ],
        ),

        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: bottomNavIndex,
        //   onTap: (value) async {
        //     setState(() {
        //       bottomNavIndex = value;
        //     });
        //
        //     switch(value){
        //       case 0 :
        //         break;
        //     }
        //     if (value == 2) {
        //       SharedPreferences pref =
        //           await SharedPreferences.getInstance();
        //       pref.clear();
        //       await _auth.signOut();
        //       Navigator.pop(context);
        //     }
        //   },
        //   fixedColor: Colors.green,
        //   unselectedItemColor: Colors.grey,
        //   items: [
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.home_filled), label: 'Home'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.shopping_cart_rounded), label: 'Cart'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.person), label: 'Account'),
        //   ],
        // ),


      ),
    );
  }
}



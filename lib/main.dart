import 'package:ecom/constants.dart';
import 'package:ecom/provider/admin_mode.dart';
import 'package:ecom/provider/cart_item.dart';
import 'package:ecom/provider/modal_hud.dart';
import 'package:ecom/screens/admin/add_product.dart';
import 'package:ecom/screens/admin/admin_home.dart';
import 'package:ecom/screens/admin/manage_product.dart';
import 'package:ecom/screens/admin/view_orders.dart';
import 'package:ecom/screens/user/account.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/admin/edit_product.dart';
import 'screens/admin/order_details.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/user/cart_screen.dart';
import 'screens/user/home_page.dart';
import 'screens/user/product_details.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUserLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text("Loading ..."),
                ),
              ),
            );
          } else {
            isUserLoggedIn = snapshot.data.getBool(kKeepMeLoggedIn) ?? false;
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<ModalHud>(
                  create: (context) => ModalHud(),
                ),
                ChangeNotifierProvider<AdminMode>(
                  create: (context) => AdminMode(),
                ),
                ChangeNotifierProvider<CartItem>(
                  create: (context) => CartItem(),
                ),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: isUserLoggedIn ? HomePage.id : LoginScreen.id,
                routes: {
                  LoginScreen.id: (context) => LoginScreen(),
                  SignUpScreen.id: (context) => SignUpScreen(),
                  HomePage.id: (context) => HomePage(),
                  AdminPage.id: (context) => AdminPage(),
                  AddProduct.id: (context) => AddProduct(),
                  ManageProduct.id: (context) => ManageProduct(),
                  EditProduct.id: (context) => EditProduct(),
                  ViewOrders.id: (context) => ViewOrders(),
                  ProductDetails.id: (context) => ProductDetails(),
                  CartScreen.id: (context) => CartScreen(),
                  OrderDetails.id: (context) => OrderDetails(),
                  AccountScreen.id: (context) => AccountScreen(),

                },
              ),
            );
          }
        });
  }
}

import 'package:flutter/material.dart';

const kMainColor = Color(0xFFFFC12F);
const kSecColor = Color(0xFFFFE6AC);
const kProductName = 'productName';
const kProductPrice = 'productPrice';
const kProductDescription = 'productDescription';
const kProductLocation = 'productLocation';
const kProductCategory = 'productCategory';
const kProductQuantity = 'productQuantity';
const kProductsCollection = 'products';
const kMensClothing = "men's clothing";
const kWomenClothing = 'women\'s clothing';
const kElectronics = 'electronics';
const kJewelery = 'jewelery';
const kOrders = 'Orders';
const kOrderDetails = 'OrderDetails';
const kTotalPrice = 'TotalPrice';
const kAddress = 'Address';
const kKeepMeLoggedIn = 'keepMeLoggedIn';

final BoxDecoration customDecoration = BoxDecoration(
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.grey[300],
      offset: const Offset(
        5.0,
        5.0,
      ),
      blurRadius: 10.0,
      spreadRadius: 2.0,
    ), //BoxShadow
    BoxShadow(
      color: Colors.white,
      offset: const Offset(0.0, 0.0),
      blurRadius: 0.0,
      spreadRadius: 0.0,
    ), //BoxShadow
  ],
  borderRadius: BorderRadius.circular(5),
);

BoxDecoration backGroundImage(image) {
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage("images/$image.jpg"),
      fit: BoxFit.cover,
    ),
  );
}

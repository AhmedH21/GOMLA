import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/product.dart';
import 'package:ecom/screens/user/product_details.dart';
import 'package:ecom/services/store.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

Widget productsView(String category, List<Product> products) {
  Store _store = Store();
  List<Product> _products;
  return StreamBuilder<QuerySnapshot>(
    stream: _store.loadProducts(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Center(
          child: Text('Something went wrong'),
        );
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: Text("Loading..."),
        );
      }
      if (snapshot.hasData) {
        List<Product> products = [];
        for (var doc in snapshot.data.docs) {
          //  var data = doc.data() ??;

          products.add(
            Product(
              pId: doc.id,
              pName: doc.data().toString().contains(kProductName)
                  ? doc.get(kProductName)
                  : '',
              pPrice: doc.data().toString().contains(kProductPrice)
                  ? doc.get(kProductPrice)
                  : '',
              pCategory: doc.data().toString().contains(kProductCategory)
                  ? doc.get(kProductCategory)
                  : '',
              pImgLink: doc.data().toString().contains(kProductLocation)
                  ? doc.get(kProductLocation)
                  : '',
              pDescription: doc.data().toString().contains(kProductDescription)
                  ? doc.get(kProductDescription)
                  : '',
            ),
          );
        }
        _products = [...products];
        products.clear();
        products = getProductByCategory(category, _products);
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: .7),
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProductDetails.id,
                    arguments: products[index]);
              },
              child: Stack(
                children: [
                  products[index].pImgLink.contains('http')
                      ? products[index].pImgLink != null
                          ? Image.network(
                              products[index].pImgLink,
                              height: 250,
                              width: 250,
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            )
                      : Center(
                          child: Text("image not found!"),
                        ),
                  Positioned(
                    bottom: 0,
                    child: Opacity(
                      opacity: .65,
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              products[index].pName != null
                                  ? Text(
                                      products[index].pName,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : "image not found!",
                              Text(
                                '\$ ${products[index].pPrice}',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          itemCount: products.length,
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

List<Product> getProductByCategory(String category, List<Product> allproducts) {
  List<Product> products = [];
  try {
    for (var product in allproducts) {
      if (product.pCategory == category) {
        products.add(product);
      }
    }
  } on Error catch (ex) {
    print(ex);
  }
  return products;
}

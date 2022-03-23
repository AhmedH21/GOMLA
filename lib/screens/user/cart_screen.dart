import 'package:ecom/constants.dart';
import 'package:ecom/models/product.dart';
import 'package:ecom/provider/cart_item.dart';
import 'package:ecom/services/store.dart';
import 'package:ecom/widgets/default_button.dart';
import 'package:ecom/widgets/navigationDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static String id = 'CartScreen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    List<Product> products = Provider.of<CartItem>(context).products;
    return Scaffold(
      drawer: NavDrawer(),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("My Cart"),
        elevation: 0,
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: products.length == 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/emptycart.png'),
                Text(
                  "Cart is Empty !",
                  style: TextStyle(fontSize: 28),
                )
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.delete, color: Colors.white),
                                Text('Move to trash',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                        onDismissed: (direction) {
                          setState(() {
                            products.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("Product has deleted"),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Container(
                            //color: Colors.white,
                            height: screenHeight * .15,
                            decoration: customDecoration,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: screenHeight * .4,
                                  child: Image.network(
                                    products[index].pImgLink,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        products[index].pName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        '\$ ${products[index].pPrice}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    products[index].pQuantity.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepOrange),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                DefaultButton(
                  text: "ORDER",
                  press: () {
                    showCustomDialog(context, products);
                  },
                  width: 1,
                )
              ],
            ),
    );
  }

  void showCustomDialog(BuildContext context, List<Product> products) async {
    var price = getTotalPrice(products);
    var address;
    AlertDialog alertDialog = AlertDialog(
      actions: [
        MaterialButton(
          onPressed: () {
            try {
              /// TODO MAKE THE PRODUCTS ORDER ONE TIME
              ///
              Store _store = Store();
              _store.storeOrders(
                  {kTotalPrice: price, kAddress: address}, products);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Ordered successfully !"),
                ),
              );
            } catch (e) {
              print(e);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.message),
                ),
              );
            }
          },
          child: Text("Confirm"),
        )
      ],
      title: Text("TOTAL PRICE = \$ $price"),
      content: TextField(
        onChanged: (value) {
          address = value;
        },
        decoration: InputDecoration(hintText: "Enter Your Address"),
      ),
    );

    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  getTotalPrice(List<Product> products) {
    var price = 0;
    for (var product in products) {
      price += product.pQuantity * int.parse(product.pPrice);
    }
    return price;
  }
}

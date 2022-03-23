import 'package:ecom/models/product.dart';
import 'package:ecom/provider/cart_item.dart';
import 'package:ecom/widgets/default_button.dart';
import 'package:ecom/widgets/quantity_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static String id = 'ProductDetails';

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * .5,
                child: Image.network(
                  product.pImgLink,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.pName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        height: 5,
                        thickness: .5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            width: MediaQuery.of(context).size.width * .4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        product.pDescription,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          QuantityButton(
                            icon: Icons.add,
                            press: increseQuantity,
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            child: Center(
                              child: Text(
                                quantity.toString(),
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                          QuantityButton(
                            icon: Icons.remove,
                            press: decreseQuntaity,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'PRICE',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '\$ ' + product.pPrice,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  DefaultButton(
                    width: .6,
                    text: "Add to Cart",
                    press: () {
                      addToCart(context, product);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  decreseQuntaity() {
    setState(() {
      if (quantity != 0) quantity--;
    });
  }

  increseQuantity() {
    setState(() {
      quantity++;
    });
  }

  addToCart(context, product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    product.pQuantity = quantity;
    var productsInCart = cartItem.products;
    bool isExist = false;
    for (var productInCart in productsInCart) {
      if (productInCart.pName == product.pName) {
        isExist = true;
        return;
      }
    }
    if (!isExist) {
      cartItem.addProduct(product);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Done ! , Product Added to Cart"),
        ),
      );
    }
  }
}

// for (int i = 0; i < _cartProductModel.length; i++) {
//       if (_cartProductModel[i].productId == cartProductModel.productId) {
//         return;
//       }
//     }
//
//     await dbHelper.insert(cartProductModel);
//     _cartProductModel.add(cartProductModel);
//     _totalPrice +=
//         (double.parse(cartProductModel.price) * cartProductModel.quantity);
//
//     update();

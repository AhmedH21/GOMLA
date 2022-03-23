import 'package:ecom/models/product.dart';
import 'package:ecom/services/store.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';
  final Store store = Store();

  @override
  Widget build(BuildContext context) {
    String docId = ModalRoute.of(context).settings.arguments;
    //double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder(
        stream: store.loadOrderDetails(docId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.docs) {
              products.add(
                Product(
                  pId: doc.id,
                  pName: doc.data().toString().contains(kProductName)
                      ? doc.get(kProductName)
                      : '',
                  pCategory: doc.data().toString().contains(kProductCategory)
                      ? doc.get(kProductCategory)
                      : '',
                  pQuantity: doc.data().toString().contains(kProductQuantity)
                      ? doc.get(kProductQuantity)
                      : '',
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        decoration: customDecoration,
                        height: MediaQuery.of(context).size.height * .15,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Name : ${products[index].pName}" ?? '--'),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Quantity : ${products[index].pQuantity}" ??
                                  '--'),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Category : ${products[index].pCategory}" ??
                                  '--'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // TextButton(
                      //   style: TextButton.styleFrom(
                      //     primary: Colors.white,
                      //     backgroundColor: Colors.green,
                      //   ),
                      //   onPressed: () {
                      //     /// TODO CONFIRM ORDER THEN SEND NOTIFICATION TO THE USER
                      //
                      //   },
                      //   child: Text(
                      //     "Confirm order",
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: 25,
                      // ),
                      // TextButton(
                      //   onPressed: () {
                      //     /// TODO DELETE ORDER
                      //     store.deleteOrder(docId);
                      //   },
                      //   child: Text(
                      //     "Delete order",
                      //   ),
                      //   style: TextButton.styleFrom(
                      //     primary: Colors.white,
                      //     backgroundColor: Colors.red,
                      //   ),
                      // )
                    ],
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: Text("Loading ..."),
            );
          }
        },
      ),
    );
  }
}

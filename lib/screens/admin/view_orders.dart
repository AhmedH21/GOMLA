import 'package:ecom/constants.dart';
import 'package:ecom/models/order.dart';
import 'package:ecom/services/store.dart';
import 'package:flutter/material.dart';

import 'order_details.dart';

class ViewOrders extends StatelessWidget {
  static String id = 'ViewOrders';
  final Store store = Store();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backGroundImage("adminBG"),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text("Orders"),
          centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
        body: StreamBuilder(
          stream: store.loadOrders(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  "Loading ...",
                ),
              );
            } else {
              List<Order> orders = [];
              for (var doc in snapshot.data.docs) {
                orders.add(Order(
                    oId: doc.id,
                    address: doc.data().toString().contains(kAddress)
                        ? doc.get(kAddress)
                        : '',
                    totalPrice: doc.data().toString().contains(kTotalPrice)
                        ? doc.get(kTotalPrice)
                        : ''));
              }
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, OrderDetails.id,
                          arguments: orders[index].oId);
                    },
                    child: Container(
                      decoration: customDecoration,
                      height: MediaQuery.of(context).size.height * .15,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "Total Price : ${orders[index].totalPrice.toString()}" ??
                                    ''),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Address : ${orders[index].address}" ?? ''),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

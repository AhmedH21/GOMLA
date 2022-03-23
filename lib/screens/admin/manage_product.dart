import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/product.dart';
import 'package:ecom/screens/admin/edit_product.dart';
import 'package:ecom/services/store.dart';
import 'package:flutter/material.dart';
import 'package:ecom/constants.dart';

class ManageProduct extends StatefulWidget {
  static String id = 'ManageProduct';

  @override
  State<ManageProduct> createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Products"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: StreamBuilder<QuerySnapshot>(
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
                  pDescription:
                      doc.data().toString().contains(kProductDescription)
                          ? doc.get(kProductDescription)
                          : '',
                ),
              );
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: .7),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    products[index].pImgLink.contains('http')
                        ? Image.network(
                            products[index].pImgLink,
                            height: 250,
                            width: 250,
                          )
                        : Center(
                            child: Text("image not found!"),
                          ),
                    Positioned(
                      bottom: 0,
                      child: Opacity(
                        opacity: .3,
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              products[index].pName != null
                                  ? Text(
                                      products[index].pName,
                                      overflow: TextOverflow.ellipsis,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Positioned(bottom: 0,child: IconButton(icon:Icon(Icons.delete),onPressed:(){
                          _store.deleteProduct(products[index].pId);

                        } ,)),
                        Positioned(bottom: 0,child: IconButton(icon:Icon(Icons.edit),onPressed:(){
                          Navigator.pushNamed(context, EditProduct.id,
                              arguments: products[index]);

                        } ,))
                      ],
                    )


                  ]
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
      ),
    );
  }
}

// class MyPopUpMenuItem<T> extends PopupMenuItem<T> {
//   final Widget child;
//   final Function onClick;
//
//   MyPopUpMenuItem({this.child, this.onClick});
//
//   @override
//   PopupMenuItemState<T, PopupMenuItem<T>> createState() {
//     return MyPopUpMenuItemState();
//   }
// }
//
// class MyPopUpMenuItemState<T, PopUpMenuItem>
//     extends PopupMenuItemState<T, MyPopUpMenuItem<T>> {
//   @override
//   void handleTap() {
//     widget.onClick();
//   }
// }

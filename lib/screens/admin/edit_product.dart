import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/constants.dart';
import 'package:ecom/models/product.dart';
import 'package:ecom/screens/admin/manage_product.dart';
import 'package:ecom/services/store.dart';
import 'package:ecom/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  static String id = 'EditProduct';

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final GlobalKey<FormState> globalKey = GlobalKey();

  final Store store = Store();

  String name, price, description, category, imageLink;

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute
        .of(context)
        .settings
        .arguments;

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.clear),
        backgroundColor: Colors.red,
        title: Text("Edit Product"),
        centerTitle: true,
      ),
      body: Form(
        key: globalKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .2,
              ),
              CustomTextField(
                initialValue: product.pName,
                hint: "Product Name",
                onSaved: (value) {
                  name = value ?? value == product.pName;
                },
              ),
              SizedBox(height: 10),
              CustomTextField(
                initialValue: product.pPrice,
                hint: "Product Price",
                onSaved: (value) {
                  price = value ?? value == product.pPrice;
                },
              ),
              SizedBox(height: 10),
              CustomTextField(
                initialValue: product.pDescription,
                hint: "Product Description",
                onSaved: (value) {
                  description = value ?? value == product.pDescription;
                },
              ),
              SizedBox(height: 10),
              CustomTextField(
                initialValue: product.pCategory,
                hint: "Product Category",
                onSaved: (value) {
                  category = value ?? value == product.pCategory;
                },
              ),
              SizedBox(height: 10),
              CustomTextField(
                initialValue: product.pImgLink,
                hint: "Product image Link",
                onSaved: (value) {
                  imageLink = value ?? value == product.pImgLink;
                },
              ),
              SizedBox(height: 25),
              TextButton(
                onPressed: () {
                  if (globalKey.currentState.validate()) {
                    globalKey.currentState.save();

                    store.editProduct(
                        ({
                          kProductName: name,
                          kProductCategory: category,
                          kProductDescription: description,
                          kProductLocation: imageLink,
                          kProductPrice: price
                        }),
                        product.pId);
                  }
                  Navigator.pushReplacementNamed(context, ManageProduct.id);
                },
                child: Text("Continue"),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // }   Future<void> updateItem({
    //   String pName, pPrice, pDescription, pCategory, pImgLink, docId,
    // }) async {
    //   DocumentReference documentReferencer =
    //   fireStore.collection(kProductsCollection).doc(docId).collection(kProductsCollection).doc(docId);
    //
    //   Map<String, dynamic> data = <String, dynamic>{
    //     kProductName: name,
    //     kProductPrice: price,
    //     kProductDescription: description,
    //     kProductCategory: category,
    //     kProductLocation: imageLink
    //   };
    //
    //   await documentReferencer
    //       .update(data)
    //       .whenComplete(() => print("Note item updated in the database"))
    //       .catchError((e) => print(e));
    // }
  }
}

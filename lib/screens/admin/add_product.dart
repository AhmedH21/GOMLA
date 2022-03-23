import 'package:ecom/models/product.dart';
import 'package:ecom/screens/admin/manage_product.dart';
import 'package:ecom/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:ecom/services/store.dart';

import '../../constants.dart';

class AddProduct extends StatefulWidget {
  static String id = 'AddProduct';

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> globalKey = GlobalKey();

  final Store store = Store();

  String name, price, description, category, imageLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: backGroundImage("adminBG"),

      child: Scaffold(

        backgroundColor: Colors.transparent,
        body: Form(
          key: globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                hint: "Product Name",
                onSaved: (value) {
                  name = value;
                },
              ),
              SizedBox(height: 10),
              CustomTextField(
                hint: "Product Price",
                onSaved: (value) {
                  price = value;
                },
              ),
              SizedBox(height: 10),
              CustomTextField(
                hint: "Product Description",
                onSaved: (value) {
                  description = value;
                },
              ),
              SizedBox(height: 10),
              CustomTextField(
                hint: "Product Category",
                onSaved: (value) {
                  category = value;
                },
              ),
              SizedBox(height: 10),
              CustomTextField(
                hint: "Product image Link",
                onSaved: (value) {
                  imageLocation = value;
                },
              ),
              SizedBox(height: 25),
              TextButton(
                onPressed: () {
                  if (globalKey.currentState.validate()) {
                    globalKey.currentState.save();
                    store.addProduct(
                      Product(
                        pName: name,
                        pPrice: price,
                        pDescription: description,
                        pCategory: category,
                        pImgLink: imageLocation,
                      ),
                    );
                  }
                  Navigator.pushReplacementNamed(context, ManageProduct.id);
                },
                child: Text("Add Product"),
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
  }
}

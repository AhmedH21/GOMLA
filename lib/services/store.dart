import "package:cloud_firestore/cloud_firestore.dart";
import 'package:ecom/constants.dart';
import 'package:ecom/models/product.dart';

class Store {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  addProduct(Product product) async {
    await fireStore.collection(kProductsCollection).add({
      kProductName: product.pName,
      kProductPrice: product.pPrice,
      kProductDescription: product.pDescription,
      kProductCategory: product.pCategory,
      kProductLocation: product.pImgLink
    });
  }

  Stream<QuerySnapshot> loadProducts() {
    return fireStore.collection(kProductsCollection).snapshots();
  }

  deleteProduct(docId) {
    fireStore.collection(kProductsCollection).doc(docId).delete();
  }

  editProduct(data, docId) {
    fireStore
        .collection(kProductsCollection)
        .doc(docId)
        .set(data, SetOptions(merge: true));
  }

  storeOrders(data, List<Product> products) {
    var docRef = fireStore.collection(kOrders).doc();
    docRef.set(data);
    for (var product in products) {
      docRef.collection(kOrderDetails).doc().set({
        kProductName: product.pName,
        kProductPrice: product.pPrice,
        kProductLocation: product.pImgLink,
        kProductQuantity: product.pQuantity,
        kProductCategory: product.pCategory,
      });
    }
  }

  Stream<QuerySnapshot> loadOrders() {
    return fireStore.collection(kOrders).snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails(docId) {
    return fireStore
        .collection(kOrders)
        .doc(docId)
        .collection(kOrderDetails)
        .snapshots();
  }

  CollectionReference orders = FirebaseFirestore.instance.collection(kOrders);


   deleteOrder(docId) {
     orders.doc(docId).delete();
    }
  }


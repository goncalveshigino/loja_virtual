import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:loja_virtual/models/item_size.dart';

import 'product.dart';

class CartProduct extends ChangeNotifier {
  
  CartProduct.fromProduct(this.product) {
    productId = product.id;
    quantity = 1;
    size = product.selectedSize.name;
  }

  CartProduct.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    productId = document.data['pid'] as String;
    quantity = document.data['quantity'] as int;
    size = document.data['size'] as String;

    firestore.document('products/$productId').get()
        .then(
          (doc){
            product = Product.fromDocument(doc);
            notifyListeners();
          }
        
        );
  }

  final Firestore firestore = Firestore.instance;

  Product product;

  String id;

  String productId;
  int quantity;
  String size;

  ItemSize get itemSize {
    if (product == null) return null;
    return product.findSize(size);
  }

  // Preco unitario

  num get unitPrice {
    if (product == null) return null;
    return itemSize?.price ?? 0;
  }

  //Preco total
  num get totalPrice => quantity * unitPrice;

  
  Map<String, dynamic> toCartItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
    };
  }

  bool stackable(Product product) {
    return product.id == productId && product.selectedSize.name == size;
  }

  void increment() {
    quantity++;
    notifyListeners();
  }

  void decrement() {
    quantity--;
    notifyListeners();
  }

  bool get hasStock {
    final size = itemSize;
    if (size == null) return false;
    return size.stock >= quantity;
  }
}

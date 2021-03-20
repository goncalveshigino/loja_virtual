
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/address.dart';
import 'package:loja_virtual/models/cart_manager.dart';

class Order {

  Order.fromCartManager(CartManager cartManager){

    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.user.id;
    address = cartManager.address;

  }

 final Firestore firestore = Firestore.instance;

 

  String orderId;

  List<CartManager> items;

  num price;

  String userId;

  Address address;

  Timestamp date;

}
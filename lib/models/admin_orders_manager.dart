

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/user.dart';

import 'order.dart';

class AdminOrdersManager extends ChangeNotifier {
   
 

  final List<Order> _orders = [];

  User userFilter;
  List<Status> statusFilters = [Status.preparing];

  final Firestore firestore = Firestore.instance;

  StreamSubscription _subscription;

  void updateAdmin({bool adminEnabled}) {
    _orders.clear();

    _subscription?.cancel();

    if (adminEnabled) {
      _listenToOrders();
    }
  }

 // Filtrando pedidos

  List<Order> get filteredOrders {

     List<Order> output = _orders.reversed.toList();

     if(userFilter != null){
       output = output.where((o) => o.userId == userFilter.id).toList();
     }

   return  output = output.where((o) => statusFilters.contains(o.status)).toList();

     
  }

 

  void _listenToOrders() {
    _subscription = firestore .collection('orders').snapshots().listen(
      (event) {
         for(final change in event.documentChanges){
           switch (change.type) {

             case DocumentChangeType.added:
               _orders.add(
                 Order.fromDocument(change.document)
               );
               break;

             case DocumentChangeType.modified:
               final modOrder = _orders.firstWhere((o) => 
                    o.orderId == change.document.documentID);
                  modOrder.updateFromDocument(change.document);
               break;

              case DocumentChangeType.removed:
                  debugPrint('Deu problema sério!!!');
               break;

             default:
           }
         }
      notifyListeners();
    });
  }

  void setUserFilter(User user){
    userFilter = user;
    notifyListeners();
  }

  void setStatusFilter({Status status, bool enabled}){
    if(enabled){
      statusFilters.add(status);
    }else{
      statusFilters.remove(status);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

}
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loja_virtual/common/order/order_product_tile.dart';
import 'package:loja_virtual/models/order/order.dart';

class ConfirmationScreen extends StatelessWidget {

  const ConfirmationScreen(this.order);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: const Text('Pedido Confirmado'),
         centerTitle: true,
       ),
       body: Center(
         child: Card(
           margin: const EdgeInsets.all(16.0),
           child: ListView(
             shrinkWrap: true,
             children: <Widget>[
               Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Text(
                       order.formattedId,
                       style: TextStyle(
                         fontWeight: FontWeight.w600,
                         color: Theme.of(context).primaryColor
                      ),
                     ),

                     Text(
                       'R\$ ${order.price.toStringAsFixed(2)}',
                        style: TextStyle(
                         fontWeight: FontWeight.w600,
                         color: Colors.black,
                         fontSize: 14.0
                      )
                     ),

                   ],
                 ),
               ),

              Column(
                children: order.items.map((e){
                  return OrderProductTile(e);
                }).toList(),
              )
             ],
           ),
         ),
       ),
    );
  }
}
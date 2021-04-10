import 'package:flutter/material.dart';
import 'package:loja_virtual/common/order/order_tile.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/common/custom_drawer/empty_card.dart';
import 'package:loja_virtual/common/custom_drawer/login_card.dart';
import 'package:loja_virtual/models/order/orders_manager.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        centerTitle: true,
      ),
      body: Consumer<OrdersManager>(
        builder: (_, orderManager, __) {
          if (orderManager.user == null) {
            return LoginCard();
          }
          if (orderManager.orders.isEmpty) {
            return EmptyCard(
              title: 'Nunhema compra encontra!',
              iconData: Icons.border_clear,
            );
          }
          return ListView.builder(
              itemCount: orderManager.orders.length,
              itemBuilder: (_, index){
                return OrderTile(

                   orderManager.orders.reversed.toList()[index]
                );
              },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:loja_virtual/Screen/orders/components/order_tile.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/common/custom_drawer/empty_card.dart';
import 'package:loja_virtual/models/admin_orders_manager.dart';
import 'package:provider/provider.dart';

class AdminOrdersScreen  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        centerTitle: true,
      ),
      body: Consumer<AdminOrdersManager>(
        builder: (_, adminOrderManager, __) {
       
          if (adminOrderManager.orders.isEmpty) {
            return EmptyCard(
              title: 'Nunhema compra realizada!',
              iconData: Icons.border_clear,
            );
          }
          return ListView.builder(
              itemCount: adminOrderManager.orders.length,
              itemBuilder: (_, index){
                return OrderTile(

                   adminOrderManager.orders.reversed.toList()[index]
                );
              },
          );
        },
      ),
    );
  }
}
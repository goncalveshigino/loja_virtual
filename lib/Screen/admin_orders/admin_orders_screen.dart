import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';
import 'package:loja_virtual/common/order/order_tile.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/common/custom_drawer/empty_card.dart';
import 'package:loja_virtual/models/order/order.dart';
import 'package:loja_virtual/models/user/admin_orders_manager.dart';

import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AdminOrdersScreen extends StatefulWidget {

  @override
  _AdminOrdersScreenState createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  
  final PanelController panelController = PanelController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Todos os Pedidos'),
        centerTitle: true,
      ),
      body: Consumer<AdminOrdersManager>(
        builder: (_, adminOrderManager, __) {
          final filteredOrders = adminOrderManager.filteredOrders;

          return SlidingUpPanel(
            controller: panelController,
            
            body: Column(
              children: [
                if (adminOrderManager.userFilter != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Pedidos de ${adminOrderManager.userFilter.name}',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 17,
                                color: Colors.white),
                          ),
                        ),
                        CustomIconButton(
                          iconData: Icons.close,
                          color: Colors.white,
                          onTap: () {
                            adminOrderManager.setUserFilter(null);
                          },
                        )
                      ],
                    ),
                  ),
                if (filteredOrders.isEmpty)
                  Expanded(
                    child: EmptyCard(
                      title: 'Nunhema compra realizada!',
                      iconData: Icons.border_clear,
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredOrders.length,
                      itemBuilder: (_, index) {
                        return OrderTile(
                          filteredOrders.toList()[index],
                          showControllers: true,
                        );
                      },
                    ),
                  ),
                  const SizedBox( height: 120.0),
              ],
            ),
            minHeight: 40,
            maxHeight: 240,
            panel: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (panelController.isPanelClosed) {
                      panelController.open();
                    } else {
                      panelController.close();
                    }
                  },

                  child: Container(
                    height: 40,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(
                      'Filtros',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: Status.values.map((s) {
                        return CheckboxListTile(
                          title: Text(Order.getStatusText(s)),
                          dense: true,
                          activeColor: Theme.of(context).primaryColor,
                          value: adminOrderManager.statusFilters.contains(s),
                          onChanged: (v) {
                            
                             adminOrderManager.setStatusFilter(
                               status: s,
                               enabled: v
                             );
                          },
                        );
                      }).toList()),
                )
              ],
            ),
            
          );
        },
      ),
    );
  }
}

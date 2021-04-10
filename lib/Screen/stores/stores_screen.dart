import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/stores/stores_manager.dart';
import 'package:provider/provider.dart';

import 'components/store_card.dart';

class  StoresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
       appBar: AppBar(
         title: const Text('Lojas'),
         centerTitle: true,
       ),
       body: Consumer<StoresManager>(
         builder: (_, storesManager, __){

            if(storesManager.stores.isEmpty){
               return LinearProgressIndicator(
                 valueColor: AlwaysStoppedAnimation(Colors.white),
                 backgroundColor: Colors.transparent,
               );
            }

            return ListView.builder(
              itemCount: storesManager.stores.length,
              itemBuilder: (_, index){
                return StoreCard(storesManager.stores[index]);
              },
            );
         }
      ),
    );
  }
}
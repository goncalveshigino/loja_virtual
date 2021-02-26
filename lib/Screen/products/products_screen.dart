import 'package:flutter/material.dart';
import 'package:loja_virtual/Screen/products/components/product_listTile.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

import 'components/search_dialog.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Consumer<ProductManager>(
          builder: (_,productManager,__){

              if(productManager.search.isEmpty){
                 return const Text('Produtos');
              }else{
                 return LayoutBuilder(
                    builder: (_, constraints){
                       return GestureDetector(
                          onTap: () async{
                              final search = await showDialog<String>( context: context,
                                builder: (_) => SearchDialog(productManager.search));

                              if(search != null){
                                productManager.search = search;
                              }
                          },
                   child: Container(
                     width: constraints.biggest.width ,
                     child: Text(productManager.search, textAlign: TextAlign.center,)
                    ),
                 );
                    },
                 );
              }
          }
        ),
        centerTitle: true,
        actions: <Widget>[
           Consumer<ProductManager>(
             builder: (_,productManager,__){
               
               if(productManager.search.isEmpty){
                  return IconButton(
                    icon: Icon(Icons.search,),
                    onPressed: () async {
                      final search = await showDialog<String>(
                          context: context, builder: (_) => SearchDialog(productManager.search ));
                      if (search != null) {
                        productManager.search = search;
                      }
                    },
                 );
               }else{
                 return IconButton(
                    icon: Icon(Icons.close,),
                    onPressed: ()  {
                      productManager.search = '';
                    },
                 );
               }
             }
           ),
           Consumer<UserManager>(
             builder: (_, userManager, __){
                if(userManager.adminEnabled){
                    return IconButton(
                      icon: Icon(Icons.add),
                      onPressed: (){
                        Navigator.of(context).pushReplacementNamed(
                          '/edit_product',
                     
                        );
                      },
                    );
                } else {
                  return Container();
                }
             }
            ),
        ],
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __) {
          final filteredProducts = productManager.filteredProducts;
          return ListView.builder(
            padding: const EdgeInsets.all(6),
            itemCount: filteredProducts.length,
            itemBuilder: (_, index) {
              return ProductListTile(filteredProducts[index]);
            },
          );
        },
      ),
       floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.shopping_cart, 
          color: Theme.of(context).primaryColor,
          ),
          onPressed: (){
            Navigator.of(context).pushNamed('/cart');
          },
        ),
    );
  }
}

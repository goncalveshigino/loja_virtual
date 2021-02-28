import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/Screen/product/components/size_widget.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class ProductTela extends StatelessWidget {
  

  const ProductTela(this.product);
   final Product product;

  @override
  Widget build(BuildContext context) {
    
    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
         value: product,
          child: Scaffold(
           appBar: AppBar(
           title: Text(product.name),
           centerTitle: true,
           actions: <Widget>[
             Consumer<UserManager>(
               builder: (_, userManager, __){
                  if(userManager.adminEnabled){
                    return IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: (){
                          Navigator.of(context).pushReplacementNamed(
                              '/edit_product',
                             arguments: product
                          );
                      },
                    );
                  }else{
                    return Container();
                  }
               }
              )
           ],
         ),
         backgroundColor: Colors.white,
         body: ListView(
            children: [
              AspectRatio(
                aspectRatio: 1,
                  child: Carousel( //Carousel
                  images: product.images.map((url){
                    return NetworkImage(url);
                  }).toList(),
                  dotSize: 4,
                  dotSpacing: 15,
                  dotBgColor: Colors.transparent,
                  dotColor: Theme.of(context).primaryColor,
                  autoplay: false,
                  
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'A partir de ',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:5.0),
                      child: Text(
                        'Kz\$ ${product.basePrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Text(
                        'Descrição',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                      Text(
                          product.description,
                          style: TextStyle( 
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:16, bottom: 8),
                          child: Text(
                            'Tamanhos',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: product.sizes.map((s){
                         return SizeWidget(size: s);
                      }).toList(),
                    ),
                    const SizedBox( height: 20,),

                    //Se tiver Stock o batao sera exibido
                    if(product.hasStock)
                   Consumer2<UserManager,Product>(
                     builder: (_, userManager, product, __){
                        return  SizedBox(
                          height: 44,
                          child: RaisedButton(
                            onPressed:  product.selectedSize != null ? (){

                            if(userManager.isLoggedIn){
                              context.read<CartManager>().addToCart(product); 
                              Navigator.of(context).pushNamed('/cart');
                            }else{
                              Navigator.of(context).pushNamed('/login');
                            }
                            }: null,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                            color: primaryColor,
                            textColor: Colors.white,
                            child: Text(
                              userManager.isLoggedIn 
                                ? 'Adicionar ao Carrinho'
                                : 'Entre para Comprar',
                                style: const TextStyle(
                                  fontSize: 18
                                ),
                            ),
                          ),
                        );
                     }
                    ) 
                  ],
                )
              )
            ],
         ),
         
      ),
    );
  }
}
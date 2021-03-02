import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loja_virtual/models/home_manager.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/models/section_item.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatelessWidget {

  const ItemTile(this.item);

  final SectionItem item;

  @override
  Widget build(BuildContext context) {

  final homeManager = context.watch<HomeManager>();

    return GestureDetector(

       onTap: (){
         if(item.product != null){

           final product = context.read<ProductManager>()
              .findProductById(item.product);
           
           if(product != null){
             Navigator.of(context).pushNamed('/product', arguments: product);
           }
         }
       },
       onLongPress: homeManager.editing ?(){
           showDialog(
             context: context,
             builder: (_){
               return AlertDialog(
                 title:  const Text('Editar Texto'),
                 actions: <Widget>[
                   FlatButton(
                     onPressed: (){

                     },
                     textColor: Colors.red,
                     child:  const Text('Excluir'),
                   )
                 ],
               );
             }
           );
       }: null,
       child: AspectRatio(
         aspectRatio: 1,
         child: item.image is String 
         ? FadeInImage.memoryNetwork(
           placeholder: kTransparentImage,
           image: item.image as String,
           fit: BoxFit.cover,
         )
         : Image.file(item.image as File, fit: BoxFit.cover,),
      ),
    );
  }
}
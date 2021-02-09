import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/Screen/edit_product/components/ImageSourceSheet.dart';
import 'package:loja_virtual/models/product.dart';

class ImagesForm extends StatelessWidget {

  const ImagesForm(this.product);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: product.images,
      builder: (state){
        return AspectRatio(
          aspectRatio: 1,
          child: Carousel(
            images: state.value.map<Widget>((image){
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[

                    if(image is String)
                        Image.network(image, fit: BoxFit.cover,)
                   else
                       Image.file(image as File, fit:  BoxFit.cover,),
                  //Para alinhar em qualquer posicao
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.remove),
                      color: Colors.red,
                      onPressed: (){
                         state.value.remove(image);
                         state.didChange(state.value);
                      },
                    )
                  )
                ],
              );
            }).toList()..add(
              Container(
                color: Colors.grey[100],
                child: IconButton(
                  icon: Icon(Icons.add_a_photo_outlined),
                  color: Theme.of(context).primaryColor,
                  iconSize: 50,
                  onPressed: (){
                     showModalBottomSheet(
                       context: context,
                       builder: (_) => ImageSourceSheet()
                     );
                  },
                ),
              )
            ),
            dotSize: 4,
            dotSpacing: 15,
            dotBgColor: Colors.transparent,
            dotColor: Theme.of(context).primaryColor,
            autoplay: false,
          ),
        );
      },
    );
  }
}

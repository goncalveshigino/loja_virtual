import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/Screen/edit_product/components/ImageSourceSheet.dart';
import 'package:loja_virtual/models/home/section.dart';
import 'package:loja_virtual/models/home/section_item.dart';
import 'package:provider/provider.dart';


class AddTileWidget extends StatelessWidget {



  
  @override
  Widget build(BuildContext context) {

    final section = context.watch<Section>();

    void onImageSeleted(File file){
        section.addItem(SectionItem(image: file));
        Navigator.of(context).pop();
    }
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: (){

          if(Platform.isAndroid){
             showModalBottomSheet(
               context: context,
               builder: (context) => ImageSourceSheet(onImageSeleted: onImageSeleted),
             );
          }else {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => ImageSourceSheet(onImageSeleted: onImageSeleted)
              );
          }

        },
        child: Container(
          color: Colors.white.withAlpha(30),
          child: Icon(
            Icons.add,
            color: Colors.white
          ),
        ),
      ),
    );
  }
}
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/Screen/edit_product/components/ImageSourceSheet.dart';
import 'package:loja_virtual/models/section.dart';
import 'package:loja_virtual/models/section_item.dart';


class AddTileWidget extends StatelessWidget {

  const AddTileWidget(this.section);
  final Section section;

  
  @override
  Widget build(BuildContext context) {

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
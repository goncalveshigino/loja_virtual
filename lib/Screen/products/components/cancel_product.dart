

import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product.dart';




class CanceLDialogProduct extends StatelessWidget {

const CanceLDialogProduct(this.product);

final Product product;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Eliminar ${product.id}'),
      content: const Text('Esta ação não poderá ser desfeita!'),
      actions: [
        FlatButton(
          onPressed: (){
            product.delete();
            Navigator.of(context).pop();
          },
          textColor: Colors.red,
          child: const Text('Eliminar produto'),
        )
      ],
    );
  }
}
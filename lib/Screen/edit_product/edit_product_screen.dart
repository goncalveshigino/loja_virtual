import 'package:flutter/material.dart';
import 'package:loja_virtual/Screen/edit_product/components/images_form.dart';
import 'package:loja_virtual/models/product.dart';

class EditProductScreen extends StatelessWidget {

  const EditProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Produto'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
           ImagesForm(product)
        ],
      )
    );
  }
}
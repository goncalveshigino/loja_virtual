import 'package:flutter/material.dart';
import 'package:loja_virtual/Screen/edit_product/components/images_form.dart';
import 'package:loja_virtual/models/product.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen(this.product);

  final Product product;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Editar Produto'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              ImagesForm(product),
              RaisedButton(
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    print('Valido');
                  } else {
                    print('Invalido');
                  }
                },
                child: const Text("Salvar"),
              )
            ],
          ),
        ));
  }
}

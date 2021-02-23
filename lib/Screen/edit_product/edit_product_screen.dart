import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loja_virtual/Screen/edit_product/components/images_form.dart';
import 'package:loja_virtual/models/product.dart';

import 'components/sizes_form.dart';

class EditProductScreen extends StatelessWidget {

  EditProductScreen(this.product);

  final Product product;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

   final primaryColor = Theme.of(context).primaryColor;

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

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                   children:<Widget> [

                      TextFormField(
                      initialValue: product.name,
                      decoration:  const InputDecoration(
                        hintText: 'Título',
                        border: InputBorder.none
                      ),

                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600
                      ),

                      validator: (name){
                        if(name.length < 6)
                          return 'Titulo muito curto';
                        return null;
                      },
                    ),

                    Padding(
                      padding:  const EdgeInsets.only(top: 8),
                      child: Text(
                        'A partir de',
                        style:  TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13
                        ),
                      ),
                    ),

                    Text(
                      'R\$ ...',
                      style:  TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: primaryColor
                        )
                     ),

                     Padding(
                       padding: const EdgeInsets.only(top: 16),
                       child: Text(
                         'Descricao',
                         style: TextStyle(
                           fontSize: 16.0,fontWeight: FontWeight.w500
                         ),
                       ),
                     ),

                     TextFormField(
                       initialValue: product.description,
                       style: const TextStyle(
                         fontSize: 16.0
                       ),
                       decoration:  const InputDecoration(
                         hintText: 'Descricao',
                         border: InputBorder.none
                       ),
                       maxLines: null,
                       validator: (desc) {
                          if(desc.length < 10)
                              return 'Descricao muito curta';
                            return null;
                       },
                     ),

                     SizesForm(product),

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
              )
            ],
          ),
        ));
  }
}

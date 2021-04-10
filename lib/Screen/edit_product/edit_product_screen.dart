import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loja_virtual/Screen/edit_product/components/images_form.dart';
import 'package:loja_virtual/models/product/product.dart';
import 'package:loja_virtual/models/product/product_manager.dart';



import 'components/sizes_form.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen(Product p)
      : editing = p != null,
        product = p != null ? p.clone() : Product();

  final Product product;

  final bool editing;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
          appBar: AppBar(
            title: Text(editing ? 'Editar Produto' : 'Criar Produto'),
            centerTitle: true,
            actions: [
               if(editing)
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: (){
                     context.read<ProductManager>().delete(product);
                     Navigator.of(context).pop();
                  },
                )
            ],
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
                    children: <Widget>[
                      TextFormField(
                        initialValue: product.name,
                        decoration: const InputDecoration(
                            hintText: 'Título', border: InputBorder.none
                            ),
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600),
                        validator: (name) {
                          if (name.length < 6) 
                          return 'Titulo muito curto';
                          return null;
                        },
                        onSaved: (name) => product.name = name,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'A partir de',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                      ),
                      Text('R\$ ...',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: primaryColor)),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          'Descricao',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      TextFormField(
                        initialValue: product.description,
                        style: const TextStyle(fontSize: 16),
                        decoration: const InputDecoration(
                            hintText: 'Descricao', border: InputBorder.none),
                        maxLines: null,
                        validator: (desc) {
                          if (desc.length < 10) 
                          return 'Descricao muito curta';
                          return null;
                        },
                        onSaved: (desc) => product.description = desc,
                      ),
                      SizesForm(product),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<Product>(
                        builder: (_, product, __) {
                        return SizedBox(
                          height: 44,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed:  !product.loading ? () async {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();

                               await product.save();

                                context.read<ProductManager>().update(product);

                                Navigator.of(context).pop();
                              } else {
                                print('Invalido');
                              }
                            }: null,
                            textColor: Colors.white,
                            color: primaryColor,
                            disabledColor: primaryColor.withAlpha(100),
                            child: product.loading ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ) : const Text(
                              'Salvar',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}

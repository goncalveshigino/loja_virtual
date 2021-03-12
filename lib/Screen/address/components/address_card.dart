import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:provider/provider.dart';

import 'cep_input_field.dart';

class AddressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric( horizontal: 16,vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Consumer<CartManager>(
              builder: (_, cartManager, __){
                final address = cartManager.address;
                print(address);
                  return Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Endereco de entrega',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          ),
                        ),
                        CepInputField()
                      ],
                    ),
                  );
              }
        ),
      ),
    );
  }
}
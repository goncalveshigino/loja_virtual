import 'package:flutter/material.dart';
import 'package:loja_virtual/Screen/address/components/address_card.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: const Text('Entrega'),
         centerTitle: true,
       ),
       body: ListView(
         children: <Widget>[
            AddressCard()
         ],
       ),
    );
  }
}
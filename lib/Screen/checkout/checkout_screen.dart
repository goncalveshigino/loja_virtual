import 'package:flutter/material.dart';
import 'package:loja_virtual/common/price_card.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          PriceCard(
            buttonText: 'Finalizar Pedido',
            onPressed: (){
              
            },
          )
        ],
      ),
    );
  }
}
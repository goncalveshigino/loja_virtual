import 'package:flutter/material.dart';
import 'package:loja_virtual/models/address.dart';

class ExportAddressDialog extends StatelessWidget {

  const ExportAddressDialog(this.address);

  final Address address;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
       title: const Text('Endereço de entrega'),
       content: Text(
         '${address.street}, ${address.number}, ${address.complement}\n'
         '${address.district}\n'
         '${address.city}/${address.state}\n'
         '${address.zipCode}'
       ),
       contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
       actions: [
         FlatButton(
           onPressed: (){

           },
           child: const Text('Exportar'),
         )
       ],
    );
  }
}
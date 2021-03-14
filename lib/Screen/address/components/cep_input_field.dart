import 'package:brasil_fields/formatter/cep_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';
import 'package:loja_virtual/models/address.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:provider/provider.dart';

class CepInputField extends StatelessWidget {

 CepInputField(this.address);

   final Address address;

   final cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).primaryColor;

   if(address.zipCode == null)

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          TextFormField(
            controller: cepController,
            decoration: InputDecoration(
                isDense: true, labelText: 'CEP', 
                hintText: '12.345-678'),

            inputFormatters: [

              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter()
            ],
            keyboardType: TextInputType.number,
            validator: (cep) {

              if (cep.isEmpty) {
                return 'Campo Obrigatorio';
              } else if (cep.length != 10) {
                return 'CEP invalido';
              } else {
                return null;
              }
            },
        
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            onPressed: () {
              if (Form.of(context).validate()) {   
                context.read<CartManager>().getAddress(cepController.text);
              }

            },
            textColor: Colors.white,
            color: primaryColor,
            disabledColor: primaryColor.withAlpha(100),
            child: Text('Buscar CEP'),
          )
        ],
      );
    else 
     return Padding(
       padding: const EdgeInsets.symmetric(vertical: 4),
       child: Row(
         children: <Widget>[
             Expanded(
               child: Text(
                 'CEP: ${address.zipCode}',
                 style: TextStyle(
                   color: primaryColor,
                   fontWeight: FontWeight.w600
                 ),
               ),
             ),
             CustomIconButton(
               iconData: Icons.edit,
               color: primaryColor,
               onTap: (){
                  context.read<CartManager>().removeAddress();
               },
             )
         ],
       ),
     );
  }
}

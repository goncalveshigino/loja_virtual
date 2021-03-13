import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/models/address.dart';

class AddressInputField extends StatelessWidget {
  const AddressInputField(this.address);

  final Address address;

  @override
  Widget build(BuildContext context) {

    String emptyValidator(String text) =>
        text.isEmpty ? 'Campo obrigatorio' : null;

    return Column(
      children: <Widget>[
        TextFormField(
          initialValue: address.street,
          decoration: const InputDecoration(
              isDense: true,
              labelText: 'Rua/Avenida',
              hintText: 'Deolinda Rodeira',
            ),
            validator: emptyValidator,
          onSaved: (t) => address.street = t,
        ),
        Row(
          children: <Widget>[

            Expanded(
              child: TextFormField(
                initialValue: address.number,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Número',
                  hintText: '123...'
                ),
                inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                validator: emptyValidator,
                onSaved: (t) => address.number = t,
              ),
            ),

            const SizedBox(
              width: 16.0,
            ),

            Expanded(
              child: TextFormField(
                initialValue: address.complement,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Complemento',
                  hintText: 'Opcional'
                ),
                onSaved: (t) => address.complement = t,
              ),
            ),
          ],
        ),

        
      ],
    );
  }
}

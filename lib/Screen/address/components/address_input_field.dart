import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/models/address.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:provider/provider.dart';

class AddressInputField extends StatelessWidget {
  const AddressInputField(this.address);

  final Address address;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    String emptyValidator(String text) =>
        text.isEmpty ? 'Campo obrigatorio' : null;

    if (address.zipCode != null)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      isDense: true, labelText: 'Número', hintText: '123...'),
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
                      hintText: 'Opcional'),
                  onSaved: (t) => address.complement = t,
                ),
              ),
            ],
          ),
          TextFormField(
            initialValue: address.district,
            decoration: const InputDecoration(
              isDense: true,
              labelText: 'Bairro',
              hintText: 'Comercial',
            ),
            validator: emptyValidator,
            onSaved: (t) => address.district = t,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: TextFormField(
                  enabled: false,
                  initialValue: address.city,
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Cidade',
                    hintText: 'Lubango',
                  ),
                  validator: emptyValidator,
                  onSaved: (t) => address.city = t,
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: TextFormField(
                  autocorrect: false,
                  enabled: false,
                  textCapitalization: TextCapitalization.characters,
                  initialValue: address.state,
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'HL',
                    hintText: 'LB',
                    counterText: '',
                  ),
                  maxLength: 2,
                  validator: (e) {
                    if (e.isEmpty) {
                      return 'Campo obrigatorio';
                    } else if (e.length != 2) {
                      return 'Invalido';
                    }
                    return null;
                  },
                  onSaved: (t) => address.city = t,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          RaisedButton(
            color: primaryColor,
            disabledColor: primaryColor.withAlpha(100),
            textColor: Colors.white,
            onPressed: () async {
              if (Form.of(context).validate()) {
                Form.of(context).save();

                try {
                  await context.read<CartManager>().setAddress(address);
                } catch (e) {
                   Scaffold.of(context).showSnackBar(
                     SnackBar(
                       content: Text('$e'),
                       backgroundColor: Colors.red,
                     )
                   );
                }
              }
            },
            child: const Text('Calcular Frete'),
          )
        ],
      );
    else
      return Container();
  }
}

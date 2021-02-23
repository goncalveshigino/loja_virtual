import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';
import 'package:loja_virtual/models/item_size.dart';

class EditItemSize extends StatelessWidget {

  final ItemSize size;

  final VoidCallback onRemove;

  const EditItemSize({this.size, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Row(
       children: <Widget>[

         Expanded(
           flex: 25,
           child: TextFormField(
             initialValue: size.name,
             decoration: const InputDecoration(
               labelText: 'Título',
               isDense: true
             ),
           ),
         ),

         const SizedBox(width: 4,),

         Expanded(
           flex: 25,
           child: TextFormField(
             initialValue: size.stock?.toString(),
             decoration: const InputDecoration(
               labelText: 'Estoque',
               isDense: true,
             ),
             keyboardType: TextInputType.number,
           ),
         ),

         const SizedBox(width: 4,),

         Expanded(
           flex: 50,
           child: TextFormField(
             initialValue: size.price?.toStringAsFixed(2),
             decoration: const InputDecoration(
               labelText: 'Preço',
               isDense: true,
               prefixText: 'R\$',
               prefixStyle: TextStyle(
                 color: Colors.grey,
                 fontWeight: FontWeight.w500
               )
             ),
             keyboardType: const TextInputType.numberWithOptions(decimal: true),
           ),
         ),

         CustomIconButton(
             iconData: Icons.remove,
             color: Colors.red,
             onTap: onRemove,
         ),
         CustomIconButton(
             iconData: Icons.arrow_drop_up,
             color: Colors.black,
         ),
         CustomIconButton(
             iconData: Icons.arrow_drop_down,
             color: Colors.black,
         ),

       ],
    );
  }
}

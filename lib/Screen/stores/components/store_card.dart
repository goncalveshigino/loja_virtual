import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';
import 'package:loja_virtual/models/stores/store.dart';

class StoreCard extends StatelessWidget {


  const StoreCard(this.store);

  final Store store;
  
  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).primaryColor;

    return Card(
       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
       child: Column(
         children: [
           Image.network(store.image),
           Container(
             height: 140,
             padding: const EdgeInsets.all(16),
             child: Row(
               children: [
                 Expanded(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                      Text(
                        store.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 17
                        ),
                      ),
                      Text(
                        store.addressText,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        store.openingText,
                        style: const TextStyle(
                          fontSize: 12
                        ),
                      )
                     ],
                   ),
                 ),
                 Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                      CustomIconButton(
                        iconData: Icons.map,
                        color: primaryColor,
                        onTap: (){

                        },
                      ),
                       CustomIconButton(
                        iconData: Icons.phone,
                        color: primaryColor,
                        onTap: (){

                        },
                      )
                   ],
                 )
               ],
             ),
           )
         ],
       ),
    );
  }
}
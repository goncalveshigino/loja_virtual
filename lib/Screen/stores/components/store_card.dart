import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';
import 'package:loja_virtual/models/stores/store.dart';

class StoreCard extends StatelessWidget {


  const StoreCard(this.store);

  final Store store;
  
  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).primaryColor;

    Color colorForStatus(StoreStatus status){
      switch (status) {
        case StoreStatus.closed:
          return Colors.red;
        case StoreStatus.open:
          return Colors.green;
        case StoreStatus.closing:
          return Colors.orange;
        default:
         return Colors.green;
      }
    }

    return Card(
       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
       clipBehavior: Clip.antiAlias,
       //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
       child: Column(
         children: [
           Container(
             height: 160,
             child: Stack(
               fit: StackFit.expand,
               children: [
                  Image.network(store.image, fit: BoxFit.cover,),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: const BorderRadius.only(
                         bottomLeft: Radius.circular(8)
                       )
                     ),
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        store.statusText,
                        style: TextStyle(
                          color: colorForStatus(store.status),
                          fontWeight: FontWeight.w800,
                          fontSize: 16
                        ),
                      ),
                    ),
                  )
               ],
             ),
           ),
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
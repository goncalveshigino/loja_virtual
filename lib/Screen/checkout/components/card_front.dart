import 'package:flutter/material.dart';

import 'card_text_field.dart';

class CardFront extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 16,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 200,
        color: const Color(0xFF1B4B52),
        padding: EdgeInsets.all(24),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                    CardTextField(
                      title: 'Número',
                      hint: '0000 0000 0000 0000',
                      textInputType: TextInputType.number,
                      bold: true,
                    ),
                     CardTextField(
                      title: 'Validade',
                      hint: '04/2020',
                      textInputType: TextInputType.number,
                    ),
                     CardTextField(
                      title: 'Título',
                      hint: 'Gonçalves Luis Higino',
                      textInputType: TextInputType.text,
                      bold: true,
                    )
                 ],
              ),
            ),
            Stack(
              children: [
                Icon(
                  Icons.credit_card,
                  color: Colors.white,
                  size: 44,
                ),
                Align(
                  alignment: Alignment.topRight,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
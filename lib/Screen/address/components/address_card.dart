import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric( horizontal: 16,vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      ),
    );
  }
}
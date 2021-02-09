import 'package:flutter/material.dart';

class ImageSourceSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: (){},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            FlatButton(
              child: const Text('Camera'),
              onPressed: (){},
            ),

            FlatButton(
              child: const Text('Galeria'),
              onPressed: (){},
            )
          ],

        ),
    );
  }
}

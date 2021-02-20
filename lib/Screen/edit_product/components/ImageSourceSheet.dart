import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {

    ImageSourceSheet({this.onImageSeleted});

  final  Function(File) onImageSeleted;
 
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid)
      return BottomSheet(
        onClosing: () {},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FlatButton(
              child: const Text('Camera'),
              onPressed: () async {
                final PickedFile file =
                    await picker.getImage(source: ImageSource.camera);
               onImageSeleted( File(file.path));
              },
            ),
            FlatButton(
              child: const Text('Galeria'),
              onPressed: () async {
                final PickedFile file =
                    await picker.getImage(source: ImageSource.gallery);
                     onImageSeleted( File(file.path));
              },
            )
          ],
        ),
      );
    else
      return CupertinoActionSheet(
        title: const Text('Selecionar foto para o item'),
        message: const Text('Escolha a origem da foto'),
        cancelButton: CupertinoActionSheetAction(
          onPressed: Navigator.of(context).pop,
          child: const Text("Canccelar"),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {},
            child: const Text('Camera'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text('Galeria '),
          )
        ],
      );
  }
}

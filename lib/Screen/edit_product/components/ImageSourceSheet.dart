import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {

    ImageSourceSheet({this.onImageSeleted});

  final  Function(File) onImageSeleted;
 
  final ImagePicker picker = ImagePicker();


  @override
  Widget build(BuildContext context) {

     //Editar Image apos pegar da galeira ou  capturado pela camera
      Future<void> editImage(String path) async{
       final File croppedFile = await ImageCropper.cropImage(
          sourcePath: path,
          aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
          androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Editar Imagem',
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white
          ),
          iosUiSettings: const IOSUiSettings(
            title: 'Editar Imagem',
            cancelButtonTitle: 'Cancelar',
            doneButtonTitle: 'Concluir'
          )
        );
        //Verificar
        if(croppedFile != null){
          onImageSeleted(croppedFile);
        }
      }


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
                      editImage(file.path);
              },
            ),
            FlatButton(
              child: const Text('Galeria'),
              onPressed: () async {
                final PickedFile file =
                    await picker.getImage(source: ImageSource.gallery);
                 editImage(file.path);
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
         onPressed: () async {
                final PickedFile file =
                    await picker.getImage(source: ImageSource.camera);
                 editImage(file.path);
              },
            child: const Text('Camera'),
          ),
          CupertinoActionSheetAction(
        onPressed: () async {
                final PickedFile file =
                    await picker.getImage(source: ImageSource.gallery);
                 editImage(file.path);
              },
            child: const Text('Galeria '),
          )
        ],
      );
  }
}

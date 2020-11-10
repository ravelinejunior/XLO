import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceModal extends StatelessWidget {
  final Function imageSelecteCallBack;
  ImageSourceModal(this.imageSelecteCallBack);
  File _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid)
      return BottomSheet(
        onClosing: () {},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FlatButton.icon(
              splashColor: Colors.pinkAccent.withAlpha(100),
              onPressed: getFromCamera,
              icon: Icon(Icons.camera, color: Colors.pink),
              label: const Text(
                'Câmera',
                style:
                    TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
              ),
              textColor: Colors.black,
            ),
            Divider(),
            FlatButton.icon(
              splashColor: Colors.pinkAccent.withAlpha(100),
              onPressed: getFromGallery,
              icon: Icon(Icons.camera_roll, color: Colors.pink),
              label: const Text(
                'Galeria',
                style:
                    TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
              ),
              textColor: Colors.black,
            ),
          ],
        ),
      );
    else
      return Card(
        color: Colors.white12,
        child: CupertinoActionSheet(
          title: const Text('Selecione imagem para anúncio'),
          message: const Text('Origem da imagem'),
          cancelButton: CupertinoActionSheetAction(
            onPressed: Navigator.of(context).pop,
            child: Text(
              'Cancelar',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            CupertinoActionSheetAction(
              onPressed: getFromCamera,
              child: const Text('Câmera'),
            ),
            CupertinoActionSheetAction(
              onPressed: getFromGallery,
              child: const Text('Galeria'),
            ),
          ],
        ),
      );
  }

  //funções de recuperação de imagens
  Future<void> getFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    //tratar erro caso usuario nao selecione imagem
    if (pickedFile == null) return;
    _image = File(pickedFile.path);

    //recuperar imagem selecionada
    imageSelected(_image);
  }

  Future<void> getFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    _image = File(pickedFile.path);
    //recuperar imagem selecionada
    imageSelected(_image);
  }

  //recupera imagem apos editada
  Future<void> imageSelected(File image) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio5x3,
      ],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Editar Imagem',
        toolbarColor: Colors.purple,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
        activeControlsWidgetColor: Colors.pink,
        showCropGrid: true,
        hideBottomControls: false,
        statusBarColor: Colors.purple,
      ),
      iosUiSettings: IOSUiSettings(
        title: "Editar Imagem",
        minimumAspectRatio: 1.0,
        resetButtonHidden: true,
        doneButtonTitle: "Done",
        cancelButtonTitle: "Cancel",
        aspectRatioLockEnabled: false,
      ),
    );

    //envia imagem para image field
    if (croppedFile != null) imageSelecteCallBack(croppedFile);
  }
}

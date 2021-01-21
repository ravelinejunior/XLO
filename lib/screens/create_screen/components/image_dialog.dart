import 'dart:io';

import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final dynamic image;
  final VoidCallback onDelete;
  const ImageDialog({this.image, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (image is File)
              Image.file(image, fit: BoxFit.cover)
            else
              Image.network(image),
            FlatButton.icon(
              color: Colors.white,
              splashColor: Colors.red.withAlpha(100),
              shape: StadiumBorder(),
              onPressed: onDelete,
              icon: Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
              label: Text(
                'Deletar Imagem',
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}

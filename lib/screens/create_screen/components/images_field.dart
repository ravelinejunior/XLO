import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:olx_project_parse/screens/create_screen/components/image_dialog.dart';
import 'package:olx_project_parse/screens/create_screen/components/image_source_modal.dart';
import 'package:olx_project_parse/stores/create_store.dart';

class ImagesField extends StatelessWidget {
  final CreateStore createStore;
  const ImagesField(this.createStore);
  @override
  Widget build(BuildContext context) {
    //chamada callback de imagem
    void onImageSelected(File image) {
      Navigator.of(context).pop();
      createStore.images.add(image);
    }

    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 5.5,
          width: MediaQuery.of(context).size.width,
          child: Card(
            color: Colors.grey[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.all(
                Radius.circular(15),
              ),
            ),
            child: Observer(
              builder: (context) => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  if (index == createStore.images.length)
                    return InkWell(
                      enableFeedback: !createStore.loading,
                      splashColor: Colors.orange,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4.0,
                          vertical: 8,
                        ),
                        child: CircleAvatar(
                          radius: 44,
                          backgroundColor: Colors.grey.withAlpha(100),
                          child: Icon(
                            Icons.camera_enhance,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        if (Platform.isAndroid) {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => ImageSourceModal(onImageSelected),
                          );
                        } else if (Platform.isIOS) {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (_) => ImageSourceModal(onImageSelected),
                          );
                        } else {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => ImageSourceModal(onImageSelected),
                          );
                        }
                      },
                    );
                  else
                    return InkWell(
                      splashColor: Colors.orange,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 8,
                        ),
                        child: CircleAvatar(
                          radius: 56,
                          backgroundImage: createStore.images[index] is File
                              ? FileImage(createStore.images[index])
                              : NetworkImage(createStore.images[index]),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ImageDialog(
                            image: createStore.images[index],
                            onDelete: () => showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text('Deseja remover essa imagem?'),
                                titlePadding: const EdgeInsets.all(32),
                                contentPadding: const EdgeInsets.all(16),
                                insetPadding: const EdgeInsets.all(32),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                actionsOverflowDirection:
                                    VerticalDirection.down,
                                actionsPadding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                actions: [
                                  RaisedButton.icon(
                                    icon: Icon(Icons.done, color: Colors.red),
                                    color: Colors.white,
                                    onPressed: () {
                                      createStore.images.removeAt(index);
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                    label: const Text(
                                      'Remover',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  RaisedButton.icon(
                                    icon:
                                        Icon(Icons.cancel, color: Colors.blue),
                                    color: Colors.white,
                                    onPressed: Navigator.of(context).pop,
                                    label: const Text(
                                      'Cancelar',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                },
                itemCount: createStore.images.length < 10
                    ? createStore.images.length + 1
                    : 10,
              ),
            ),
            clipBehavior: Clip.antiAlias,
          ),
        ),

        //tratamento de erro
        Observer(
          builder: (_) {
            if (createStore.imagesError != null)
              return Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.red)),
                ),
                child: Text(
                  createStore.imagesError,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            else
              return Container();
          },
        )
      ],
    );
  }
}

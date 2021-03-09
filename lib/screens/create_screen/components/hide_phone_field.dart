import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:olx_project_parse/stores/create_store.dart';

class HidePhoneField extends StatelessWidget {
  final CreateStore createStore;
  const HidePhoneField({this.createStore});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Observer(builder: (_) {
            return Checkbox(
              value: createStore.hidePhone,
              onChanged: createStore.setHidePhone,
              activeColor: Color.fromARGB(1, 255, 136, 0),
            );
          }),
          Expanded(
            child: Text(
              'Ocultar meu telefone neste anúncio',
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }
}

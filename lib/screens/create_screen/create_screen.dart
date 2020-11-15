import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olx_project_parse/components/custom_drawer/custom_drawer.dart';
import 'package:olx_project_parse/screens/category_screen/components/category_field.dart';
import 'package:olx_project_parse/stores/create_store.dart';

import 'components/cep_field.dart';
import 'components/images_field.dart';

class CreateScreen extends StatelessWidget {
  final CreateStore createStore = CreateStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Anúncio'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 10,
        margin: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            children: [
              //criar widget de imagem
              ImagesField(createStore),
              const SizedBox(height: 24),

              //titulo
              TextFormField(
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  labelText: "Título *",
                  labelStyle: TextStyle(
                    color: Colors.black.withAlpha(100),
                  ),
                  prefixIcon: Icon(Icons.title),
                  isDense: true,
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              //titulo
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  labelText: "Descrição *",
                  labelStyle: TextStyle(
                    color: Colors.black.withAlpha(100),
                  ),
                  prefixIcon: Icon(Icons.description),
                ),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: null,
              ),
              const SizedBox(height: 24),
              //dropdown category
              CategoryField(createStore),
              const SizedBox(height: 24),
              //CEP
              CepField(),

              //preço
              TextFormField(
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  labelText: "Preço *",
                  labelStyle: TextStyle(
                    color: Colors.black.withAlpha(100),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.black.withAlpha(100),
                  ),
                  prefixIcon: Icon(Icons.attach_money),
                  isDense: true,
                  prefixText: "R\$ ",
                  prefixStyle: TextStyle(
                    color: Colors.black.withAlpha(100),
                  ),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  RealInputFormatter(centavos: true),
                ],
              ),
              const SizedBox(height: 500),
            ],
          ),
        ),
      ),
    );
  }
}

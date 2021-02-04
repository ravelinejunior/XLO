import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_project_parse/components/custom_drawer/custom_drawer.dart';
import 'package:olx_project_parse/components/errors/error_box.dart';
import 'package:olx_project_parse/models/ad.dart';
import 'package:olx_project_parse/screens/category_screen/components/category_field.dart';
import 'package:olx_project_parse/screens/create_screen/components/hide_phone_field.dart';
import 'package:olx_project_parse/screens/myAds_screen/my_ads_screen.dart';
import 'package:olx_project_parse/stores/create_store.dart';
import 'package:olx_project_parse/stores/page_store.dart';

import 'components/cep_field.dart';
import 'components/images_field.dart';

class CreateScreen extends StatefulWidget {
  CreateScreen({this.ad});
  final Ad ad;
  @override
  _CreateScreenState createState() => _CreateScreenState(ad);
}

class _CreateScreenState extends State<CreateScreen> {
  //in case there is a ad to edit in create screen
  _CreateScreenState(Ad ad)
      : editing = ad != null,
        createStore = CreateStore(ad ?? Ad());
  final CreateStore createStore;
  bool editing;

  @override
  void initState() {
    super.initState();

//só é trigado uma vez
    when((_) => createStore.savedAd != null && createStore.savedAd, () {
      if (editing)
        Navigator.of(context)
            .pop(true); // true to indicate that the ad was saved
      else {
        GetIt.I<PageStore>().setPage(0);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyAdsScreen(initialPage: 0),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        GetIt.I<PageStore>().setPage(0);
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: editing
              ? const Text('Editar Anúncio')
              : const Text('Criar Anúncio'),
          centerTitle: true,
        ),
        drawer: editing ? null : CustomDrawer(),
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 10,
              margin: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Observer(
                  builder: (_) {
                    if (!createStore.loading)
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          //criar widget de imagem
                          ImagesField(createStore),
                          const SizedBox(height: 24),

                          //titulo
                          Observer(builder: (_) {
                            return TextFormField(
                              enabled: !createStore.loading,
                              initialValue: createStore.title,
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
                                errorText: createStore.titleError,
                                prefixIcon: Icon(Icons.title),
                                isDense: true,
                              ),
                              maxLengthEnforced: true,
                              maxLength: 45,
                              onChanged: createStore.setTitle,
                              keyboardType: TextInputType.text,
                            );
                          }),
                          const SizedBox(height: 24),
                          //description
                          Observer(builder: (_) {
                            return TextFormField(
                              enabled: !createStore.loading,
                              initialValue: createStore.description,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                contentPadding: const EdgeInsets.all(16),
                                labelText: "Descrição *",
                                labelStyle: TextStyle(
                                  color: Colors.black.withAlpha(100),
                                ),
                                errorText: createStore.descriptionError,
                                prefixIcon: Icon(Icons.description),
                              ),
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              onChanged: createStore.setDescription,
                              maxLines: null,
                            );
                          }),
                          const SizedBox(height: 24),
                          //dropdown category
                          CategoryField(createStore),
                          const SizedBox(height: 24),
                          //CEP
                          CepField(createStore),

                          //preço
                          Observer(builder: (_) {
                            return TextFormField(
                              enabled: !createStore.loading,
                              initialValue: createStore.priceText,
                              onChanged: createStore.setPrice,
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
                                errorText: createStore.priceError,
                                prefixIcon: Icon(Icons.attach_money),
                                isDense: true,
                                prefixText: "R\$ ",
                                prefixStyle: TextStyle(
                                  color: Colors.black.withAlpha(100),
                                ),
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                RealInputFormatter(centavos: true),
                              ],
                            );
                          }),
                          Divider(),
                          HidePhoneField(createStore: createStore),
                          if (createStore.showErrorBox)
                            Observer(
                              builder: (_) {
                                return ErrorBox(
                                  message: createStore.error,
                                );
                              },
                            ),
                          if (createStore.showErrorBox)
                            const SizedBox(height: 16),

                          Observer(
                            builder: (_) {
                              if (!createStore.loading)
                                return SizedBox(
                                  height: 56,
                                  child: GestureDetector(
                                    onTap: createStore.setInvalidSendPressed,
                                    child: RaisedButton.icon(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      onPressed: createStore.sendPressedValid,
                                      icon: Icon(Icons.done),
                                      label: Text(
                                        'Enviar',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      color: Colors.orange,
                                      textColor: Colors.white,
                                      splashColor: Colors.amber,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      disabledColor:
                                          Colors.orangeAccent.withAlpha(100),
                                      disabledElevation: 10,
                                      disabledTextColor:
                                          Colors.black.withAlpha(100),
                                    ),
                                  ),
                                );
                              else
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.pink),
                                    strokeWidth: 4,
                                  ),
                                );
                            },
                          ),

                          const SizedBox(height: 250),
                        ],
                      );
                    else
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'Salvando anúncio',
                              style:
                                  TextStyle(color: Colors.purple, fontSize: 18),
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.pink),
                              ),
                            ),
                          ],
                        ),
                      );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

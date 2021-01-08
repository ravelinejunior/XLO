import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_project_parse/screens/filter_screen/components/orderByField.dart';
import 'package:olx_project_parse/screens/filter_screen/components/price_range_field.dart';
import 'package:olx_project_parse/screens/filter_screen/components/vendor_type_field.dart';
import 'package:olx_project_parse/stores/home_store.dart';

class FilterScreen extends StatelessWidget {
  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();

  final filterStore = GetIt.I<HomeStore>().clonedFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtrar Busca'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.fromLTRB(16, 12, 16, 32),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 10,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 16, left: 8, right: 8),
                    child: Text(
                      'Localização',
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      labelText: "Estado",
                      labelStyle: TextStyle(
                        color: Colors.black.withAlpha(100),
                      ),
                      suffixIcon:
                          Icon(Icons.keyboard_arrow_down, color: Colors.purple),
                      isDense: true,
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: focusNode1,
                    onFieldSubmitted: (value) => focusNode2.requestFocus(),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      labelText: "Cidade",
                      labelStyle: TextStyle(
                        color: Colors.black.withAlpha(100),
                      ),
                      suffixIcon:
                          Icon(Icons.keyboard_arrow_down, color: Colors.purple),
                      isDense: true,
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    focusNode: focusNode2,
                    onTap: () => focusNode2.unfocus(),
                  ),
                  const SizedBox(height: 8),
                  Divider(),
                  OrderByField(filterStore),
                  const SizedBox(height: 4),
                  Divider(),
                  PriceRangeField(filterStore),
                  const SizedBox(height: 4),
                  Divider(),
                  VendorTypeField(filterStore),
                  const SizedBox(height: 36),
                  Observer(
                    builder: (_) {
                      return Container(
                        height: MediaQuery.of(context).size.height / 15,
                        child: RaisedButton(
                          color: Colors.deepOrangeAccent,
                          shape: StadiumBorder(),
                          disabledColor: Colors.orangeAccent.withAlpha(100),
                          disabledTextColor: Colors.grey.withAlpha(200),
                          splashColor: Colors.orange.withAlpha(200),
                          onPressed: filterStore.isFormValid
                              ? () {
                                  filterStore.save();
                                  Navigator.of(context).pop();
                                }
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Filtrar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

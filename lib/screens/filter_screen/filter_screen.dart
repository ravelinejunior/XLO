import 'package:flutter/material.dart';
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

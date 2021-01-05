import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:olx_project_parse/screens/category_screen/category_screen.dart';
import 'package:olx_project_parse/stores/create_store.dart';

class CategoryField extends StatelessWidget {
  final CreateStore createStore;
  const CategoryField(this.createStore);
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(30)),
        child: Observer(
          builder: (_) {
            return Column(
              children: [
                ListTile(
                  enabled: !createStore.loading,
                  title: createStore.category == null
                      ? Text(
                          'Categoria *',
                          style: TextStyle(
                            color: Colors.black.withAlpha(100),
                          ),
                          textAlign: TextAlign.start,
                        )
                      : Text(
                          'Categoria *',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: () async {
                    final category = await showDialog(
                      context: context,
                      builder: (_) => CategoryScreen(
                        categorySelected: createStore.category,
                        showAll: false,
                      ),
                    );

                    if (category != null) createStore.setCategory(category);
                  },
                  leading: Icon(Icons.category),
                  subtitle: createStore.category != null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            createStore.category.description,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : null,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),

                //tratamento de erro
                if (createStore.categoryError != null)
                  Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.red)),
                    ),
                    child: Text(
                      createStore.categoryError,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_project_parse/components/errors/error_box.dart';
import 'package:olx_project_parse/models/category.dart';
import 'package:olx_project_parse/stores/category_store.dart';

class CategoryScreen extends StatelessWidget {
  //receber categoria selecionada
  final Category categorySelected;
  final bool showAll;

  final CategoryStore categoryStore = GetIt.I<CategoryStore>();

  CategoryScreen({this.showAll = true, this.categorySelected});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.fromLTRB(32, 12, 32, 32),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 10,
          child: Observer(
            builder: (_) {
              if (categoryStore.error != null)
                return ErrorBox(
                  message: categoryStore.error,
                );
              else if (categoryStore.categoryList.isEmpty)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else {
                final categories = showAll
                    ? categoryStore.allCategoryList
                    : categoryStore.categoryList;

                return ListView.separated(
                  itemBuilder: (_, index) {
                    final category = categories[index];
                    return InkWell(
                      splashColor: Colors.purple.withAlpha(150),
                      onTap: () {
                        Navigator.of(context).pop(category);
                      },
                      child: Container(
                        color: category.id == categorySelected?.id
                            ? Colors.purple.withAlpha(50)
                            : null,
                        alignment: Alignment.center,
                        height: 56,
                        child: Text(
                          category.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: category.id == categorySelected?.id
                                ? FontWeight.bold
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, index) {
                    return Divider(
                      height: 0.1,
                    );
                  },
                  itemCount: categories.length,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_project_parse/screens/category_screen/category_screen.dart';
import 'package:olx_project_parse/screens/filter_screen/filter_screen.dart';
import 'package:olx_project_parse/screens/home_screen/components/bar_button.dart';
import 'package:olx_project_parse/stores/home_store.dart';

class TopBar extends StatelessWidget {
  final HomeStore homeStore = GetIt.I<HomeStore>();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Observer(
          builder: (context) {
            return BarButton(
              label: homeStore.categorySelected?.description ?? 'Categorias',
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[300].withAlpha(100),
                  ),
                  top: BorderSide(
                    color: Colors.grey[300].withAlpha(100),
                  ),
                  right: BorderSide(
                    color: Colors.grey[300].withAlpha(100),
                  ),
                ),
              ),
              onTap: () async {
                final category =
                    await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CategoryScreen(
                    showAll: true,
                    categorySelected: homeStore.categorySelected,
                  ),
                ));
                if (category != null) homeStore.setCategory(category);
              },
              splashColor: Colors.pink[200],
            );
          },
        ),
        BarButton(
          label: 'Filtros',
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Colors.grey[300].withAlpha(100),
              ),
              bottom: BorderSide(
                color: Colors.grey[300].withAlpha(100),
              ),
              top: BorderSide(
                color: Colors.grey[300].withAlpha(100),
              ),
              right: BorderSide(
                color: Colors.grey[300].withAlpha(100),
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (__) => FilterScreen(),
              ),
            );
          },
          splashColor: Colors.red.withAlpha(200),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_project_parse/components/custom_drawer/custom_drawer.dart';
import 'package:olx_project_parse/components/errors/empty_screen.dart';
import 'package:olx_project_parse/stores/favorite_store.dart';
import 'package:olx_project_parse/stores/home_store.dart';
import 'package:olx_project_parse/stores/page_store.dart';

import 'components/favorite_tile.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({this.hideDrawer = false});

  final bool hideDrawer;

  final FavoriteStore favoriteStore = GetIt.I<FavoriteStore>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        GetIt.I<PageStore>().setPage(0);
        GetIt.I<HomeStore>().setSearch('');

        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Favoritos'),
          centerTitle: true,
        ),
        drawer: hideDrawer ? null : CustomDrawer(),
        body: Observer(builder: (_) {
          if (favoriteStore.favoriteList.isEmpty)
            return EmptyCard('Nenhum anúncio favoritado.');

          return ListView.builder(
            padding: const EdgeInsets.all(2),
            itemCount: favoriteStore.favoriteList.length,
            itemBuilder: (_, index) =>
                FavoriteTile(favoriteStore.favoriteList[index]),
          );
        }),
      ),
    );
  }
}

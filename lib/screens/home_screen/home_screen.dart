import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_project_parse/components/custom_drawer/custom_drawer.dart';

import 'package:olx_project_parse/screens/home_screen/components/ad_tile.dart';
import 'package:olx_project_parse/screens/home_screen/components/topbar.dart';
import 'package:olx_project_parse/stores/home_store.dart';

import 'components/search_dialog.dart';

class HomeScreen extends StatelessWidget {
  final HomeStore homeStore = GetIt.I<HomeStore>();

  openSearch(BuildContext context) async {
    //getting text from search dialog
    final search = await showDialog(
        context: context,
        builder: (_) => SearchDialog(currentSearch: homeStore.search));
    if (search != null) homeStore.setSearch(search);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Observer(
            builder: (_) {
              if (homeStore.search.isEmpty || homeStore.search == null) {
                return Text('Home');
              } else
                return InkWell(
                  splashColor: Colors.orange,
                  onTap: () => openSearch(context),
                  child: LayoutBuilder(
                    builder: (_, constraints) {
                      return Container(
                        width: constraints.biggest.width,
                        child: Text(
                          homeStore.search,
                          textAlign: TextAlign.start,
                        ),
                      );
                    },
                  ),
                );
            },
          ),
          centerTitle: true,
          actions: [
            Observer(builder: (_) {
              if (homeStore.search.isEmpty)
                return IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    openSearch(context);
                  },
                );
              else
                return IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    homeStore.setSearch('');
                  },
                );
            })
          ],
        ),
        drawer: CustomDrawer(),
        body: Column(
          children: [
            TopBar(),
            Expanded(
              child: Observer(
                builder: (_) {
                  if (homeStore.error != null)
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, color: Colors.white, size: 100),
                        const SizedBox(height: 8),
                        Text(
                          'Ocorreu um erro! Tente novamente. ${homeStore.error}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    );
                  else if (homeStore.loading)
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  else if (homeStore.adList.isEmpty)
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.searchMinus,
                            color: Colors.white, size: 100),
                        const SizedBox(height: 8),
                        Text(
                          'Ora ora, parece que a busca não foi encontrada. Tente novamente!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    );
                  else
                    return ListView.builder(
                      itemCount: homeStore.adList.length,
                      itemBuilder: (context, index) {
                        return AdTile(adItem: homeStore.adList[index]);
                      },
                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

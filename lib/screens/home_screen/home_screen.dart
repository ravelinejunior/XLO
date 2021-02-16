import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_project_parse/components/custom_drawer/custom_drawer.dart';

import 'package:olx_project_parse/screens/home_screen/components/ad_tile.dart';
import 'package:olx_project_parse/screens/home_screen/components/topbar.dart';
import 'package:olx_project_parse/stores/home_store.dart';

import 'components/create_ad_button.dart';
import 'components/search_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeStore homeStore = GetIt.I<HomeStore>();
  bool finishApp = true;
  final ScrollController scrollController = ScrollController();

  openSearch(BuildContext context) async {
    //getting text from search dialog
    final search = await showDialog(
        context: context,
        builder: (_) => SearchDialog(currentSearch: homeStore.search));
    if (search != null) homeStore.setSearch(search);
  }

  Future<void> refreshList() async {
    await Future.delayed(Duration(seconds: 2)).then((_) {
      homeStore.setSearch('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Sair'),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            content: Text('Encontrou o que procurava?\nDeseja sair do app?'),
            buttonPadding: const EdgeInsets.all(8),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            actions: [
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: Colors.lightBlue,
                icon: Icon(
                  Icons.close_sharp,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  finishApp = false;
                },
                label: Text(
                  'Não',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: Colors.red,
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  Navigator.of(context).pop();
                  finishApp = true;
                },
                label: Text('Sim'),
              ),
            ],
          ),
        );
        return finishApp;
      },
      child: SafeArea(
        top: false,
        child: RefreshIndicator(
          onRefresh: refreshList,
          backgroundColor: Colors.white,
          color: Colors.purple,
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
                  child: Stack(
                    children: [
                      Observer(
                        builder: (_) {
                          if (homeStore.error != null)
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.error,
                                    color: Colors.white, size: 100),
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
                          else if (homeStore.showProgress)
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
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
                              controller: scrollController,
                              itemCount: homeStore.itemCount,
                              itemBuilder: (context, index) {
                                if (index < homeStore.adList.length)
                                  return AdTile(
                                      adItem: homeStore.adList[index]);
                                else
                                  homeStore.loadNextPage();
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                      strokeWidth: 4,
                                    ),
                                  ),
                                );
                              },
                            );
                        },
                      ),
                      Positioned(
                        child: CreateAdButton(scrollController),
                        bottom: -60,
                        left: 0,
                        right: 0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

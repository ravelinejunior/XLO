import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:olx_project_parse/components/errors/error_box.dart';
import 'package:olx_project_parse/stores/myads_store.dart';

import 'components/active_tile.dart';
import 'components/pending_tile.dart';
import 'components/sold_tile.dart';

class MyAdsScreen extends StatefulWidget {
  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  final myAdsStore = MyAdsStore();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Anúncios'),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(child: Text('ATIVOS')),
            Tab(child: Text('PENDENTES')),
            Tab(child: Text('VENDIDOS')),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Observer(builder: (_) {
            if (myAdsStore.activeAds.isEmpty)
              return ErrorBox(
                message: "Não há nenhum produto ativo.",
              );
            else
              return ListView.builder(
                itemBuilder: (_, index) {
                  return ActiveTile(myAdsStore.activeAds[index]);
                },
                itemCount: myAdsStore.activeAds.length,
              );
          }),
          Observer(builder: (_) {
            if (myAdsStore.pendingAds.isEmpty)
              return ErrorBox(
                message: "Não há nenhum produto pendente.",
              );
            else
              return ListView.builder(
                itemBuilder: (_, index) {
                  return PendingTile(myAdsStore.pendingAds[index]);
                },
                itemCount: myAdsStore.pendingAds.length,
              );
          }),
          Observer(builder: (_) {
            if (myAdsStore.soldAds.isEmpty)
              return ErrorBox(
                message: "Não há nenhum produto vendido.",
              );
            else
              return ListView.builder(
                itemBuilder: (_, index) {
                  return SoldTile(myAdsStore.soldAds[index]);
                },
                itemCount: myAdsStore.soldAds.length,
              );
          }),
        ],
      ),
    );
  }
}

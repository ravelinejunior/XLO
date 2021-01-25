import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_project_parse/screens/account_screen/account_screen.dart';
import 'package:olx_project_parse/screens/create_screen/create_screen.dart';
import 'package:olx_project_parse/screens/favorite_screen/favorite_screen.dart';
import 'package:olx_project_parse/screens/home_screen/home_screen.dart';
import 'package:olx_project_parse/screens/offline_screen/offline_screen.dart';
import 'package:olx_project_parse/stores/connectivity_store.dart';
import 'package:olx_project_parse/stores/page_store.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();
  final PageStore pageStore = GetIt.I<PageStore>();
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  @override
  void initState() {
    super.initState();
    reaction((_) => pageStore.page, (page) => pageController.jumpToPage(page));

    autorun((_) {
      print('conexão: {$connectivityStore.connected}');
      if (!connectivityStore.connected) {
        Future.delayed(Duration(milliseconds: 50)).then((value) {
          showDialog(
            context: context,
            builder: (context) => OfflineScreen(),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        pageSnapping: mounted,
        dragStartBehavior: DragStartBehavior.start,
        children: [
          HomeScreen(),
          CreateScreen(),
          Container(color: Colors.red.withAlpha(300)),
          FavoritesScreen(),
          AccountScreen(),
          Container(color: Colors.redAccent.withAlpha(300)),
        ],
      ),
    );
  }
}

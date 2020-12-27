import 'package:flutter/material.dart';
import 'package:olx_project_parse/components/custom_drawer/custom_drawer.dart';

import 'components/search_dialog.dart';

class HomeScreen extends StatelessWidget {
  openSearch(BuildContext context) async {
    //getting text from search dialog
    final search =
        await showDialog(context: context, builder: (_) => SearchDialog());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                openSearch(context);
              },
            )
          ],
        ),
        drawer: CustomDrawer(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_project_parse/components/custom_drawer/page_section.dart';
import 'package:olx_project_parse/managers/user_manager/user_manager_store.dart';

import 'custom_drawer_header.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(60)),
        child: SizedBox(
          //80% da tela
          width: MediaQuery.of(context).size.width * 0.8,
          child: Drawer(
            child: ListView(
              children: [
                CustomDrawerHeader(),
                PageSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

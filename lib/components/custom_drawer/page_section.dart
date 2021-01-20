import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_project_parse/components/custom_drawer/page_tile.dart';
import 'package:olx_project_parse/managers/user_manager/user_manager_store.dart';
import 'package:olx_project_parse/screens/login_screen/login_screen.dart';
import 'package:olx_project_parse/screens/signup_screen/signup_screen.dart';
import 'package:olx_project_parse/stores/page_store.dart';

class PageSection extends StatelessWidget {
  final PageStore pageStore = GetIt.I<PageStore>();
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageTile(
          label: "Anúncios",
          iconData: Icons.list,
          onTap: () {
            pageStore.setPage(0);
          },
          highlighted: pageStore.page == 0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Divider(
            color: Colors.grey,
          ),
        ),
        if (userManagerStore.isLoggedIn)
          PageTile(
            label: "Inserir Anúncio",
            iconData: Icons.add,
            onTap: () {
              pageStore.setPage(1);
            },
            highlighted: pageStore.page == 1,
          ),
        if (userManagerStore.isLoggedIn)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Divider(
              color: Colors.grey,
            ),
          ),
        if (userManagerStore.isLoggedIn)
          PageTile(
            label: "Chat",
            iconData: Icons.chat,
            onTap: () {
              //pageStore.setPage(2);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => SignupScreen(),
              ));
            },
            highlighted: pageStore.page == 2,
          ),
        if (userManagerStore.isLoggedIn)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Divider(
              color: Colors.grey,
            ),
          ),
        if (userManagerStore.isLoggedIn)
          PageTile(
            label: "Favoritos",
            iconData: Icons.favorite,
            onTap: () {
              // pageStore.setPage(3);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => LoginScreen(),
              ));
            },
            highlighted: pageStore.page == 3,
          ),
        if (userManagerStore.isLoggedIn)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Divider(
              color: Colors.grey,
            ),
          ),
        if (userManagerStore.isLoggedIn)
          PageTile(
            label: "Minha Conta",
            iconData: Icons.person_pin,
            onTap: () {
              pageStore.setPage(4);
            },
            highlighted: pageStore.page == 4,
          ),
        if (userManagerStore.isLoggedIn)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Divider(
              color: Colors.grey,
            ),
          ),
        PageTile(
          label: "IA Machine Learning Kit",
          iconData: Icons.contact_mail,
          onTap: () {
            pageStore.setPage(5);
          },
          highlighted: pageStore.page == 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Divider(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

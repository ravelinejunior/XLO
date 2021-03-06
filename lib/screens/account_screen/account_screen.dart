import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_project_parse/components/custom_drawer/custom_drawer.dart';
import 'package:olx_project_parse/managers/user_manager/user_manager_store.dart';
import 'package:olx_project_parse/screens/myAds_screen/my_ads_screen.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Conta'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 4,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            GetIt.I<UserManagerStore>().user.name,
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            GetIt.I<UserManagerStore>().user.email,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: (FlatButton.icon(
                        splashColor: Colors.red.withAlpha(150),
                        icon: Icon(
                          Icons.edit,
                          color: Colors.purple[700],
                        ),
                        shape: StadiumBorder(),
                        onPressed: () {},
                        label: Text(
                          'EDITAR',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.purple[700],
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
              const Divider(
                endIndent: 8,
                indent: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: Text(
                    'Meus Anúncios',
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => MyAdsScreen(),
                    ));
                  },
                ),
              ),
              const Divider(
                endIndent: 8,
                indent: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: Text(
                    'Favoritos',
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

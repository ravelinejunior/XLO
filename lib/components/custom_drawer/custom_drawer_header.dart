import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_project_parse/managers/user_manager/user_manager_store.dart';
import 'package:olx_project_parse/screens/login_screen/login_screen.dart';
import 'package:olx_project_parse/stores/page_store.dart';

class CustomDrawerHeader extends StatelessWidget {
  //acessando usuario de instancia logado
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      curve: Curves.bounceInOut,
      decoration: BoxDecoration(
        color: Colors.purple,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.purpleAccent,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 36,
            ),
          ),
          const SizedBox(width: 20),
          //coluna informartiva user
          Expanded(
            child: InkWell(
              splashColor: Colors.deepPurple,
              onTap: () => {
                //fechar drawer
                Navigator.of(context).pop(),
                if (userManagerStore.isLoggedIn)
                  {
                    GetIt.I<PageStore>().setPage(4),
                  }
                else
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => LoginScreen(),
                    ),
                  )
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userManagerStore.isLoggedIn
                        ? userManagerStore.user.name
                        : "Acesse sua conta !",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                  ),
                  Divider(color: Colors.white),
                  Text(
                    userManagerStore.isLoggedIn
                        ? userManagerStore.user.email
                        : "Clique aqui !!! ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.fade,
                  ),
                  if (userManagerStore.isLoggedIn) const SizedBox(height: 16),
                  if (userManagerStore.isLoggedIn)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        elevation: 10,
                        splashColor: Colors.pink[300],
                        onPressed: () {},
                        child: Text(
                          'Logout',
                          style: TextStyle(fontSize: 12),
                        ),
                        color: Colors.pinkAccent,
                        shape: StadiumBorder(),
                        textColor: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

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
        color: Color.fromRGBO(238, 137, 89, 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Color.fromRGBO(238, 137, 89, 1),
            child: Icon(
              Icons.person,
              color: Colors.black,
              size: 36,
            ),
          ),
          const SizedBox(width: 20),
          //coluna informartiva user
          Expanded(
            child: InkWell(
              splashColor: Colors.deepOrangeAccent,
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
                  Container(
                    margin: const EdgeInsets.only(top: 32.0),
                    child: Text(
                      userManagerStore.isLoggedIn
                          ? userManagerStore.user.name
                          : "Acesse sua conta !",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Divider(
                    color: Colors.black87,
                    height: 30,
                  ),
                  Text(
                    userManagerStore.isLoggedIn
                        ? userManagerStore.user.email
                        : "Clique aqui !!! ",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.fade,
                  ),
                  if (userManagerStore.isLoggedIn) const SizedBox(height: 16),
                  if (userManagerStore.isLoggedIn)
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 10,
                        child: RaisedButton(
                          elevation: 10,
                          splashColor: Colors.orangeAccent[300],
                          onPressed: () {
                            userManagerStore.userLogout();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Logout',
                            style: TextStyle(fontSize: 12),
                          ),
                          color: Colors.deepOrange,
                          shape: StadiumBorder(),
                          textColor: Colors.black54,
                        ),
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

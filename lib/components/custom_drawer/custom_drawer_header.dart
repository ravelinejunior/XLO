import 'package:flutter/material.dart';
import 'package:olx_project_parse/screens/login_screen/login_screen.dart';

class CustomDrawerHeader extends StatelessWidget {
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
                    "Acesse sua conta imadiatamente!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                  ),
                  Divider(color: Colors.white),
                  Text(
                    "Clique aqui !!! ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.fade,
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

import 'package:flutter/material.dart';
import 'package:olx_project_parse/screens/signup_screen/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Card(
              elevation: 10,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //botao do facebook
                    Container(
                      height: 54,
                      margin: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                      child: RaisedButton(
                        onPressed: () {},
                        child: const Text('Entrar com Facebook'),
                        color: Colors.lightBlue,
                        shape: StadiumBorder(),
                        textColor: Colors.white,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: const Text('ou'),
                        ),
                        Divider(color: Colors.grey),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Acessar com Email:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    //login
                    TextFormField(
                      smartDashesType: SmartDashesType.enabled,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          gapPadding: 16,
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: Colors.black.withAlpha(100),
                        ),
                        prefixIcon: Icon(Icons.alternate_email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 24),
                    //senha

                    TextFormField(
                      smartDashesType: SmartDashesType.enabled,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          gapPadding: 16,
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Senha",
                        hintStyle: TextStyle(
                          color: Colors.black.withAlpha(100),
                        ),
                        prefixIcon: Icon(Icons.offline_bolt),
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 16,
                      child: InkWell(
                        splashColor: Colors.red,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            'Esqueci minha senha',
                            style: TextStyle(
                                color: Colors.purple,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                    ),

                    //logar
                    Container(
                      height: 54,
                      margin: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                      child: RaisedButton(
                        splashColor: Colors.yellowAccent[700],
                        onPressed: () {},
                        child: Text(
                          'Entrar',
                          style: TextStyle(fontSize: 16),
                        ),
                        color: Colors.amber,
                        shape: StadiumBorder(),
                        textColor: Colors.black,
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    const SizedBox(height: 24),
                    InkWell(
                      splashColor: Colors.purple,
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => SignupScreen(),
                      )),
                      child: Container(
                        height: 24,
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Text(
                              'Não tem uma conta? ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Cadastre-se',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.purple,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_project_parse/components/errors/error_box.dart';

import 'package:olx_project_parse/screens/signup_screen/signup_screen.dart';
import 'package:olx_project_parse/stores/login_store.dart';
import 'package:olx_project_parse/stores/page_store.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginStore loginStore = LoginStore();

  final FocusNode focusNode1 = FocusNode();

  final FocusNode focusNode2 = FocusNode();

  final FocusNode focusNode3 = FocusNode();

  @override
  void initState() {
    super.initState();

//só é trigado uma vez
    when((_) => loginStore.successLogin, () {
      print("Cheguei aqui");
      Navigator.of(context).pop();
      GetIt.I<PageStore>().setPage(0);
    });
  }

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
                    /*     Container(
                      height: 54,
                      margin: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                      child: RaisedButton(
                        onPressed: () {},
                        child: const Text('Entrar com Facebook'),
                        color: Colors.lightBlue,
                        shape: StadiumBorder(),
                        textColor: Colors.white,
                      ),
                    ), */

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

                    Observer(
                      builder: (_) {
                        if (loginStore.showErrorBox)
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ErrorBox(
                              message: loginStore.error,
                            ),
                          );
                        else
                          return Container();
                      },
                    ),

                    const SizedBox(height: 16),
                    //login
                    Observer(
                      builder: (_) {
                        return TextField(
                          focusNode: focusNode1,
                          enabled: !loginStore.loading,
                          smartDashesType: SmartDashesType.enabled,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            errorText: loginStore.emailError,
                            errorStyle: TextStyle(
                              color: Colors.redAccent,
                            ),
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
                          onChanged: loginStore.setEmail,
                          onEditingComplete: focusNode2.requestFocus,
                          textInputAction: TextInputAction.next,
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    //senha

                    Observer(
                      builder: (_) {
                        return TextField(
                          focusNode: focusNode2,
                          enabled: !loginStore.loading,
                          smartDashesType: SmartDashesType.enabled,
                          decoration: InputDecoration(
                            errorText: loginStore.passwordError,
                            errorStyle: TextStyle(
                              color: Colors.redAccent,
                            ),
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
                            suffixIcon: InkWell(
                              onTap: () {
                                loginStore.setShowPass(!loginStore.showPass);
                              },
                              child: !loginStore.showPass
                                  ? Icon(Icons.visibility,
                                      color: Color.fromRGBO(255, 136, 0, 1))
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Color.fromRGBO(255, 136, 0, 1)
                                          .withAlpha(150),
                                    ),
                            ),
                          ),
                          obscureText: !loginStore.showPass,
                          keyboardType: TextInputType.text,
                          onChanged: loginStore.setPassword,
                          onSubmitted: (value) => focusNode3.requestFocus,
                        );
                      },
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
                              color: Color.fromRGBO(255, 136, 0, 1),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),

                    //logar
                    Observer(
                      builder: (_) {
                        if (loginStore.loading)
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 24,
                              horizontal: 16,
                            ),
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.purpleAccent,
                                ),
                                strokeWidth: 5,
                              ),
                            ),
                          );
                        else
                          return Container(
                            height: 54,
                            margin: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                            child: RaisedButton(
                              focusNode: focusNode3,
                              disabledColor: Colors.orange.withAlpha(100),
                              disabledElevation: 10,
                              elevation: 10,
                              disabledTextColor: Colors.black.withAlpha(100),
                              splashColor: Colors.yellowAccent[700],
                              onPressed: loginStore.loginButtonPressed,
                              child: Text(
                                'Entrar',
                                style: TextStyle(fontSize: 16),
                              ),
                              color: Colors.amber,
                              shape: StadiumBorder(),
                              textColor: Colors.black87,
                            ),
                          );
                      },
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    const SizedBox(height: 24),
                    InkWell(
                      splashColor: Colors.deepOrangeAccent,
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
                                color: Color.fromRGBO(255, 136, 0, 1),
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

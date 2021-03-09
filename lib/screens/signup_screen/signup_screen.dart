import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_project_parse/components/errors/error_box.dart';

import 'package:olx_project_parse/screens/login_screen/login_screen.dart';
import 'package:olx_project_parse/stores/home_store.dart';
import 'package:olx_project_parse/stores/page_store.dart';
import 'package:olx_project_parse/stores/signup_store.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignupStore signupStore = SignupStore();

  final FocusNode focusNode1 = FocusNode();

  final FocusNode focusNode2 = FocusNode();

  final FocusNode focusNode3 = FocusNode();

  final FocusNode focusNode4 = FocusNode();

  final FocusNode focusNode5 = FocusNode();

  @override
  void initState() {
    super.initState();

//só é trigado uma vez
    when((_) => signupStore.successLogin, () {
      print("Cheguei aqui");
      Navigator.of(context).pop();
      GetIt.I<PageStore>().setPage(0);
      GetIt.I<HomeStore>().setSearch('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: const Text('Signup'),
        centerTitle: true,
      ),
      body: Form(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 10,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(16),
                      children: [
                        //cadastro
                        Observer(
                          builder: (_) {
                            return TextFormField(
                              focusNode: focusNode1,
                              enabled: !signupStore.loading,
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                contentPadding: const EdgeInsets.all(16),
                                hintText: "Apelido",
                                helperText:
                                    "Nome que será exibido em seus anúncios",
                                helperStyle: TextStyle(
                                  color: Colors.black.withAlpha(100),
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.black.withAlpha(100),
                                ),
                                prefixIcon: Icon(Icons.person),
                                isDense: true,
                                errorText: signupStore.nameError,
                              ),
                              keyboardType: TextInputType.text,
                              onChanged: signupStore.setName,
                              onFieldSubmitted: (value) =>
                                  focusNode2.requestFocus(),
                            );
                          },
                        ),

                        const SizedBox(height: 24),

                        Observer(
                          builder: (_) {
                            return TextFormField(
                              focusNode: focusNode2,
                              enabled: !signupStore.loading,
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                contentPadding: const EdgeInsets.all(16),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  color: Colors.black.withAlpha(100),
                                ),
                                errorText: signupStore.emailError,
                                helperText: "Email de confirmação de cadastro",
                                helperStyle: TextStyle(
                                  color: Colors.black.withAlpha(100),
                                ),
                                prefixIcon: Icon(Icons.alternate_email),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: signupStore.setEmail,
                              onFieldSubmitted: (value) =>
                                  focusNode3.requestFocus(),
                            );
                          },
                        ),
                        const SizedBox(height: 24),

                        Observer(
                          builder: (_) {
                            return TextFormField(
                              focusNode: focusNode3,
                              enabled: !signupStore.loading,
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                contentPadding: const EdgeInsets.all(16),
                                hintText: "Celular: (31)99999-9999",
                                hintStyle: TextStyle(
                                  color: Colors.black.withAlpha(100),
                                ),
                                helperText: "Proteja sua conta",
                                helperStyle: TextStyle(
                                  color: Colors.black.withAlpha(100),
                                ),
                                prefixIcon: Icon(Icons.phone),
                                errorText: signupStore.phoneError,
                              ),
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                TelefoneInputFormatter(),
                              ],
                              onChanged: signupStore.setPhone,
                              onFieldSubmitted: (value) =>
                                  focusNode4.requestFocus(),
                            );
                          },
                        ),
                        const SizedBox(height: 24),

                        //senha

                        Observer(
                          builder: (_) {
                            return TextFormField(
                              focusNode: focusNode4,
                              enabled: !signupStore.loading,
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                contentPadding: const EdgeInsets.all(16),
                                hintText: "Senha",
                                hintStyle: TextStyle(
                                  color: Colors.black.withAlpha(100),
                                ),
                                helperText:
                                    "Use letras, numeros e caracteres especiais",
                                helperStyle: TextStyle(
                                  color: Colors.black.withAlpha(100),
                                ),
                                prefixIcon: Icon(Icons.all_inclusive),
                                errorText: signupStore.passwordError,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    signupStore
                                        .setShowPass(!signupStore.showPass);
                                  },
                                  child: !signupStore.showPass
                                      ? Icon(Icons.visibility,
                                          color: Color.fromRGBO(255, 136, 0, 1))
                                      : Icon(
                                          Icons.visibility_off,
                                          color: Color.fromRGBO(255, 136, 0, 1)
                                              .withAlpha(150),
                                        ),
                                ),
                              ),
                              onChanged: signupStore.setPassword,
                              obscureText: !signupStore.showPass,
                              keyboardType: TextInputType.text,
                              onEditingComplete: () =>
                                  focusNode5.requestFocus(),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        Observer(builder: (_) {
                          return TextFormField(
                            focusNode: focusNode5,
                            enabled: !signupStore.loading,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              contentPadding: const EdgeInsets.all(16),
                              hintText: "Confirmar senha",
                              hintStyle: TextStyle(
                                color: Colors.black.withAlpha(100),
                              ),
                              helperText: "Repita sua senha",
                              helperStyle: TextStyle(
                                color: Colors.black.withAlpha(100),
                              ),
                              prefixIcon: Icon(Icons.all_inclusive),
                              errorText: signupStore.passwordCopyError,
                              suffixIcon: InkWell(
                                onTap: () {
                                  signupStore.setShowPassConfirm(
                                      !signupStore.showPassConfirm);
                                },
                                child: !signupStore.showPassConfirm
                                    ? Icon(Icons.visibility,
                                        color: Color.fromRGBO(255, 136, 0, 1))
                                    : Icon(
                                        Icons.visibility_off,
                                        color: Color.fromRGBO(255, 136, 0, 1)
                                            .withAlpha(150),
                                      ),
                              ),
                            ),
                            onChanged: signupStore.setPasswordCopy,
                            textInputAction: TextInputAction.done,
                            obscureText: !signupStore.showPassConfirm,
                            onFieldSubmitted: (value) => focusNode5.unfocus(),
                          );
                        }),
                        const SizedBox(height: 24),
                        //cadastrar
                        Observer(builder: (_) {
                          if (signupStore.loading)
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.deepPurpleAccent),
                                strokeWidth: 4,
                              ),
                            );
                          else
                            return Container(
                              height: 60,
                              margin: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                              child: RaisedButton(
                                splashColor: Colors.red,
                                onPressed: signupStore.signupButtonPressed,
                                disabledColor:
                                    Colors.deepOrangeAccent.withAlpha(100),
                                child: Text(
                                  'Cadastrar',
                                  style: TextStyle(fontSize: 18),
                                ),
                                color: Colors.orange,
                                shape: StadiumBorder(),
                                textColor: Colors.black,
                              ),
                            );
                        }),

                        //mensagem de erro
                        Observer(
                          builder: (_) {
                            if (signupStore.showErrorBox)
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: ErrorBox(
                                  message: signupStore.error,
                                ),
                              );
                            else
                              return Container();
                          },
                        ),

                        Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        const SizedBox(height: 16),
                        InkWell(
                          splashColor: Colors.red,
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => LoginScreen(),
                          )),
                          child: SizedBox(
                            height: 24,
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                Text(
                                  'Já tem uma conta? ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Entrar',
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
                        const SizedBox(height: 500),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:olx_project_parse/screens/login_screen/login_screen.dart';
import 'package:olx_project_parse/stores/signup_store.dart';

class SignupScreen extends StatelessWidget {
  final SignupStore signupStore = SignupStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: const Text('Signup'),
        centerTitle: true,
      ),
      body: Container(
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
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                          hintText: "Apelido",
                          helperText: "Nome que será exibido em seus anúncios",
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
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  Observer(
                    builder: (_) {
                      return TextFormField(
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
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  Observer(
                    builder: (_) {
                      return TextFormField(
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
                          WhitelistingTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                        onChanged: signupStore.setPhone,
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  //senha

                  Observer(
                    builder: (_) {
                      return TextFormField(
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
                        ),
                        onChanged: signupStore.setPassword,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  Observer(builder: (_) {
                    return TextFormField(
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
                      ),
                      onChanged: signupStore.setPasswordCopy,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
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
                        child: Observer(builder: (_) {
                          return RaisedButton(
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
                          );
                        }),
                      );
                  }),

                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    splashColor: Colors.red,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
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
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Entrar',
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
                  const SizedBox(height: 500),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

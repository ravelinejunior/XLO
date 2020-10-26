import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olx_project_parse/screens/login_screen/login_screen.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 10,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              shrinkWrap: false,
              padding: const EdgeInsets.all(16),
              children: [
                //cadastro
                TextFormField(
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
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 24),

                TextFormField(
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
                    helperText: "Email de confirmação de cadastro",
                    helperStyle: TextStyle(
                      color: Colors.black.withAlpha(100),
                    ),
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24),

                TextFormField(
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
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                ),
                const SizedBox(height: 24),

                //senha

                TextFormField(
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
                    helperText: "Use letras, numeros e caracteres especiais",
                    helperStyle: TextStyle(
                      color: Colors.black.withAlpha(100),
                    ),
                    prefixIcon: Icon(Icons.all_inclusive),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 24),
                TextFormField(
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
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 24),
                //cadastrar
                Container(
                  height: 60,
                  margin: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                  child: RaisedButton(
                    splashColor: Colors.red,
                    onPressed: () {},
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(fontSize: 18),
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
    );
  }
}

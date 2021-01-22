import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:olx_project_parse/stores/edit_account_store.dart';
import 'package:toggle_switch/toggle_switch.dart';

class EditAccountScreen extends StatelessWidget {
  final EditAccountStore editAccountStore = EditAccountStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar meu perfil'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LayoutBuilder(
                    builder: (_, constraints) {
                      return ToggleSwitch(
                        minWidth: constraints.biggest.width / 2.009,
                        initialLabelIndex: 0,
                        minHeight: 60,
                        cornerRadius: 24.0,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        labels: ['Particular', 'Profissional'],
                        icons: [Icons.person, Icons.shop],
                        activeBgColors: [Colors.purple, Colors.pink],
                        onToggle: editAccountStore.setUserType,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  //nome
                  Observer(
                    builder: (_) {
                      return TextFormField(
                          initialValue: editAccountStore.name ?? null,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            contentPadding: const EdgeInsets.all(16),
                            labelText: "Nome",
                            labelStyle: TextStyle(
                              color: Colors.black.withAlpha(100),
                            ),
                            errorText: editAccountStore.nameError,
                            prefixIcon: Icon(Icons.title),
                            isDense: true,
                            helperStyle: TextStyle(color: Colors.transparent),
                          ),
                          onChanged: editAccountStore.setName,
                          maxLengthEnforced: true,
                          maxLength: 30,
                          keyboardType: TextInputType.text);
                    },
                  ),

                  //telefone
                  Observer(
                    builder: (_) {
                      return TextFormField(
                        decoration: InputDecoration(
                          errorText: editAccountStore.phoneError,
                          isDense: true,
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                          hintText: "Celular: (31)99999-9999",
                          hintStyle: TextStyle(
                            color: Colors.black.withAlpha(100),
                          ),
                          helperStyle: TextStyle(
                            color: Colors.black.withAlpha(100),
                          ),
                          prefixIcon: Icon(Icons.phone),
                        ),
                        initialValue: editAccountStore.phone ?? null,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                        onChanged: editAccountStore.setPhone,
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  //senha

                  Observer(
                    builder: (_) {
                      return TextFormField(
                        initialValue: editAccountStore.password ?? null,
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            isDense: true,
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
                            errorText: editAccountStore.passwordError),
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        onChanged: editAccountStore.setPassword,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Observer(builder: (_) {
                    return TextFormField(
                      initialValue: editAccountStore.confirmPass ?? null,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        hintText: "Confirmar senha",
                        isDense: true,
                        errorText: editAccountStore.passwordCopyError,
                        hintStyle: TextStyle(
                          color: Colors.black.withAlpha(100),
                        ),
                        helperStyle: TextStyle(
                          color: Colors.black.withAlpha(100),
                        ),
                        prefixIcon: Icon(Icons.all_inclusive),
                      ),
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      onChanged: editAccountStore.setConfirmPass,
                    );
                  }),
                  const SizedBox(height: 16),
                  //botao salvar
                  Observer(builder: (_) {
                    return Container(
                      height: 55,
                      child: RaisedButton(
                        splashColor: Colors.red,
                        onPressed: editAccountStore.editButtonPressed,
                        disabledColor: Colors.grey.withAlpha(100),
                        child: Text(
                          'Salvar',
                          style: TextStyle(fontSize: 18),
                        ),
                        color: Colors.orange[600],
                        shape: StadiumBorder(),
                        textColor: Colors.white,
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  //botao sair
                  Container(
                    height: 55,
                    child: RaisedButton(
                      splashColor: Colors.orange.withAlpha(200),
                      onPressed: () {},
                      disabledColor: Colors.orange.withAlpha(100),
                      child: Text(
                        'Sair',
                        style: TextStyle(fontSize: 18),
                      ),
                      color: Colors.red[600],
                      shape: StadiumBorder(),
                      textColor: Colors.white,
                    ),
                  ),

                  SizedBox(
                    height: 250,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_project_parse/managers/user_manager/user_manager_store.dart';
import 'package:olx_project_parse/stores/edit_account_store.dart';
import 'package:olx_project_parse/stores/page_store.dart';
import 'package:toggle_switch/toggle_switch.dart';

class EditAccountScreen extends StatelessWidget {
  final EditAccountStore editAccountStore = EditAccountStore();
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
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
                      return Observer(builder: (_) {
                        return IgnorePointer(
                          ignoring: editAccountStore.loading,
                          child: ToggleSwitch(
                            minWidth: constraints.biggest.width / 2.009,
                            initialLabelIndex: 0,
                            minHeight: 60,
                            cornerRadius: 24.0,
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.grey,
                            inactiveFgColor: Colors.white,
                            labels: ['Particular', 'Profissional'],
                            icons: [Icons.person, Icons.shop],
                            activeBgColors: !editAccountStore.loading
                                ? [Color.fromRGBO(255, 136, 0, 1), Colors.pink]
                                : [
                                    Colors.deepOrange.withAlpha(100),
                                    Colors.pink.withAlpha(100)
                                  ],
                            onToggle: editAccountStore.setUserType,
                          ),
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  //nome
                  Observer(
                    builder: (_) {
                      return TextFormField(
                          initialValue: editAccountStore.name,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            contentPadding: const EdgeInsets.all(16),
                            labelText: "Nome",
                            enabled: !editAccountStore.loading,
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
                          maxLength: 40,
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
                          enabled: !editAccountStore.loading,
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
                        initialValue: editAccountStore.password,
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            isDense: true,
                            enabled: !editAccountStore.loading,
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
                            suffixIcon: InkWell(
                              onTap: () {
                                editAccountStore
                                    .setShowPass(!editAccountStore.showPass);
                              },
                              child: !editAccountStore.showPass
                                  ? Icon(
                                      Icons.visibility,
                                      color: Color.fromRGBO(255, 136, 0, 1),
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Colors.deepOrange.withAlpha(150),
                                    ),
                            ),
                            errorText: editAccountStore.passwordError),
                        obscureText: !editAccountStore.showPass,
                        keyboardType: TextInputType.text,
                        onChanged: editAccountStore.setPassword,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Observer(builder: (_) {
                    return TextFormField(
                      initialValue: editAccountStore.confirmPass,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        enabled: !editAccountStore.loading,
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
                        suffixIcon: InkWell(
                          onTap: () {
                            editAccountStore.setShowPassConfirm(
                                !editAccountStore.showPassConfirm);
                          },
                          child: !editAccountStore.showPassConfirm
                              ? Icon(
                                  Icons.visibility,
                                  color: Color.fromRGBO(255, 136, 0, 1),
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: Colors.deepOrange.withAlpha(150),
                                ),
                        ),
                      ),
                      obscureText: !editAccountStore.showPassConfirm,
                      textInputAction: TextInputAction.done,
                      onChanged: editAccountStore.setConfirmPass,
                    );
                  }),
                  const SizedBox(height: 16),
                  //botao salvar
                  Observer(builder: (_) {
                    if (!editAccountStore.loading)
                      return Container(
                        height: 55,
                        child: RaisedButton(
                          splashColor: Colors.red,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      title: const Text('Atualizar perfil'),
                                      content:
                                          Text('Deseja atualizar seus dados?'),
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32)),
                                      elevation: 10,
                                      actions: [
                                        FlatButton.icon(
                                          icon: Icon(
                                            Icons.cancel,
                                            color: Colors.red[800],
                                          ),
                                          textColor: Colors.red[800],
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          label: Text('Cancelar'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        FlatButton.icon(
                                          icon: Icon(
                                            Icons.update,
                                            color: Colors.green,
                                          ),
                                          textColor: Colors.green,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          label: Text('Confirmar'),
                                          onPressed: () {
                                            editAccountStore
                                                .editPressedButton();
                                            Navigator.of(context).pop();
                                            Fluttertoast.showToast(
                                              msg:
                                                  "Dados atualizados com sucesso!",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 2,
                                              backgroundColor: Colors.black54,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            ).then((value) {
                                              Navigator.of(context).pop();
                                            });
                                          },
                                        ),
                                      ],
                                    ));
                          },
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
                    else
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromRGBO(255, 136, 0, 1),
                          ),
                          strokeWidth: 6,
                        ),
                      );
                  }),
                  const SizedBox(height: 16),
                  //botao sair
                  Container(
                    height: 55,
                    child: RaisedButton(
                      splashColor: Colors.orange.withAlpha(200),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: const Text('Finalizar sessão'),
                                  content: Text('Deseja finalizar sua sessão?'),
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32)),
                                  elevation: 10,
                                  actions: [
                                    FlatButton.icon(
                                      icon: Icon(
                                        Icons.cancel,
                                        color: Colors.blue[800],
                                      ),
                                      textColor: Colors.blue[800],
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      label: Text('Cancelar'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton.icon(
                                      icon: Icon(
                                        Icons.supervised_user_circle,
                                        color: Colors.red,
                                      ),
                                      textColor: Colors.red,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      label: Text('Confirmar'),
                                      onPressed: () {
                                        userManagerStore.userLogout();
                                        Navigator.of(context).pop();
                                        GetIt.I<PageStore>().setPage(0);
                                        Fluttertoast.showToast(
                                          msg: "Sessão finalizada com sucesso!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.black54,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        ).then((value) {
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                  ],
                                ));
                      },
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

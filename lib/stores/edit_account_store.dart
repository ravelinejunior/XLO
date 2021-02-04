import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_project_parse/managers/user_manager/user_manager_store.dart';
import 'package:olx_project_parse/models/user.dart';
import 'package:olx_project_parse/repositories/repo_user/user_repository.dart';
part 'edit_account_store.g.dart';

class EditAccountStore = _EditAccountStore with _$EditAccountStore;

abstract class _EditAccountStore with Store {
  _EditAccountStore() {
    user = userManagerStore.user;
    userType = user.userType;
    name = user.name;
    phone = user.phone;
  }
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  User user;

  @observable
  UserType userType;

  @observable
  bool showPass = false;

  @action
  void setShowPass(bool value) => showPass = value;

  @observable
  bool showPassConfirm = false;

  @action
  void setShowPassConfirm(bool value) => showPassConfirm = value;

  @action
  setUserType(int value) => userType = UserType.values[value];

  @observable
  String name;

  @action
  setName(String value) => name = value;

  @computed
  bool get nameValid => name != null && name.length > 6;
  String get nameError {
    if (name == null || nameValid) {
      return null;
    } else if (name.isEmpty) {
      return "Campo obrigatório";
    } else {
      return "Nome muito curto";
    }
  }

  @observable
  String phone;

  @action
  setPhone(String value) => phone = value;

  @computed
  bool get phoneValid => phone != null && phone.length >= 14;
  String get phoneError {
    if (phone == null || phoneValid) {
      return null;
    } else if (phone.isEmpty) {
      return "Campo obrigatório!";
    } else {
      return "Formato de telefone incorreto\nEx..: 31-975903333";
    }
  }

  @observable
  String password = '';

  @action
  setPassword(String value) => password = value;

  @computed
  bool get passwordValid => password != null && password.length >= 6;
  String get passwordError {
    if (password == null || passwordValid || password.isEmpty) {
      return null;
    } else {
      return "Mínimo de 6 caracters";
    }
  }

  @observable
  String confirmPass = '';

  @action
  setConfirmPass(String value) => confirmPass = value;

  @computed
  bool get confirmPassValid =>
      confirmPass != null && confirmPass == password && password.isNotEmpty;
  String get passwordCopyError {
    if ((confirmPass == null || confirmPassValid) && passwordValid) {
      return null;
    } else if (confirmPass.isEmpty && password.isNotEmpty) {
      return "Senhas não coicidem!";
    } else if (password.isEmpty && confirmPass.isEmpty) {
      return null;
    } else {
      return "Senhas não coicidem!";
    }
  }

  @computed
  bool get isFormValid => nameValid & confirmPassValid & phoneValid && !loading;

  //verificação de estado
  @computed
  VoidCallback get editPressedButton => isFormValid ? _updateUserData : null;

  @observable
  bool loading = false;

  @observable
  bool successful = false;

  @observable
  bool cancel = false;

  void setCancel(bool value) => cancel = value;

  @action
  Future<void> _updateUserData() async {
    loading = true;
    user.name = name;
    user.phone = phone;
    user.userType = userType;

    if (password.isNotEmpty) {
      user.password = password;
    } else {
      user.password = null;
    }
    try {
      await UserRepository().updateUser(user);
      userManagerStore.setUser(user);
      successful = true;
    } catch (e) {
      print(e);
    }

    Future.delayed(Duration(seconds: 1)).then((value) {
      loading = false;
    });
  }
}

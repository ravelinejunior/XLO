import 'package:mobx/mobx.dart';
import 'package:olx_project_parse/models/user.dart';
part 'edit_account_store.g.dart';

class EditAccountStore = _EditAccountStore with _$EditAccountStore;

abstract class _EditAccountStore with Store {
  @observable
  UserType userType;

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
  String password;

  @action
  setPassword(String value) => password = value;

  @computed
  bool get passwordValid => password != null && password.length >= 6;
  String get passwordError {
    if (password == null || passwordValid) {
      return null;
    } else if (password.isEmpty) {
      return "Campo obrigatório!";
    } else {
      return "Mínimo de 6 caracters";
    }
  }

  @observable
  String confirmPass;

  @action
  setConfirmPass(String value) => confirmPass = value;

  @computed
  bool get confirmPassValid => confirmPass != null && confirmPass == password;
  String get passwordCopyError {
    if (confirmPass == null || confirmPassValid) {
      return null;
    } else if (confirmPass.isEmpty) {
      return "Campo obrigatório!";
    } else {
      return "Senhas não coicidem.";
    }
  }

  @computed
  bool get isFormValid =>
      nameValid & passwordValid & confirmPassValid & phoneValid;

  //verificação de estado
  @computed
  Function get editButtonPressed => isFormValid ? () {} : null;
}

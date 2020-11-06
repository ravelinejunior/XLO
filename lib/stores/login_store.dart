import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_project_parse/helpers/extensions.dart';
import 'package:olx_project_parse/managers/user_manager/user_manager_store.dart';
import 'package:olx_project_parse/models/user.dart';
import 'package:olx_project_parse/repositories/user/user_repository.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  //email
  @observable
  String email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email.isEmailValid();
  String get emailError {
    if (email == null || emailValid) {
      return null;
    } else if (email.isEmpty) {
      return "Campo obrigatório!";
    } else {
      return "Formato de email incorreto\nEx..: email@email.com";
    }
  }

  //password
  @observable
  String password;

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get passwordValid => password != null && password.length >= 4;
  String get passwordError {
    if (password == null || passwordValid) {
      return null;
    } else if (password.isEmpty) {
      return "Campo obrigatório!";
    } else {
      return "Mínimo de 4 caracters";
    }
  }

  @observable
  bool loading = false;
  @action
  setLoading(bool value) => loading = value;

//valida formulario
  @computed
  bool get isFormValid => emailValid && passwordValid;

//verificação de estado
  @computed
  Function get loginButtonPressed => isFormValid ? _loginCall : null;

  @observable
  String error;

  @observable
  bool showErrorBox = false;

  @action
  setShowError(bool value) => showErrorBox = value;

  Future<void> _loginCall() async {
    setLoading(true);
    await Future.delayed(Duration(seconds: 1));
    try {
      final user = await UserRepository().loginWithEmail(email, password);
      //salvar usuario no singleton da classe main
      GetIt.I<UserManagerStore>().setUser(user);
    } catch (e) {
      error = e.toString();
      showErrorBoxDisplay();
    }
    setLoading(false);
  }

  void showErrorBoxDisplay() async {
    setShowError(true);
    await Future.delayed(Duration(seconds: 4)).then((_) => setShowError(false));
  }
}

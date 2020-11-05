import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_project_parse/helpers/extensions.dart';
import 'package:olx_project_parse/managers/user_manager/user_manager_store.dart';
import 'package:olx_project_parse/models/user.dart';
import 'package:olx_project_parse/repositories/user/user_repository.dart';
part 'signup_store.g.dart';

class SignupStore = _SignupStoreBase with _$SignupStore;

abstract class _SignupStoreBase with Store {
  //name
  @observable
  String name;

  @action
  void setName(String value) => name = value;

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

  //phone
  @observable
  String phone;

  @action
  void setPhone(String value) => phone = value;

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

  //password
  @observable
  String password;

  @action
  void setPassword(String value) => password = value;

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

  //password
  @observable
  String passwordCopy;

  @action
  void setPasswordCopy(String value) => passwordCopy = value;

  @computed
  bool get passwordCopyValid =>
      passwordCopy != null && passwordCopy == password;
  String get passwordCopyError {
    if (passwordCopy == null || passwordCopyValid) {
      return null;
    } else if (passwordCopy.isEmpty) {
      return "Campo obrigatório!";
    } else {
      return "Senhas não coicidem.";
    }
  }

  @observable
  bool loading = false;
  @action
  setLoading(bool value) => loading = value;

//valida formulario
  @computed
  bool get isFormValid =>
      nameValid &&
      emailValid &&
      phoneValid &&
      passwordValid &&
      passwordCopyValid;

//verificação de estado
  @computed
  Function get signupButtonPressed => isFormValid ? _signupCall : null;

//verifica erro de cadastro
  @observable
  String error;

  @action
  setError(String value) => error = value;

  @observable
  bool showErrorBox = false;

  @action
  setShowError(bool value) => showErrorBox = value;

  //cadastrar
  Future<void> _signupCall() async {
    setLoading(true);

    final user =
        User(name: name, email: email, phone: phone, password: password);
    try {
      final resultUser = await UserRepository().signupUser(user);
      //salvar usuario no singleton da classe main
      GetIt.I<UserManagerStore>().setUser(resultUser);
      await Future.delayed(Duration(seconds: 1));
    } catch (e) {
      error = e;
      showErrorBoxDisplay();
    }

    setLoading(false);
  }

  void showErrorBoxDisplay() async {
    setShowError(true);
    await Future.delayed(Duration(seconds: 4)).then((_) => setShowError(false));
  }
}

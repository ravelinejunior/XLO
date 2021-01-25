import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_project_parse/models/user.dart';
import 'package:olx_project_parse/repositories/repo_user/user_repository.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';
part 'user_manager_store.g.dart';

class UserManagerStore = _UserManagerStore with _$UserManagerStore;

abstract class _UserManagerStore with Store {
  _UserManagerStore() {
    _getCurrentUser();
  }

  @observable
  User user;

  @action
  setUser(User value) => user = value;

  @computed
  bool get isLoggedIn => user != null;

  Future<void> _getCurrentUser() async {
    final user = await UserRepository().currentUser();
    setUser(user);
  }

  @action
  Future<void> userLogout() async {
    final ParseUser parseUser = await ParseUser.currentUser();
    if (parseUser != null) {
      await parseUser.logout();
      GetIt.I<UserManagerStore>().setUser(null);
    }
  }
}

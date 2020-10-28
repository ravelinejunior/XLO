import 'package:olx_project_parse/models/user.dart';
import 'package:olx_project_parse/repositories/tables_keys/table_key.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class UserRepository {
  Future<void> signupUser(User user) async {
    final parseUser = ParseUser(user.email, user.password, user.email);

    parseUser.set<String>(keyUserName, user.name);
    parseUser.set<String>(keyUserPhone, user.phone);
    parseUser.set(keyuserType, user.userType.index);

    await parseUser.signUp();
  }
}

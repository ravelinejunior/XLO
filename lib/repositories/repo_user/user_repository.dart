import 'package:olx_project_parse/models/user.dart';
import 'package:olx_project_parse/repositories/response_errors/parse_errors.dart';
import 'package:olx_project_parse/repositories/tables_keys/table_key.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserRepository {
  //cadastro de usuario
  Future<User> signupUser(User user) async {
    final parseUser = ParseUser(user.email, user.password, user.email);

    parseUser.set<String>(keyUserName, user.name);
    parseUser.set<String>(keyUserPhone, user.phone);
    parseUser.set(keyUserType, user.userType.index);

    final response = await parseUser.signUp();

    //verifica resposta signup
    if (response.success) {
      return mapParseToUser(parseUser);
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  //login com email
  Future<User> loginWithEmail(String email, String password) async {
    final parseUser = ParseUser(email, password, null);

    final response = await parseUser.login();

    if (response.success) {
      //tras info sobre usuario
      return mapParseToUser(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  //função de login inicial
  Future<User> currentUser() async {
    final parseUser = await ParseUser.currentUser();
    if (parseUser != null) {
      final response =
          await ParseUser.getCurrentUserFromServer(parseUser.sessionToken);
      if (response.success) {
        return mapParseToUser(response.result);
      } else {
        await parseUser.logout();
      }
    }
    return null;
  }

  //transformar parseruser em User
  User mapParseToUser(ParseUser parseUser) {
    return User(
      id: parseUser.objectId,
      name: parseUser.get(keyUserName),
      email: parseUser.get(keyUserEmail),
      phone: parseUser.get(keyUserPhone),
      password: parseUser.get(keyUserPassword),
      userType: UserType.values[parseUser.get(keyUserType)],
      createdAt: parseUser.get(keyUserCreatedAt),
    );
  }

  Future<void> updateUser(User user) async {
    //get the current parse user
    final ParseUser parseUser = await ParseUser.currentUser();
    if (parseUser != null) {
      //update user data
      parseUser.set<String>(keyUserName, user.name);
      parseUser.set<String>(keyUserPhone, user.phone);
      parseUser.set<int>(keyUserType, user.userType.index);

      //verify the password
      if (user.password != null) {
        parseUser.password = parseUser.password;
      }

      final response = await parseUser.save();

      if (!response.success) {
        return Future.error(ParseErrors.getDescription(response.error.code));
      }

      //parse server desconnect the user, so loggin again
      if (user.password != null) {
        await parseUser.logout();
        final loginResponse =
            await ParseUser(user.email, user.password, user.email).login();

        if (!loginResponse.success) {
          return Future.error(ParseErrors.getDescription(response.error.code));
        }
      }
    }
  }
}

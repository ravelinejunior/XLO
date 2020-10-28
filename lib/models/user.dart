enum UserType { PARTICULAR, PROFESSIONAL }

class User {
  String name;
  String email;
  String phone;
  String password;
  UserType userType;

  User({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.userType = UserType.PARTICULAR,
  });
}

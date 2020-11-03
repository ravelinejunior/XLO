enum UserType { PARTICULAR, PROFESSIONAL }

class User {
  String id;
  String name;
  String email;
  String phone;
  String password;
  UserType userType;
  DateTime createdAt;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.userType = UserType.PARTICULAR,
    this.createdAt,
  });
}

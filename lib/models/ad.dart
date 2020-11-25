import 'package:olx_project_parse/models/address.dart';
import 'package:olx_project_parse/models/category.dart';
import 'package:olx_project_parse/models/user.dart';

enum AdStatus { PENDING, ACTIVE, SOLD, DELETED }

class Ad {
  String id;
  List images;
  String title;
  String description;
  Category category;
  Address address;
  num price;
  bool hidePhone;
  AdStatus status = AdStatus.PENDING;
  DateTime dateCreated;
  User user;
  int views;
}

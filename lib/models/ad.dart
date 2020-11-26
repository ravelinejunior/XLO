import 'package:olx_project_parse/models/address.dart';
import 'package:olx_project_parse/models/category.dart';
import 'package:olx_project_parse/models/uf.dart';
import 'package:olx_project_parse/models/user.dart';
import 'package:olx_project_parse/repositories/repo_user/user_repository.dart';
import 'package:olx_project_parse/repositories/tables_keys/table_key.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'city.dart';

enum AdStatus { PENDING, ACTIVE, SOLD, DELETED }

class Ad {
  Ad();

  Ad.fromParse(ParseObject object) {
    id = object.objectId;
    title = object.get<String>(keyAdTitle);
    description = object.get<String>(keyAdDescription);
    images = object.get<List>(keyAdImages).map((image) => image.url).toList();
    hidePhone = object.get<bool>(keyAdHidePhone);
    price = object.get<num>(keyAdPrice);
    dateCreated = object.createdAt;
    address = Address(
      cep: object.get<String>(keyAdPostalCode),
      city: City(name: object.get<String>(keyAdCity)),
      disctrict: object.get<String>(keyAdDistrict),
      uf: UF(
        initials: object.get(keyAdFederativeUnit),
      ),
    );
    views = object.get<int>(keyAdViews, defaultValue: 0);
    user = UserRepository().mapParseToUser(object.get<ParseUser>(keyAdOwner));
    category = Category.fromParse(object.get<ParseObject>(keyAdCategory));
    status = AdStatus.values[object.get<int>(keyAdStatus)];
  }

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

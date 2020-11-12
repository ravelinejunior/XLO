import 'package:olx_project_parse/repositories/tables_keys/table_key.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Category {
  Category({this.id, this.description});
  Category.fromParse(ParseObject parseObject)
      : id = parseObject.objectId,
        description = parseObject.get(keyCategoryDescription);

  String id;
  String description;

  @override
  String toString() {
    return "Category{id: $id ,description: $description\n}";
  }
}

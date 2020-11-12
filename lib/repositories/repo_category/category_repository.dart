import 'package:olx_project_parse/models/category.dart';
import 'package:olx_project_parse/repositories/response_errors/parse_errors.dart';
import 'package:olx_project_parse/repositories/tables_keys/table_key.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CategoryRepository {
  Future<List<Category>> getList() async {
    final queryBuilder = QueryBuilder(ParseObject(keyCategoryTable))
      ..orderByAscending(keyCategoryDescription);

    final response = await queryBuilder.query();

    //criar objeto category
    if (response.success) {
      return response.results.map((p) => Category.fromParse(p)).toList();
    } else {
      throw ParseErrors.getDescription(response.error.code);
    }
  }
}

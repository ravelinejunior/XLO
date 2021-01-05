import 'package:mobx/mobx.dart';
import 'package:olx_project_parse/models/category.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable
  String search = "";

  @action
  void setSearch(String text) => search = text;

  @observable
  Category categorySelected;

  @action
  void setCategory(Category value) => categorySelected = value;
}

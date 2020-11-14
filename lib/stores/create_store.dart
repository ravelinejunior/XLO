import 'package:mobx/mobx.dart';
import 'package:olx_project_parse/models/category.dart';
part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {
  ObservableList images = ObservableList();

  @observable
  Category category;

  @action
  void setCategory(Category cat) => category = cat;
}

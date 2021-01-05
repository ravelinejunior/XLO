import 'package:mobx/mobx.dart';
import 'package:olx_project_parse/models/category.dart';
import 'package:olx_project_parse/repositories/repo_category/category_repository.dart';
part 'category_store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  ObservableList<Category> categoryList = ObservableList<Category>();

  _CategoryStore() {
    _loadCategories();
  }

  //carrega todas as categorias assim que abre o app
  Future<void> _loadCategories() async {
    try {
      final categories = await CategoryRepository().getList();
      setCategories(categories);
    } catch (e) {
      setError(e);
    }
  }

//seta categorias
  @action
  void setCategories(List<Category> categories) {
    categoryList.clear();

    categoryList.addAll(categories);
  }

  @observable
  String error;

//seta erros
  @action
  setError(String value) => error = value;

//recupera todas as categorias e cria mais uma full para clonar a lista
  @computed
  List<Category> get allCategoryList => List.from(categoryList)
    ..insert(0, Category(id: '*', description: 'Todas'));
}

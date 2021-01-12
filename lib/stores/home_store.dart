import 'package:mobx/mobx.dart';
import 'package:olx_project_parse/models/category.dart';
import 'package:olx_project_parse/repositories/ad_repository/ad_repository.dart';

import 'filter_store.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  //os campos passados como parametro sao todos observables entao todas as vezes que houver alteração, o autorun é chamado
  _HomeStore() {
    autorun((_) async {
      final newAds = await AdRepository().getHomeAdList(
        filter: filter,
        search: search,
        category: categorySelected,
      );
      print('Lista compilada ' + newAds.toString());
    });
  }

  @observable
  String search = "";

  @action
  void setSearch(String text) => search = text;

  @observable
  Category categorySelected;

  @action
  void setCategory(Category value) => categorySelected = value;

  @observable
  FilterStore filter = FilterStore();

//recebe a ultima instancia salva
  FilterStore get clonedFilter => filter.clone();

  @action
  void setFilter(FilterStore value) => filter = value;
}

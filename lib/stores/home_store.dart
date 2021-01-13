import 'package:mobx/mobx.dart';
import 'package:olx_project_parse/models/ad.dart';
import 'package:olx_project_parse/models/category.dart';
import 'package:olx_project_parse/repositories/ad_repository/ad_repository.dart';

import 'filter_store.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  //os campos passados como parametro sao todos observables entao todas as vezes que houver alteração, o autorun é chamado
  _HomeStore() {
    autorun((_) async {
      try {
        setLoading(true);
        final newAds = await AdRepository().getHomeAdList(
          filter: filter,
          search: search,
          category: categorySelected,
          page: page,
        );
        addNewAds(newAds);

        setError(null);
        setLoading(false);
      } catch (e) {
        setError(e);
        setLoading(false);
      }
    });
  }

  ObservableList<Ad> adList = ObservableList<Ad>();

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  String search = "";

  @action
  void setSearch(String text) {
    search = text;
    resetPage();
  }

  @observable
  Category categorySelected;

  @action
  void setCategory(Category value) {
    categorySelected = value;
    resetPage();
  }

  @observable
  FilterStore filter = FilterStore();

//recebe a ultima instancia salva
  FilterStore get clonedFilter => filter.clone();

  @action
  void setFilter(FilterStore value) {
    filter = value;
    resetPage();
  }

//pagination
  @observable
  int page = 0;

  @action
  void loadNextPage() => page++;

  void resetPage() {
    page = 0;
    adList.clear();
    lastPage = false;
  }

  @computed
  int get itemCount => lastPage ? adList.length : adList.length + 1;

//indicated if is the last page
  @observable
  bool lastPage = false;

  @action
  void addNewAds(List<Ad> newAds) {
    if (newAds.length < 10) lastPage = true;
    adList.addAll(newAds);
  }

  @computed
  bool get showProgress => loading && adList.isEmpty;
}

import 'package:mobx/mobx.dart';
part 'filter_store.g.dart';

enum OrderBy { DATE, PRICE }
enum OrderByTypeStore { PARTICULAR, PROFESSIONAL }

class FilterStore = _FilterStore with _$FilterStore;

abstract class _FilterStore with Store {
  @observable
  OrderBy orderBy = OrderBy.DATE;

  @action
  void setOrderBy(OrderBy value) => orderBy = value;

  @observable
  OrderByTypeStore orderByType = OrderByTypeStore.PARTICULAR;

  @action
  void setOrderByType(OrderByTypeStore value) => orderByType = value;
}

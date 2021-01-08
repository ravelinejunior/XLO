import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_project_parse/stores/home_store.dart';
part 'filter_store.g.dart';

enum OrderBy { DATE, PRICE }
enum OrderByTypeStore { PARTICULAR, PROFESSIONAL }

//aula 334
const VENDOR_TYPE_PARTICULAR = 1 << 0;
const VENDOR_TYPE_PROFESSIONAL = 1 << 1;

class FilterStore = _FilterStore with _$FilterStore;

abstract class _FilterStore with Store {
  _FilterStore({
    this.orderBy = OrderBy.DATE,
    this.minPrice,
    this.maxPrice,
    this.vendorType = VENDOR_TYPE_PARTICULAR,
  });

  @observable
  OrderBy orderBy = OrderBy.DATE;

  @action
  void setOrderBy(OrderBy value) => orderBy = value;

  @observable
  OrderByTypeStore orderByType;

  @action
  void setOrderByType(OrderByTypeStore value) => orderByType = value;

  @observable
  int minPrice;

  @action
  void setMinPrice(int value) => minPrice = value;

  @observable
  int maxPrice;

  @action
  void setMaxPrice(int value) => maxPrice = value;

  @computed
  String get priceError =>
      (maxPrice != null && minPrice != null && minPrice > maxPrice)
          ? 'Preço mínimo não pode ser maior que preço máximo.'
          : null;

  @observable
  int vendorType;

  @action
  void selectVendorType(int value) => vendorType = value;
  void setVendorType(int type) => vendorType = vendorType | type;
  void resetVendorType(int type) => vendorType = vendorType & ~type;

  @computed
  bool get isTypeParticular => (vendorType & VENDOR_TYPE_PARTICULAR) != 0;
  bool get isTypeProfessional => (vendorType & VENDOR_TYPE_PROFESSIONAL) != 0;

  //validação de filtro
  @computed
  bool get isFormValid => priceError == null;

  Future<void> save() async {
    GetIt.I<HomeStore>().setFilter(this);
  }

  FilterStore clone() {
    return FilterStore(
        orderBy: orderBy,
        minPrice: minPrice,
        maxPrice: maxPrice,
        vendorType: vendorType);
  }
}

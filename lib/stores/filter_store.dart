import 'package:mobx/mobx.dart';
part 'filter_store.g.dart';

enum OrderBy { DATE, PRICE }
enum OrderByTypeStore { PARTICULAR, PROFESSIONAL }

//aula 334
const VENDOR_TYPE_PARTICULAR = 1 << 0;
const VENDOR_TYPE_PROFESSIONAL = 1 << 1;

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

  @observable
  int minPrice;

  @action
  void setMinPrice(int value) => minPrice = value;

  @observable
  int maxPrice;

  @action
  void setMaxPrice(int value) => maxPrice = value;

  @computed
  String get priceError {
    if (maxPrice != null && minPrice != null && minPrice > maxPrice) {
      return 'Preço mínimo não pode ser maior que preço máximo.';
    } else
      return null;
  }

  @observable
  int vendorType = VENDOR_TYPE_PARTICULAR;

  @action
  void selectVendorType(int value) => vendorType = value;
  void setVendorType(int type) => vendorType = vendorType | type;
  void resetVendorType(int type) => vendorType = vendorType & ~type;

  @computed
  bool get isTypeParticular => (vendorType & VENDOR_TYPE_PARTICULAR) != 0;
  bool get isTypeProfessional => (vendorType & VENDOR_TYPE_PROFESSIONAL) != 0;
}

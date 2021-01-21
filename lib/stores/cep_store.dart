import 'package:mobx/mobx.dart';
import 'package:olx_project_parse/api/cep_api/cep_api.dart';
import 'package:olx_project_parse/models/address.dart';
part 'cep_store.g.dart';

class CepStore = _CepStore with _$CepStore;

abstract class _CepStore with Store {
//reação
  _CepStore(String initialCep) {
    autorun(
      (_) {
        if (clearCep.length != 8) {
          _reset();
        } else {
          _searchCep();
        }
      },
    );
    setCep(initialCep);
  }

  @observable
  String cep = "";

  @observable
  Address address;

  @observable
  String error;

  @observable
  bool loading = false;

  @action
  void setCep(String value) => cep = value;

  @computed
  String get clearCep => cep.replaceAll(RegExp('[^0-9]'), '');

  @action
  Future<void> _searchCep() async {
    loading = true;
    try {
      address = await CepApi().getAddressFromApi(clearCep);
      error = null;
    } catch (e) {
      error = e;
      address = null;
    }

    loading = false;
  }

  @action
  void _reset() {
    address = null;
    error = null;
  }
}

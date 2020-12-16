import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_project_parse/managers/user_manager/user_manager_store.dart';
import 'package:olx_project_parse/models/ad.dart';
import 'package:olx_project_parse/models/address.dart';
import 'package:olx_project_parse/models/category.dart';
import 'package:olx_project_parse/repositories/ad_repository/ad_repository.dart';
import 'package:olx_project_parse/stores/cep_store.dart';
part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {
  ObservableList images = ObservableList();

  @observable
  bool loading = false;

  @action
  bool setLoading(bool value) => loading = value;

  @computed
  bool get imagesValid => images.isNotEmpty;
  String get imagesError {
    if (!showErrors || imagesValid)
      return null;
    else
      return "Insira ao menos uma imagem.";
  }

  @observable
  String title = "";

  @action
  void setTitle(String value) => title = value;

  @computed
  bool get titleValid => title.length >= 6;
  String get titleError {
    if (!showErrors || titleValid)
      return null;
    else if (title.isEmpty)
      return "Campo obrigatório";
    else
      return "Título deve conter mínimo 6 caracteres";
  }

  @observable
  String description = "";

  @action
  void setDescription(String value) => description = value;

  @computed
  bool get descriptionValid => description.length >= 6;
  String get descriptionError {
    if (!showErrors || descriptionValid)
      return null;
    else if (description.isEmpty)
      return "Campo obrigatório";
    else
      return "Descrição deve conter mínimo 6 caracteres";
  }

  @observable
  Category category;

  @action
  void setCategory(Category cat) => category = cat;

  @computed
  bool get categoryValid => category != null;
  String get categoryError {
    if (!showErrors || categoryValid)
      return null;
    else
      return "Selecione uma categoria";
  }

  @observable
  bool hidePhone = false;

  @action
  void setHidePhone(bool value) => hidePhone = value;

  CepStore cepStore = CepStore();

  @computed
  Address get address => cepStore.address;
  bool get addressValid => address != null;
  String get addressErro {
    if (!showErrors || addressValid)
      return null;
    else
      return "Cep Obrigatório";
  }

  @observable
  String priceText = "";

  @action
  void setPrice(String value) => priceText = value;

  @computed
  num get price {
    if (priceText.contains(',')) {
      return num.tryParse(priceText.replaceAll(RegExp('[^0-9]'), '')) / 100;
    } else {
      return num.tryParse(priceText);
    }
  }

  bool get priceValid => price != null && price <= 999999999;
  String get priceError {
    if (!showErrors || priceValid)
      return null;
    else if (priceText.isEmpty)
      return "Digite o preço do seu produto";
    else
      return "Preço inválido";
  }

  @computed
  bool get formValid =>
      imagesValid &&
      titleValid &&
      descriptionValid &&
      categoryValid &&
      addressValid &&
      priceValid;

  @computed
  Function get sendPressedValid => formValid ? _send : null;

  @action
  Future<void> _send() async {
    setLoading(true);

    final ad = Ad();
    ad.address = address;
    ad.category = category;
    ad.description = description;
    ad.hidePhone = hidePhone;
    ad.images = images;
    ad.price = price;
    ad.user = GetIt.I<UserManagerStore>().user;

    try {
      await AdRepository().save(ad);
      savedAd = true;
    } catch (e) {
      error = e;
      showErrorBoxDisplay();
    }

    setLoading(false);
  }

  @observable
  bool showErrors = false;

  @action
  bool setInvalidSendPressed() => showErrors = true;

  @observable
  String error = "";

  @observable
  bool savedAd = false;

  @observable
  bool showErrorBox = false;

  @action
  setShowError(bool value) => showErrorBox = value;

  void showErrorBoxDisplay() async {
    setShowError(true);
    await Future.delayed(Duration(seconds: 4)).then((_) => setShowError(false));
  }
}

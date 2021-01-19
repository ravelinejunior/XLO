import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_project_parse/managers/user_manager/user_manager_store.dart';
import 'package:olx_project_parse/repositories/ad_repository/ad_repository.dart';
part 'myads_store.g.dart';

class MyAdsStore = _MyAdsStore with _$MyAdsStore;

abstract class _MyAdsStore with Store {
  _MyAdsStore() {
    _getMyAds();
  }
  Future<void> _getMyAds() async {
    final user = GetIt.I<UserManagerStore>().user;
    final ads = await AdRepository().getMyAds(user);
    print(ads);
  }
}

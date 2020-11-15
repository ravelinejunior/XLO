import 'package:olx_project_parse/models/city.dart';
import 'package:olx_project_parse/models/uf.dart';

class Address {
  Address({this.uf, this.city, this.cep, this.disctrict});
  UF uf;
  City city;

  String cep;
  String disctrict;

  @override
  String toString() {
    return 'Address {cep $cep, city $city}\n';
  }
}

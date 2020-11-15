import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:olx_project_parse/models/city.dart';
import 'package:olx_project_parse/models/uf.dart';
import 'package:olx_project_parse/repositories/tables_keys/table_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IBGEApi {
  Future<List<UF>> getUFListFromApi() async {
    //salvar dados em cache
    final preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(UF_PREF_KEY)) {
      //ler lista de estados e decodificar para json
      final jsonDecoded = json.decode(preferences.get(UF_PREF_KEY));

      print("Found in cache");
      return jsonDecoded.map<UF>((json) => UF.fromJson(json)).toList()
        ..sort((UF a, UF b) =>
            a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    }

    //receber o end point
    const endPoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados';
    try {
      //recuperar lista com estados em uma lista de respostas
      final response = await Dio().get<List>(endPoint);
      //salvar dados do response em cache
      preferences.setString(UF_PREF_KEY, json.encode(response.data));
      //recuperar e mapear resposta em formato json para formato model UF
      final ufList = response.data.map<UF>((json) => UF.fromJson(json)).toList()
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      print("Not found in cache");
      return ufList;
    } on DioError {
      return Future.error("Falha ao obter lista de estados da API");
    }
  }

  Future<List<City>> getCityListFromApi(UF uf) async {
    final String endPoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados/${uf.id}/municipios';

    try {
      final response = await Dio().get<List>(endPoint);

      final cityList = response.data
          .map<City>((json) => City.fromJson(json))
          .toList()
            ..sort(
                (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      return cityList;
    } on DioError {
      return Future.error("Falha ao obter lista de cidades da API");
    }
  }
}

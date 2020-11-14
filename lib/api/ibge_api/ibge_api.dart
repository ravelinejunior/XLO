import 'package:dio/dio.dart';
import 'package:olx_project_parse/models/uf.dart';

class IBGEApi {
  Future<List<UF>> getUFListFromApi() async {
    //receber o end point
    const endPoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados';
    try {
      //recuperar lista com estados em uma lista de respostas
      final response = await Dio().get<List>(endPoint);
      //recuperar e mapear resposta em formato json para formato model UF
      final ufList = response.data.map<UF>((json) => UF.fromJson(json)).toList()
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      return ufList;
    } on DioError {
      return Future.error("Falha ao obter lista de estados da API");
    }
  }

  getCityListFromApi() {
    const endPoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/municipios';
  }
}

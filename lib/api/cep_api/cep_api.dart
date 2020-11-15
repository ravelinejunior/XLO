import 'package:dio/dio.dart';
import 'package:olx_project_parse/api/ibge_api/ibge_api.dart';
import 'package:olx_project_parse/models/address.dart';
import 'package:olx_project_parse/models/city.dart';

class CepApi {
  Future<Address> getAddressFromApi(String cep) async {
    //tratar caso cep informado seja invalido
    if (cep == null || cep.isEmpty) return Future.error("CEP obrigátorio.");

    //formatar qualquer caracter que nao seja de 0 a 9 para ''
    final clearCep = cep.replaceAll(RegExp('[^0-9]'), '');
    if (clearCep.length != 8) return Future.error("CEP inválido");

    //recuperar endpoint
    final endPoint = 'https://viacep.com.br/ws/$clearCep/json';
    try {
      final response = await Dio().get<Map>(endPoint);

      //caso resposta do endpoint incorreta
      if (response.data.containsKey('erro') && response.data['erro'])
        return Future.error("CEP não existe.");

      final ufList = await IBGEApi().getUFListFromApi();

      return Address(
        cep: response.data['cep'],
        disctrict: response.data['bairro'],
        city: City(name: response.data['localidade']),
        uf: ufList.firstWhere((uf) => uf.initials == response.data['uf']),
      );
    } catch (e) {
      return Future.error("Erro ao buscar CEP. Tente novamente");
    }
  }
}

import 'dart:io';

import 'package:dio/dio.dart';


const token = "c376a2b57399b0a95a4167f004516f01";

class CepAbertoService {
  Future<void> getAddressFromCep(String cep) async {
    final cleanCep = cep.replaceAll('.', '').replaceAll('_', '');
    final endPoint = "https://www.cepaberto.com/api/v3/cep?cep=$cleanCep";
    final Dio dio = Dio();
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$token';

    try {
      final response = await dio.get<Map<String, dynamic>>(endPoint);
      if (response.data.isEmpty) {
        return Future.error('Cep invalido');
      }
      print(response.data);
      // final CepAbertoAddress address = CepAbertoAddress.fromMap(response.data);

      // return address;
    } on DioError catch (e) {
      return Future.error('Erro ao buscar CEP $e');
    }
  }
}

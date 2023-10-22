import 'dart:convert';

import 'package:dio_flutter_finalproject/model/ceps/viacep_model.dart';
import 'package:http/http.dart' as http;

class ViaCepRepository {
  Future<ViaCepModel> getCEP(String cep) async {
    var response =
        await http.get(Uri.parse("https://viacep.com.br/ws/$cep/json/"));
    if (response.statusCode == 200) {
      return ViaCepModel.fromViaCepJson(jsonDecode(response.body));
    } else {
      return ViaCepModel.empty();
    }
  }
}

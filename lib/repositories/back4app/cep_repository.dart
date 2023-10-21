import 'package:dio_flutter_finalproject/model/cep_model.dart';
import 'package:dio_flutter_finalproject/model/viacep_model.dart';
import 'package:dio_flutter_finalproject/repositories/back4app/cep_custom_dio.dart';

class CepRepository {
  final _customDio = CepCustomDio();

  CepRepository();

  Future<CepModel> getCeps(String uf) async {
    var url = "/CEP";

    if (uf.isNotEmpty) url = "$url?where={\"uf\":$uf}";

    var result = await _customDio.dio.get(url);
    return CepModel.fromJson(result.data);
  }

  Future<void> createCep(ViaCepModel cepModel) async {
    try {
      await _customDio.dio.post("/CEP", data: cepModel.toJsonEndpoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateCep(ViaCepModel cepModel) async {
    try {
      await _customDio.dio
          .put("/CEP/${cepModel.objectId}", data: cepModel.toJsonEndpoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCep(String objectId) async {
    try {
      await _customDio.dio.delete("/CEP/$objectId");
    } catch (e) {
      rethrow;
    }
  }
}

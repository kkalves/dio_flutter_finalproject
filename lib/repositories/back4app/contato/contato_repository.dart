import 'package:dio_flutter_finalproject/model/lista_contatos/contato_model.dart';
import 'package:dio_flutter_finalproject/model/lista_contatos/lista_contatos_model.dart';
import 'package:dio_flutter_finalproject/repositories/back4app/custom_dio.dart';

class ContatoRepository {
  final _customDio = Back4AppCustomDio();

  ContatoRepository();

  Future<ListaContatosModel> getListaContatos() async {
    var url = "/Contatos";

    // if (uf.isNotEmpty) url = "$url?where={\"uf\":$uf}";

    var result = await _customDio.dio.get(url);
    return ListaContatosModel.fromJson(result.data);
  }

  Future<void> createContato(ContatoModel contatoModel) async {
    try {
      await _customDio.dio
          .post("/Contatos", data: contatoModel.toJsonEndpoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateContato(ContatoModel contatoModel) async {
    try {
      await _customDio.dio.put("/Contatos/${contatoModel.objectId}",
          data: contatoModel.toJsonEndpoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteContato(String objectId) async {
    try {
      await _customDio.dio.delete("/Contatos/$objectId");
    } catch (e) {
      rethrow;
    }
  }
}

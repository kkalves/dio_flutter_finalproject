// ignore_for_file: unnecessary_getters_setters

import 'package:dio_flutter_finalproject/model/lista_contatos/contato_model.dart';

class ListaContatosModel {
  List<ContatoModel> _listaContatos = [];

  ListaContatosModel(this._listaContatos);

  ListaContatosModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      _listaContatos = <ContatoModel>[];
      json['results'].forEach((v) {
        _listaContatos.add(ContatoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = _listaContatos.map((v) => v.toJson()).toList();
    return data;
  }

  List<ContatoModel> get listaContatos => _listaContatos;
  set listaContatos(List<ContatoModel> listaContatos) =>
      _listaContatos = listaContatos;
}

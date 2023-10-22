// ignore_for_file: unnecessary_getters_setters


import 'package:dio_flutter_finalproject/model/ceps/viacep_model.dart';

class CepsModel {
  List<ViaCepModel> _ceps = [];

  CepsModel(this._ceps);

  List<ViaCepModel> get ceps => _ceps;
  set ceps(List<ViaCepModel> ceps) => _ceps = ceps;

  CepsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      _ceps = <ViaCepModel>[];
      json['results'].forEach((v) {
        _ceps.add(ViaCepModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = _ceps.map((v) => v.toJson()).toList();
    return data;
  }
}

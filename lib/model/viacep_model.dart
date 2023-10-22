// ignore_for_file: unnecessary_getters_setters

class ViaCepModel {
  String _objectId = "";
  String _cep = "";
  String _logradouro = "";
  String _complemento = "";
  String _bairro = "";
  String _localidade = "";
  String _uf = "";
  String _ibge = "";
  String _gia = "";
  String _ddd = "";
  String _siafi = "";
  String _createdAt = "";
  String _updatedAt = "";

  ViaCepModel(
      this._objectId,
      this._cep,
      this._logradouro,
      this._complemento,
      this._bairro,
      this._localidade,
      this._uf,
      this._ibge,
      this._gia,
      this._ddd,
      this._siafi,
      this._createdAt,
      this._updatedAt);

  ViaCepModel.build(
    this._cep,
    this._logradouro,
    this._complemento,
    this._bairro,
    this._localidade,
    this._uf,
    this._ibge,
    this._gia,
    this._ddd,
    this._siafi,
  );

  ViaCepModel.empty() {
    _objectId = "";
    _cep = "";
    _logradouro = "";
    _complemento = "";
    _bairro = "";
    _localidade = "";
    _uf = "";
    _ibge = "";
    _gia = "";
    _ddd = "";
    _siafi = "";
    _createdAt = "";
    _updatedAt = "";
  }

  ViaCepModel.fromJson(Map<String, dynamic> json) {
    _objectId = json['objectId'];
    _cep = json['cep'];
    _logradouro = json['logradouro'];
    _complemento = json['complemento'];
    _bairro = json['bairro'];
    _localidade = json['localidade'];
    _uf = json['uf'];
    _ibge = json['ibge'];
    _gia = json['gia'];
    _ddd = json['ddd'];
    _siafi = json['siafi'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  ViaCepModel.fromViaCepJson(Map<String, dynamic> json) {
    // _objectId = "";
    _cep = json['cep'] ?? "";
    _logradouro = json['logradouro'] ?? "";
    _complemento = json['complemento'] ?? "";
    _bairro = json['bairro'] ?? "";
    _localidade = json['localidade'] ?? "";
    _uf = json['uf'] ?? "";
    _ibge = json['ibge'] ?? "";
    _gia = json['gia'] ?? "";
    _ddd = json['ddd'] ?? "";
    _siafi = json['siafi'] ?? "";
    // _createdAt = "";
    // _updatedAt = "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = _objectId;
    data['cep'] = _cep;
    data['logradouro'] = _logradouro;
    data['complemento'] = _complemento;
    data['bairro'] = _bairro;
    data['localidade'] = _localidade;
    data['uf'] = _uf;
    data['ibge'] = _ibge;
    data['gia'] = _gia;
    data['ddd'] = _ddd;
    data['siafi'] = _siafi;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = _cep;
    data['logradouro'] = _logradouro;
    data['complemento'] = _complemento.isEmpty ? " " : _complemento;
    data['bairro'] = _bairro;
    data['localidade'] = _localidade;
    data['uf'] = _uf;
    data['ibge'] = _ibge;
    data['gia'] = _gia.isEmpty ? " " : _gia;
    data['ddd'] = _ddd;
    data['siafi'] = _siafi.isEmpty ? " " : _siafi;
    return data;
  }

  String get objectId => _objectId;
  set objectId(String objectId) => _objectId = objectId;
  String get cep => _cep;
  set cep(String cep) => _cep = cep;
  String get logradouro => _logradouro;
  set logradouro(String logradouro) => _logradouro = logradouro;
  String get complemento => _complemento;
  set complemento(String complemento) => _complemento = complemento;
  String get bairro => _bairro;
  set bairro(String bairro) => _bairro = bairro;
  String get localidade => _localidade;
  set localidade(String localidade) => _localidade = localidade;
  String get uf => _uf;
  set uf(String uf) => _uf = uf;
  String get ibge => _ibge;
  set ibge(String ibge) => _ibge = ibge;
  String get gia => _gia;
  set gia(String gia) => _gia = gia;
  String get ddd => _ddd;
  set ddd(String ddd) => _ddd = ddd;
  String get siafi => _siafi;
  set siafi(String siafi) => _siafi = siafi;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;
}

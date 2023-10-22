// ignore_for_file: unnecessary_getters_setters

class ContatoModel {
  String _objectId = "";
  String _nome = "";
  String _dataNascimento = "";
  String _cpf = "";
  String _cep = "";
  String _email = "";
  String _imagem = "";
  String _createdAt = "";
  String _updatedAt = "";

  ContatoModel(this._objectId, this._nome, this._dataNascimento, this._cpf,
      this._cep, this._email, this._imagem, this._createdAt, this._updatedAt);

  ContatoModel.build(this._nome, this._dataNascimento, this._cpf, this._cep,
      this._email, this._imagem);

  ContatoModel.empty() {
    _objectId = "";
    _nome = "";
    _dataNascimento = "";
    _cpf = "";
    _cep = "";
    _email = "";
    _imagem = "";
    _createdAt = "";
    _updatedAt = "";
  }

  ContatoModel.fromJson(Map<String, dynamic> json) {
    _objectId = json['objectId'];
    _nome = json['nome'];
    _dataNascimento = json['dataNascimento'];
    _cpf = json['CPF'];
    _cep = json['CEP'];
    _email = json['email'];
    _imagem = json['imagem'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = _objectId;
    data['nome'] = _nome;
    data['dataNascimento'] = _dataNascimento;
    data['CPF'] = _cpf;
    data['CEP'] = _cep;
    data['email'] = _email;
    data['imagem'] = _imagem;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = _nome;
    data['dataNascimento'] = _dataNascimento;
    data['CPF'] = _cpf;
    data['CEP'] = _cep;
    data['email'] = _email;
    data['imagem'] = _imagem;
    return data;
  }

  String get objectId => _objectId;
  set objectId(String objectId) => _objectId = objectId;
  String get nome => _nome;
  set nome(String nome) => _nome = nome;
  String get dataNascimento => _dataNascimento;
  set dataNascimento(String dataNascimento) => _dataNascimento = dataNascimento;
  String get cpf => _cpf;
  set cPF(String cpf) => _cpf = cpf;
  String get cep => _cep;
  set cEP(String cep) => _cep = cep;
  String get email => _email;
  set email(String email) => _email = email;
  String get imagem => _imagem;
  set imagem(String imagem) => _imagem = imagem;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;
}

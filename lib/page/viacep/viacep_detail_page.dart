import 'package:dio_flutter_finalproject/model/viacep_model.dart';
import 'package:dio_flutter_finalproject/repositories/back4app/cep_repository.dart';
import 'package:flutter/material.dart';

class ViaCepDetailPage extends StatelessWidget {
  final CepRepository cepRepository;
  final ViaCepModel cepmodel;
  const ViaCepDetailPage(
      {super.key, required this.cepRepository, required this.cepmodel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Detalhes do CEP: ${cepmodel.cep}"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(cepmodel.cep),
            Text(cepmodel.logradouro),
            Text(cepmodel.bairro),
            Text(cepmodel.complemento),
            Text(cepmodel.localidade),
            Text(cepmodel.uf),
            Text(cepmodel.ibge),
            Text(cepmodel.gia),
            Text(cepmodel.ddd),
            Text(cepmodel.siafi),
            Text(cepmodel.createdAt),
            Text(cepmodel.updatedAt),
          ],
        ),
      ),
    );
  }
}

import 'package:dio_flutter_finalproject/model/viacep_model.dart';
import 'package:dio_flutter_finalproject/repositories/back4app/cep_repository.dart';
import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  final CepRepository cepRepository;
  final ViaCepModel cepmodel;
  const CustomBottomAppBar(
      {super.key, required this.cepRepository, required this.cepmodel});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          IconButton.filled(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                  Theme.of(context).colorScheme.inversePrimary),
            ),
            color: Theme.of(context).colorScheme.secondary,
            tooltip: 'Editar',
            icon: const Icon(Icons.edit),
            onPressed: () {
              print(cepmodel.cep);
            },
          ),
          IconButton.filled(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                  Theme.of(context).colorScheme.inversePrimary),
            ),
            color: Theme.of(context).colorScheme.secondary,
            tooltip: 'Remover',
            icon: const Icon(Icons.delete),
            onPressed: () {
              print(cepmodel.logradouro);
            },
          ),
        ],
      ),
    );
  }
}

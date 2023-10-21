import 'package:dio_flutter_finalproject/model/ceps_model.dart';
import 'package:dio_flutter_finalproject/model/viacep_model.dart';
import 'package:dio_flutter_finalproject/page/viacep/viacep_detail_page.dart';
import 'package:dio_flutter_finalproject/repositories/back4app/cep_repository.dart';
import 'package:dio_flutter_finalproject/shared/widget/custom_bottom_appbar.dart';
import 'package:dio_flutter_finalproject/shared/widget/custom_rich_text.dart';
import 'package:flutter/material.dart';

class ViaCepPage extends StatefulWidget {
  const ViaCepPage({super.key});

  @override
  State<ViaCepPage> createState() => _ViaCepPageState();
}

class _ViaCepPageState extends State<ViaCepPage> {
  CepRepository _cepRepository = CepRepository();
  var _cepsModel = CepsModel([]);

  TextEditingController cepController = TextEditingController(text: "");
  final ScrollController _scrollController = ScrollController();

  bool isLoading = false;

  void loadCeps() async {
    setState(() {
      isLoading = true;
    });
    _cepsModel = await _cepRepository.getCeps();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadCeps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const Icon(
          Icons.person_pin,
        ),
        title: const Text("Consumo da API do ViaCEP"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: isLoading
          ? const CircularProgressIndicator()
          : ListView.builder(
              controller: _scrollController,
              itemCount: _cepsModel.ceps.length,
              itemBuilder: (context, index) {
                var cepItem = _cepsModel.ceps[index];
                return Column(
                  children: [
                    ListTile(
                      key: Key(cepItem.objectId),
                      leading: Icon(
                        Icons.location_pin,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomRichText(
                            title: "Logradouro: ",
                            text: cepItem.logradouro,
                          ),
                          Row(
                            children: [
                              CustomRichText(
                                title: "Bairro: ",
                                text: cepItem.bairro,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomRichText(
                                title: "CEP: ",
                                text: cepItem.cep,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CustomRichText(
                                title: "Cidade: ",
                                text: cepItem.localidade,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomRichText(
                                title: "UF: ",
                                text: cepItem.uf,
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViaCepDetailPage(
                                  cepRepository: _cepRepository,
                                  cepmodel: cepItem),
                            ));
                      },
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                    )
                  ],
                );
              },
            ),
      floatingActionButton: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        child: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).colorScheme.primary,
          label: Text(
            "Cadastrar CEP",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
          onPressed: () {},
          tooltip: 'Cadastrar CEP',
          icon: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}

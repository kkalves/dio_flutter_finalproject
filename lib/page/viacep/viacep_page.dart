import 'package:dio_flutter_finalproject/model/ceps/ceps_model.dart';
import 'package:dio_flutter_finalproject/model/ceps/viacep_model.dart';
import 'package:dio_flutter_finalproject/page/viacep/viacep_create_page.dart';
import 'package:dio_flutter_finalproject/page/viacep/viacep_detail_page.dart';
import 'package:dio_flutter_finalproject/repositories/back4app/cep/cep_repository.dart';
import 'package:dio_flutter_finalproject/shared/widget/custom_rich_text.dart';
import 'package:flutter/material.dart';

class ViaCepPage extends StatefulWidget {
  const ViaCepPage({super.key});

  @override
  State<ViaCepPage> createState() => _ViaCepPageState();
}

class _ViaCepPageState extends State<ViaCepPage> {
  final CepRepository _cepRepository = CepRepository();
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
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const Icon(
          Icons.person_pin,
        ),
        title: const Text("Consumo da API do ViaCEP"),
        backgroundColor: themeData.colorScheme.inversePrimary,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
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
                        color: themeData.colorScheme.primary,
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: themeData.colorScheme.primary,
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
                      onTap: () async {
                        await _navigateAndDisplayDetailPage(
                            context, themeData, cepItem);

                        loadCeps();
                        setState(() {});
                      },
                    ),
                    Divider(
                      color: themeData.colorScheme.surfaceVariant,
                    )
                  ],
                );
              },
            ),
      floatingActionButton: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        child: FloatingActionButton.extended(
          backgroundColor: themeData.colorScheme.primary,
          label: Text(
            "Cadastrar CEP",
            style: themeData.textTheme.titleMedium!
                .copyWith(color: themeData.colorScheme.onPrimary),
          ),
          onPressed: () async {
            await _navigateAndDisplayCreatePage(context, themeData);
            loadCeps();
            setState(() {});
          },
          tooltip: 'Cadastrar CEP',
          icon: Icon(Icons.add, color: themeData.colorScheme.onPrimary),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      bottomNavigationBar: const BottomAppBar(
        height: 70,
      ),
    );
  }

  Future<void> _navigateAndDisplayCreatePage(
      BuildContext context, ThemeData themeData) async {
    final viaCepModel = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const ViaCepCreatePage(),
          settings: RouteSettings(arguments: _cepsModel)),
    );

    if (viaCepModel == null) return;

    setState(() {
      isLoading = true;
    });

    await _cepRepository.createCep(viaCepModel);

    setState(() {
      isLoading = false;
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 2000),
          dismissDirection: DismissDirection.down,
          backgroundColor: Color(Colors.green.value),
          content: Text(
            "CEP cadastrado com Sucesso!",
            style: themeData.textTheme.titleMedium!
                .copyWith(color: themeData.colorScheme.onPrimary),
          )));
  }

  Future<void> _navigateAndDisplayDetailPage(
      BuildContext context, ThemeData themeData, ViaCepModel cepItem) async {
    final results = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViaCepDetailPage(cepModel: cepItem)));

    if (results == null) return;

    if (results[1]) {
      await _cepRepository.deleteCep((results[0] as ViaCepModel).objectId);

      if (!mounted) return;

      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
            duration: const Duration(milliseconds: 2000),
            dismissDirection: DismissDirection.down,
            backgroundColor: Color(Colors.green.value),
            content: Text(
              "Cep Removido com Sucesso!",
              style: themeData.textTheme.titleMedium!
                  .copyWith(color: themeData.colorScheme.onPrimary),
            )));
    } else {
      await _cepRepository.updateCep(results[0]);

      if (!mounted) return;

      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
            duration: const Duration(milliseconds: 2000),
            dismissDirection: DismissDirection.down,
            backgroundColor: Color(Colors.green.value),
            content: Text(
              "Cep Atualizado com Sucesso!",
              style: themeData.textTheme.titleMedium!
                  .copyWith(color: themeData.colorScheme.onPrimary),
            )));
    }
  }
}

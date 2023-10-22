import 'package:dio_flutter_finalproject/model/ceps_model.dart';
import 'package:dio_flutter_finalproject/model/viacep_model.dart';
import 'package:dio_flutter_finalproject/repositories/viacep_repository.dart';
import 'package:dio_flutter_finalproject/shared/widget/custom_rich_text.dart';
import 'package:flutter/material.dart';

class ViaCepCreatePage extends StatefulWidget {
  const ViaCepCreatePage({super.key});

  @override
  State<ViaCepCreatePage> createState() => _ViaCepCreatePageState();
}

class _ViaCepCreatePageState extends State<ViaCepCreatePage> {
  var viaCepRepository = ViaCepRepository();
  var viaCepModel = ViaCepModel.empty();

  late TextEditingController _cepController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _cepController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    _cepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cepsModel = ModalRoute.of(context)!.settings.arguments as CepsModel;
    final ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.close,
                  color: themeData.colorScheme.onPrimaryContainer),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text("Cadastrar novo CEP",
                style:
                    TextStyle(color: themeData.colorScheme.onPrimaryContainer)),
            backgroundColor: themeData.colorScheme.inversePrimary,
          ),
          body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _cepController,
                            maxLength: 8,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.location_pin,
                                  color: themeData.colorScheme.primary,
                                ),
                                hintText: "Informe o CEP",
                                label: Text("CEP: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: themeData.colorScheme.primary)),
                                helperText: "Informe apenas números"),
                            onChanged: (value) async {
                              var cep = value.replaceAll(RegExp(r'[^0-9]'), '');
                              if (cep.length == 8) {
                                setState(() {
                                  isLoading = true;
                                });
                                viaCepModel =
                                    await viaCepRepository.getCEP(cep);
                                if (viaCepModel.cep.isEmpty) {
                                  if (!mounted) return;

                                  _showErrorMessage(
                                      context,
                                      themeData,
                                      "CEP não encontrado!",
                                      "O CEP: $cep não foi encontrado! \n\nPor favor, verifique se o CEP informado é um cep válido existente.");
                                }
                              } else {
                                viaCepModel = ViaCepModel.empty();
                              }
                              setState(() {
                                isLoading = false;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          (isLoading)
                              ? const Center(child: CircularProgressIndicator())
                              : _showCepInformation(),
                        ]),
                    const SizedBox(
                      height: 30,
                    ),
                    FilledButton(
                        onPressed: () {
                          if (_fieldValidation(themeData, cepsModel)) {
                            print("Cadastrar");
                            Navigator.pop(context, viaCepModel);
                          } else {
                            return;
                          }
                        },
                        child: const Text("Salvar"))
                  ],
                )),
          )),
    );
  }

  bool _fieldValidation(ThemeData themeData, CepsModel cepsModel) {
    if (viaCepModel.cep.isEmpty) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
            duration: const Duration(milliseconds: 2000),
            dismissDirection: DismissDirection.down,
            backgroundColor: themeData.colorScheme.error,
            content: Text(
              "Informe um cep para cadastrar!",
              style: themeData.textTheme.titleMedium!
                  .copyWith(color: themeData.colorScheme.onError),
            )));
      return false;
    }
    for (var cepItem in cepsModel.ceps) {
      if (cepItem.cep == viaCepModel.cep) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
              duration: const Duration(milliseconds: 2000),
              dismissDirection: DismissDirection.down,
              backgroundColor: themeData.colorScheme.error,
              content: Text(
                "O CEP: ${cepItem.cep} já está cadastrado!",
                style: themeData.textTheme.titleMedium!
                    .copyWith(color: themeData.colorScheme.onError),
              )));
        return false;
      }
    }
    return true;
  }

  _showErrorMessage(
      BuildContext context, ThemeData themeData, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: themeData.colorScheme.errorContainer,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.error,
                color: themeData.colorScheme.error,
              ),
              Text(
                title,
                style: TextStyle(
                    color: themeData.colorScheme.error,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Wrap(children: [
            Divider(color: themeData.colorScheme.onErrorContainer),
            const SizedBox(
              height: 10,
            ),
            Text(message,
                style: themeData.textTheme.bodyLarge!.copyWith(
                    color: themeData.colorScheme.onErrorContainer,
                    fontWeight: FontWeight.bold))
          ]),
          actions: [
            FilledButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(themeData.colorScheme.error)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK!'),
            ),
          ],
        );
      },
    );
  }

  _showCepInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomRichText(title: "CEP:", text: viaCepModel.cep),
        CustomRichText(title: "Logradouro:", text: viaCepModel.logradouro),
        CustomRichText(title: "Bairro:", text: viaCepModel.bairro),
        CustomRichText(title: "Complemento:", text: viaCepModel.complemento),
        CustomRichText(title: "Localidade:", text: viaCepModel.localidade),
        CustomRichText(title: "UF:", text: viaCepModel.uf),
        CustomRichText(title: "IBGE:", text: viaCepModel.ibge),
        CustomRichText(title: "GIA:", text: viaCepModel.gia),
        CustomRichText(title: "DDD:", text: viaCepModel.ddd),
        CustomRichText(title: "SIAFI:", text: viaCepModel.siafi),
      ],
    );
  }
}

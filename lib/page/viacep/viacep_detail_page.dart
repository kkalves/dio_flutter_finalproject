import 'package:dio_flutter_finalproject/model/viacep_model.dart';
import 'package:flutter/material.dart';

class ViaCepDetailPage extends StatefulWidget {
  const ViaCepDetailPage({
    super.key,
    required ViaCepModel cepModel,
  }) : _cepModel = cepModel;
  final ViaCepModel _cepModel;

  @override
  State<ViaCepDetailPage> createState() => _ViaCepDetailPageState();
}

class _ViaCepDetailPageState extends State<ViaCepDetailPage> {
  late ViaCepModel cepModel = widget._cepModel;
  TextEditingController logradouroController = TextEditingController(text: "");
  TextEditingController bairroController = TextEditingController(text: "");
  TextEditingController complementoController = TextEditingController(text: "");
  TextEditingController localidadeController = TextEditingController(text: "");
  TextEditingController ufController = TextEditingController(text: "");
  TextEditingController ibgeController = TextEditingController(text: "");
  TextEditingController giaController = TextEditingController(text: "");
  TextEditingController dddController = TextEditingController(text: "");
  TextEditingController siafiController = TextEditingController(text: "");
  bool isUpdate = false;

  @override
  void initState() {
    super.initState();
    cepModel = widget._cepModel;
    setControllersInitialValue();
  }

  setControllersInitialValue() {
    logradouroController.text = cepModel.logradouro;
    bairroController.text = cepModel.bairro;
    complementoController.text = cepModel.complemento;
    localidadeController.text = cepModel.localidade;
    ufController.text = cepModel.uf;
    ibgeController.text = cepModel.ibge;
    giaController.text = cepModel.gia;
    dddController.text = cepModel.ddd;
    siafiController.text = cepModel.siafi;
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text(
            "Detalhes do CEP: ${cepModel.cep}",
            style: TextStyle(color: themeData.colorScheme.onPrimaryContainer),
          ),
          backgroundColor: themeData.colorScheme.inversePrimary,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  isUpdate
                      ? _showCepInformation(cepModel, true, themeData)
                      : _showCepInformation(cepModel, false, themeData),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Visibility(
                        visible: isUpdate,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancelar",
                              style: themeData.textTheme.titleMedium!.copyWith(
                                  color: themeData.colorScheme.primary),
                            )),
                      ),
                      FilledButton(
                          onPressed: () {
                            if (!isUpdate) {
                              setState(() {
                                isUpdate = true;
                              });
                              return;
                            } else {
                              if (_fieldValidation(themeData, cepModel)) {
                                cepModel.logradouro = logradouroController.text;
                                cepModel.bairro = bairroController.text;
                                cepModel.complemento =
                                    complementoController.text;
                                cepModel.localidade = localidadeController.text;
                                cepModel.uf = ufController.text;
                                cepModel.ibge = ibgeController.text;
                                cepModel.gia = giaController.text;
                                cepModel.ddd = dddController.text;
                                cepModel.siafi = siafiController.text;
                                Navigator.pop(context, [cepModel, false]);
                              } else {
                                return;
                              }
                            }
                          },
                          child: isUpdate
                              ? Row(
                                  children: [
                                    Icon(Icons.save,
                                        color: themeData.colorScheme.onPrimary),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Salvar",
                                      style: themeData.textTheme.titleMedium!
                                          .copyWith(
                                              color: themeData
                                                  .colorScheme.onPrimary),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Icon(Icons.save,
                                        color: themeData.colorScheme.onPrimary),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Editar",
                                      style: themeData.textTheme.titleMedium!
                                          .copyWith(
                                              color: themeData
                                                  .colorScheme.onPrimary),
                                    ),
                                  ],
                                )),
                      Visibility(
                        visible: !isUpdate,
                        child: FilledButton(
                            onPressed: () async {
                              setState(() {
                                isUpdate = false;
                              });

                              Navigator.pop(context, [cepModel, true]);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.delete,
                                    color: themeData.colorScheme.onPrimary),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Remover",
                                  style: themeData.textTheme.titleMedium!
                                      .copyWith(
                                          color:
                                              themeData.colorScheme.onPrimary),
                                ),
                              ],
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showCepInformation(
      ViaCepModel cepModel, bool isEnabled, ThemeData themeData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: logradouroController,
          enabled: isEnabled,
          decoration: InputDecoration(
              hintText: "Logradouro",
              label: Text(
                "Logradouro",
                style: TextStyle(color: themeData.colorScheme.primary),
              )),
          onChanged: (value) {
            logradouroController.text = value;
          },
        ),
        TextField(
          controller: bairroController,
          enabled: isEnabled,
          decoration: InputDecoration(
              hintText: "Bairro",
              label: Text(
                "Bairro",
                style: TextStyle(color: themeData.colorScheme.primary),
              )),
          onChanged: (value) {
            bairroController.text = value;
          },
        ),
        TextField(
          controller: complementoController,
          enabled: isEnabled,
          decoration: InputDecoration(
              hintText: "Complemento",
              label: Text(
                "Complemento",
                style: TextStyle(color: themeData.colorScheme.primary),
              )),
          onChanged: (value) {
            complementoController.text = value;
          },
        ),
        TextField(
          controller: localidadeController,
          enabled: isEnabled,
          decoration: InputDecoration(
              hintText: "Localidade",
              label: Text(
                "Localidade",
                style: TextStyle(color: themeData.colorScheme.primary),
              )),
          onChanged: (value) {
            localidadeController.text = value;
          },
        ),
        TextField(
          controller: ufController,
          enabled: isEnabled,
          decoration: InputDecoration(
              hintText: "UF",
              label: Text(
                "UF",
                style: TextStyle(color: themeData.colorScheme.primary),
              )),
          onChanged: (value) {
            ufController.text = value;
          },
        ),
        TextField(
          controller: ibgeController,
          enabled: isEnabled,
          decoration: InputDecoration(
              hintText: "IBGE",
              label: Text(
                "IBGE",
                style: TextStyle(color: themeData.colorScheme.primary),
              )),
          onChanged: (value) {
            ibgeController.text = value;
          },
        ),
        TextField(
          controller: giaController,
          enabled: isEnabled,
          decoration: InputDecoration(
              hintText: "GIA",
              label: Text(
                "GIA",
                style: TextStyle(color: themeData.colorScheme.primary),
              )),
          onChanged: (value) {
            giaController.text = value;
          },
        ),
        TextField(
          controller: dddController,
          enabled: isEnabled,
          decoration: InputDecoration(
              hintText: "DDD",
              label: Text(
                "DDD",
                style: TextStyle(color: themeData.colorScheme.primary),
              )),
          onChanged: (value) {
            dddController.text = value;
          },
        ),
        TextField(
          controller: siafiController,
          enabled: isEnabled,
          decoration: InputDecoration(
              hintText: "SIAFI",
              label: Text(
                "SIAFI",
                style: TextStyle(color: themeData.colorScheme.primary),
              )),
          onChanged: (value) {
            siafiController.text = value;
          },
        ),
      ],
    );
  }

  bool _fieldValidation(ThemeData themeData, ViaCepModel viaCepModel) {
    if (logradouroController.text.isEmpty ||
        bairroController.text.isEmpty ||
        complementoController.text.isEmpty ||
        localidadeController.text.isEmpty ||
        ufController.text.isEmpty ||
        ibgeController.text.isEmpty ||
        giaController.text.isEmpty ||
        dddController.text.isEmpty ||
        siafiController.text.isEmpty) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
            duration: const Duration(milliseconds: 2000),
            dismissDirection: DismissDirection.down,
            backgroundColor: themeData.colorScheme.error,
            content: Text(
              "Os Campos não podem ser vazios!",
              style: themeData.textTheme.titleMedium!
                  .copyWith(color: themeData.colorScheme.onError),
            )));
      return false;
    }
    return true;
  }
}

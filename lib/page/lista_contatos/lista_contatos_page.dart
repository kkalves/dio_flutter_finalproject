import 'package:dio_flutter_finalproject/model/lista_contatos/lista_contatos_model.dart';
import 'package:dio_flutter_finalproject/repositories/back4app/contato/contato_repository.dart';
import 'package:dio_flutter_finalproject/shared/widget/custom_rich_text.dart';
import 'package:flutter/material.dart';

class ListaContatosPage extends StatefulWidget {
  const ListaContatosPage({super.key});

  @override
  State<ListaContatosPage> createState() => _ListaContatosPageState();
}

class _ListaContatosPageState extends State<ListaContatosPage> {
  final ContatoRepository _contatoRepository = ContatoRepository();
  ListaContatosModel _listaContatosModel = ListaContatosModel([]);

  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    loadContatos();
    super.initState();
  }

  loadContatos() async {
    setState(() {
      isLoading = true;
    });
    _listaContatosModel = await _contatoRepository.getListaContatos();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: const Icon(
            Icons.contact_phone,
          ),
          title: const Text("Lista de Contatos"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                controller: _scrollController,
                itemCount: _listaContatosModel.listaContatos.length,
                itemBuilder: (context, index) {
                  var contato = _listaContatosModel.listaContatos[index];
                  return Column(
                    children: [
                      ListTile(
                        key: Key(contato.objectId),
                        leading: CircleAvatar(),
                        trailing: PopupMenuButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: themeData.colorScheme.primary,
                          ),
                          onSelected: (value) {
                            debugPrint(value);
                          },
                          itemBuilder: (context) => <PopupMenuEntry>[
                            PopupMenuItem(
                              value: 'update',
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Editar',
                                    style: themeData.textTheme.bodyLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color:
                                                themeData.colorScheme.primary),
                                  ),
                                  Icon(Icons.edit,
                                      color: themeData.colorScheme.primary)
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Text('Remover',
                                      style: themeData.textTheme.bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: themeData
                                                  .colorScheme.primary)),
                                  Icon(Icons.delete,
                                      color: themeData.colorScheme.primary)
                                ],
                              ),
                            ),
                          ],
                        ),
                        title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomRichText(
                                title: "Nome: ",
                                text: contato.nome,
                              ),
                              Text(
                                contato.email,
                                style: themeData.textTheme.bodyLarge!.copyWith(
                                    color: themeData.colorScheme.primary),
                              )
                            ]),
                      )
                    ],
                  );
                },
              ));
  }
}

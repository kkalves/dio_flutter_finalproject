import 'package:flutter/material.dart';

class ViaCepPage extends StatefulWidget {
  const ViaCepPage({super.key});

  @override
  State<ViaCepPage> createState() => _ViaCepPageState();
}

class _ViaCepPageState extends State<ViaCepPage> {
  late ScrollController _scrollController;
  bool _isVisible = true;
  bool _isSelected = false;

  FloatingActionButtonLocation get _fabLocation => _isVisible
      ? FloatingActionButtonLocation.endContained
      : FloatingActionButtonLocation.endFloat;

  void _listen() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _show();
    } else {
      _hide();
    }
  }

  void _show() {
    if (!_isVisible) {
      setState(() => _isVisible = true);
    }
  }

  void _hide() {
    if (_isVisible) {
      setState(() => _isVisible = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_listen);
  }

  // FloatingActionButtonLocation _fabLocation =
  //     FloatingActionButtonLocation.endDocked;
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
        body: ListView(
          controller: _scrollController,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Adicionar CEP',
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: _fabLocation,
        bottomNavigationBar: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: _isSelected ? const _CustomBottomAppBar() : null,
        )
        //     BottomAppBar(
        //   shape: shape,
        //   color: Colors.blue,
        //   child: IconTheme(
        //     data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        //     child: Row(
        //       children: <Widget>[
        //         IconButton(
        //           tooltip: 'Open navigation menu',
        //           icon: const Icon(Icons.menu),
        //           onPressed: () {},
        //         ),
        //         if (centerLocations.contains(fabLocation)) const Spacer(),
        //         IconButton(
        //           tooltip: 'Search',
        //           icon: const Icon(Icons.search),
        //           onPressed: () {},
        //         ),
        //         IconButton(
        //           tooltip: 'Favorite',
        //           icon: const Icon(Icons.favorite),
        //           onPressed: () {},
        //         ),
        //       ],
        //     ),
        //   ),
        // );
        //  _DemoBottomAppBar(
        //   fabLocation: _fabLocation,
        //   shape: _showNotch ? const CircularNotchedRectangle() : null,
        // ),
        // ),
        );
  }
}

class _CustomBottomAppBar extends StatelessWidget {
  const _CustomBottomAppBar();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          IconButton(
            tooltip: 'Editar',
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
          IconButton(
            tooltip: 'Remover',
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

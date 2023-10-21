import 'package:dio_flutter_finalproject/page/viacep/viacep_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController = PageController(initialPage: 0);
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentPageIndex = value;
                  });
                },
                children: [
                  const ViaCepPage(),
                  Container(),
                ],
              ),
            ),
            BottomNavigationBar(
                // type: BottomNavigationBarType.fixed,
                onTap: (value) {
                  pageController.jumpToPage(value);
                },
                currentIndex: currentPageIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person_pin,
                      ),
                      label: "Via Cep"),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.contact_phone,
                      ),
                      label: "Lista de Contatos"),
                ]),
          ],
        ));
  }
}

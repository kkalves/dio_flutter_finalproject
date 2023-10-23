// import 'package:dio_flutter_finalproject/page/main_page.dart';
import 'package:dio_flutter_finalproject/page/splash_page.dart';
import 'package:flutter/material.dart';

class FinalProjectApp extends StatelessWidget {
  const FinalProjectApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}

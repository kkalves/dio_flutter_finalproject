import 'package:dio_flutter_finalproject/page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              themeData.colorScheme.primary,
              themeData.colorScheme.onPrimaryContainer
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/icon/icon.png", height: 150),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Projeto",
                    style: GoogleFonts.audiowide(
                        textStyle: themeData.textTheme.displayLarge,
                        color: themeData.colorScheme.onPrimary),
                  ),
                  Text(
                    "DIO",
                    style: GoogleFonts.audiowide(
                        textStyle: themeData.textTheme.displayLarge,
                        color: themeData.colorScheme.onPrimary),
                  ),
                ],
              ),
            ),
            CircularPercentIndicator(
              animateFromLastPercent: true,
              radius: 50.0,
              lineWidth: 8.0,
              percent: 1,
              backgroundColor: themeData.colorScheme.onPrimaryContainer,
              progressColor: themeData.colorScheme.onPrimary,
              circularStrokeCap: CircularStrokeCap.round,
              animation: true,
              animationDuration: 5000,
              onAnimationEnd: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainPage(),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}

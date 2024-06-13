import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(const Duration(seconds: 6), () {
      Navigator.pushNamed(context, '/views');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:LottieBuilder.network('https://lottie.host/98a8785a-1d3f-4308-a025-2af14479ff09/1mfFTVJohD.json')),
    );
  }
}

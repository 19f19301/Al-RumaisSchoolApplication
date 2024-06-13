import 'package:flutter/material.dart';
import 'package:school/router/go_router.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
       routerConfig:  AppNavigation.router,
    );
  }
}
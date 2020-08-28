import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:esempio_login/repositories/Repository.dart';

import 'package:esempio_login/screens/auth/LoginPage.dart';
import 'package:esempio_login/screens/auth/SplashPage.dart';
import 'package:esempio_login/screens/home/HomePage.dart';

final getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<Repository>(Repository());

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => SplashPage(),
        '/login': (_) => LoginPage(),
        '/home': (_) => HomePage(),
      },
    );
  }
}

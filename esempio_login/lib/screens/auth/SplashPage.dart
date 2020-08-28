import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:esempio_login/repositories/Repository.dart';

import 'package:esempio_login/main.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await getIt.get<Repository>().session.init();
      bool isUserLogged = getIt.get<Repository>().session.isUserLogged();

      if (isUserLogged)
        await Navigator.pushNamed(context, "/home");
      else
        await Navigator.pushNamed(context, "/login");

      // Instead of using a Navigator.popAndPushNamed we are popping after the new screen
      // has been launched. This is done because otherwise the user will see a black
      // screen transictioning instead of this once, since the pop occurs before the pushNamed.
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

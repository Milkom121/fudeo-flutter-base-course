import 'package:flutter/material.dart';

import 'package:ansa/components/app_scaffold.dart';
import 'package:ansa/pages/home.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      home: HomePage(),
    );
  }
}

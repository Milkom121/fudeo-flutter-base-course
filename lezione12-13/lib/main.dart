import 'package:flutter/material.dart';
import './home.dart';
import './state.dart';

void main() {
  runApp(StateWidget(child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget buildHome() {
    final state = StateWidget.of(context).state;
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return MyHomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StateWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: buildHome(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_lezione12/state.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_lezione12/forecast.dart';

class NewCityPage extends StatefulWidget {
  @override
  _NewCityPageState createState() => _NewCityPageState();
}

class _NewCityPageState extends State<NewCityPage> {
  final TextEditingController _textController = TextEditingController();

  Future<Forecast> downloadData(String cityName) async {
    final response = await http.get(
        "http://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=ac941f1a4b5a26e1fb6a10e0659e11f1");
    return Forecast.fromData(json.decode(response.body));
  }

  void save() async {
    String cityName = _textController.text.trim();

    if (cityName.isNotEmpty) {
      Forecast forecast = await downloadData(cityName);
      StateWidget.of(context).addForecast(forecast);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: save,
            icon: Icon(Icons.check),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: TextField(controller: _textController, decoration: InputDecoration(hintText: "City Name")),
      ),
    );
  }
}

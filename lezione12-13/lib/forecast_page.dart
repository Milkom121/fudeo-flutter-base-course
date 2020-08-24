import 'package:flutter/material.dart';
import 'package:flutter_lezione12/forecast.dart';

class ForecastPage extends StatelessWidget {
  ForecastPage({
    this.forecast
  });
  final Forecast forecast;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  forecast.cityName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12,),
                Text(
                  forecast.temperature.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12,),
                Text(
                  forecast.condition,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        )
    );
  }
}
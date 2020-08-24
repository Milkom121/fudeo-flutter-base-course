import 'package:flutter/material.dart';
import 'package:flutter_lezione12/state.dart';
import 'package:flutter_lezione12/city_new.dart';
import 'package:flutter_lezione12/forecast_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildCitySelector(),
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemCount: StateWidget.of(context).state.forecasts.length,
                itemBuilder: (context, index) {
                  return ForecastPage(forecast: StateWidget.of(context).state.forecasts[index]);
                },
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget buildCitySelector() {
    return Container(
      height: 27,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: StateWidget.of(context).state.forecasts.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                      color: _currentPageIndex == index ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    StateWidget.of(context).state.forecasts[index].cityName,
                    style: TextStyle(
                        color: _currentPageIndex == index ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: 8);
              },
            ),
          ),
          IconButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewCityPage()));
            },
            icon: Icon(Icons.add_box),
          )
        ],
      ),
    );
  }
}

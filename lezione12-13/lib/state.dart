import 'package:flutter/material.dart';
import './forecast.dart';
import './db.dart';

class ModelState {
  ModelState({
    this.isLoading = false,
    this.forecasts,
  });

  bool isLoading;
  List<Forecast> forecasts;
}

class StateWidget extends StatefulWidget {
  final Widget child;

  StateWidget({
    @required this.child,
  });

  static StateWidgetState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_StateDataWidget) as _StateDataWidget).data;
  }

  @override
  StateWidgetState createState() => StateWidgetState();
}

class StateWidgetState extends State<StateWidget> {
  ModelState state;
  ForecastProvider forecastProvider;

  @override
  void initState() {
    super.initState();

    state = ModelState(isLoading: true);
    loadData();
  }

  void loadData() async {
    final db = await openConnection();
    this.forecastProvider = ForecastProvider(db);

    //await Future.delayed(Duration(seconds: 1));

    List<Forecast> forecasts = await forecastProvider.all();

    setState(() {
      state.forecasts = forecasts;
      state.isLoading = false;
    });
  }

  void addForecast(Forecast forecast) {
    forecastProvider.create(
        forecast.cityName, forecast.condition, forecast.temperature, forecast.wind, forecast.humidity);

    setState(() {
      state.forecasts.add(forecast);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new _StateDataWidget(
      data: this,
      child: widget.child,
    );
  }
}

class _StateDataWidget extends InheritedWidget {
  final StateWidgetState data;

  _StateDataWidget({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_StateDataWidget old) => true;
}

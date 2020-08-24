class Forecast{

  Forecast({
    this.cityName,
    this.condition,
    this.temperature,
    this.wind,
    this.humidity,
  });

  final String cityName;
  final String condition;
  final double temperature;
  final double wind;
  final int humidity;

  factory Forecast.fromData(dynamic data){
    final cityName = data["name"];
    final condition = data["weather"][0]["main"];
    final temperature = data["main"]["temp"];
    final wind = data["wind"]["speed"];
    final humidity = data["main"]["humidity"];

    return Forecast(
      cityName: cityName,
      condition: condition,
      temperature: temperature,
      wind: wind,
      humidity: humidity,
    );
  }

  factory Forecast.fromRow(dynamic data){
    final cityName = data["cityName"];
    final condition = data["condition"];
    final temperature = data["temperature"];
    final wind = data["wind"];
    final humidity = data["humidity"];

    return Forecast(
      cityName: cityName,
      condition: condition,
      temperature: temperature,
      wind: wind,
      humidity: humidity,
    );
  }
}
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_lezione12/forecast.dart';

Future<Database> openConnection() async {
  var databasePath = await getDatabasesPath();
  String path = join(databasePath, 'forecast.db');
  
  return await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
    await db.execute("""
      CREATE TABLE forecasts (
        id INTEGER PRIMARY KEY,
        cityName TEXT,
        condition TEXT,
        temperature REAL,
        wind REAL,
        humidity INTEGER
      );
    """);
  }
  );
}

class ForecastProvider {
  ForecastProvider(this.db);
  final Database db;

  Future<List<Forecast>> all() async {
    final rows = await db.rawQuery('SELECT * FROM forecasts');
    return rows.map((row) => Forecast.fromRow(row)).toList();
  }

  Future<void> create(String cityName, String condition, double temperature, double wind, int humidity) async {
    await db.rawInsert(
      'INSERT INTO forecasts(cityName,condition,temperature,wind,humidity) VALUES(?,?,?,?,?)',
      [cityName,condition,temperature,wind,humidity]
    );
  }
}
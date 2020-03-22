import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:ansa/models/article.dart';

Future<List<Article>> topHeadlines() async {
  final response = await http.get("https://newsapi.org/v2/top-headlines?sources=ansa&apiKey=78a502fe89534e3591863784268931ab");
  List articles = json.decode(response.body)["articles"];
  return articles.map((data) => Article.fromData(data)).toList();
}

Future<List<Article>> everything() async {
  final response = await http.get("https://newsapi.org/v2/everything?sources=ansa&apiKey=78a502fe89534e3591863784268931ab");
  List articles = json.decode(response.body)["articles"];
  return articles.map((data) => Article.fromData(data)).toList();
}
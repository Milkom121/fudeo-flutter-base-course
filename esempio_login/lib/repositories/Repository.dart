import 'package:http/http.dart' as http;
import 'package:query_params/query_params.dart';

import 'package:esempio_login/repositories/SessionRepository.dart';
import 'package:esempio_login/repositories/CustomerRepository.dart';

const String HOST = "https://tmpserver.vercel.app";

class Repository {
  HttpClient http;

  SessionRepository session;
  CustomerRepository customer;

  Repository() {
    http = HttpClient(this);

    session = SessionRepository(this);
    customer = CustomerRepository(this);
  }
}

class HttpClient {
  final Repository repository;
  http.Client client;

  HttpClient(this.repository) {
    client = http.Client();
  }

  Map<String, String> headers() {
    return repository.session.jwt != null
        ? {
            "Authorization": "Bearer ${repository.session.jwt}",
          }
        : {};
  }

  String buildUrl(String url, Map queryParameters) {
    final params = URLQueryParams();
    queryParameters?.removeWhere((key, value) => value == null);
    queryParameters?.forEach((key, value) => params.append(key, value));

    return "$HOST/api/v2$url?${params.toString()}";
  }

  Map<String, String> encodeBody(Map<String, dynamic> body) {
    body.removeWhere((key, value) => value == null);
    return body.map((key, value) => MapEntry(key, value.toString()));
  }

  Future<http.Response> get(url, {Map queryParameters}) => http.get(buildUrl(url, queryParameters), headers: headers());

  Future<http.Response> post(url, {Map queryParameters, Map<String, dynamic> bodyParameters}) =>
      http.post(buildUrl(url, queryParameters), headers: headers(), body: encodeBody(bodyParameters));

  Future<http.Response> patch(url, {Map queryParameters, Map<String, dynamic> bodyParameters}) =>
      http.patch(buildUrl(url, queryParameters), headers: headers(), body: encodeBody(bodyParameters));

  Future<http.Response> delete(url, {Map queryParameters}) =>
      http.post(buildUrl(url, queryParameters), headers: headers());
}

class RequestError implements Exception {
  final String error;
  RequestError(this.error);
}

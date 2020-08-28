import 'dart:async';
import 'dart:convert';

import 'package:esempio_login/repositories/Repository.dart';

class CustomerRepository {
  CustomerRepository(this.repository);
  final Repository repository;

  // when login is successfull, it returns customer's jwt
  Future<String> login(String email, String password) async {
    final response = await repository.http.post("/login", bodyParameters: {
      "email": email,
      "password": password,
    });
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      final jwt = data["token"];

      repository.session.setJwt(jwt);

      return jwt;
    }

    throw RequestError(data["error"]);
  }
}

import 'package:esempio_login/repositories/Repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionRepository {
  SessionRepository(this.repository);
  final Repository repository;

  // If customer's logged, this will contain customer's jwt, otherwise it will be null.
  String jwt;

  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.jwt = prefs.getString("TOKEN");
  }

  void setJwt(String jwt) async {
    this.jwt = jwt;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("TOKEN", jwt);
  }

  void logout() {
    setJwt(null);
  }

  bool isUserLogged() {
    return jwt != null;
  }
}

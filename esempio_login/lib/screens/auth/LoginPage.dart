import 'package:flutter/material.dart';

import 'package:esempio_login/repositories/Repository.dart';

import 'package:esempio_login/main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController(text: "gabrielgatu@icloud.com");
  final TextEditingController passwordController = TextEditingController(text: "password");

  void onLoginSubmitted(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      await getIt.get<Repository>().customer.login(email, password);
      Navigator.pushNamed(context, "/home");
    } catch (error) {
      print("errore nel login: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accedi al tuo account"),
        centerTitle: true,
      ),
      body: Center(
          child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade500),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.mail, color: Colors.grey.shade600),
                hintText: "Email",
              ),
            ),
            TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                hintText: "Password",
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: () => onLoginSubmitted(context),
              minWidth: double.infinity,
              height: 45,
              color: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text("Login"),
            ),
          ],
        ),
      )),
    );
  }
}

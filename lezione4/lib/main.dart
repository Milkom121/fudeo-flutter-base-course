import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Le tue carte di credito"),
      ),
      body: Column(
        children: <Widget>[
          BankView(bank: "SanPaolo"),
          BankView(bank: "Banca Sella"),
        ],
      ),
    );
  }
}

class BankView extends StatefulWidget {
  BankView({this.bank});
  final String bank;

  @override
  State<BankView> createState() {
    return _BankViewState();
  }
}

class _BankViewState extends State<BankView> {
  bool active = false;

  void toggleCard() {
    setState(() {
      active = !active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: active ? Colors.grey.shade200 : Colors.white,
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(Icons.credit_card, size: 14),
            SizedBox(
              width: 16,
            ),
            Text(
              widget.bank,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Container(),
            ),
            FlatButton(
              onPressed: toggleCard,
              child: Text(active ? "Disattiva" : "Attiva"),
            ),
          ],
        )); // Container
  }
}

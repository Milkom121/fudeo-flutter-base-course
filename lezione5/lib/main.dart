import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: SideBar(),
        ),
        Positioned(left: 0, right: 100, top: 0, bottom: 0, child: Body())
      ],
    ));
  }
}

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        color: Colors.grey.shade200,
        child: SafeArea(
            child: Column(
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add, size: 20),
            )
          ],
        )));
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text(
                "Contats",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 32,
              ),
              Contact(name: "Mario Rossi", address: "Corso Vittorio Emanuele II, Torino"),
              Contact(name: "Mario Rossi", address: "Corso Vittorio Emanuele II, Torino"),
              Contact(name: "Mario Rossi", address: "Corso Vittorio Emanuele II, Torino"),
            ])));
  }
}

class Contact extends StatelessWidget {
  Contact({@required this.name, @required this.address});
  final String name;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        address,
        style: TextStyle(fontSize: 12),
      ),
      leading: Icon(Icons.person, color: Colors.indigo),
    ));
  }
}

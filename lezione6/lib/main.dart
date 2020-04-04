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
      appBar: AppBar(title: Text("Libreria musicale"), centerTitle: true, actions: <Widget>[
        PopupMenuButton<int>(
          itemBuilder: (context) => [
            PopupMenuItem<int>(
              value: 1,
              child: Text("Logout"),
            )
          ],
        )
      ]),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(children: <Widget>[
          Card(
              child: ListTile(
            leading: Icon(Icons.album),
            title: Text('Soldi'),
            subtitle: Text('Cantata da Mahmood, Produzione di Dasdust e Charlies'),
          )),
          SizedBox(
            height: 8,
          ),
          Card(
              child: ListTile(
            leading: Icon(Icons.album),
            title: Text('Soldi'),
            subtitle: Text('Cantata da Mahmood, Produzione di Dasdust e Charlies'),
          )),
        ]),
      ),
      drawer: Drawer(),
    );
  }
}

class Drawer extends StatefulWidget {
  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<Drawer> {
  bool _rememberUser = false;

  void onRememberUserChanged(value) {
    setState(() {
      print(_rememberUser);
      _rememberUser = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Settings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            ListTile(
                title: Text("Remember User"),
                subtitle: Text("Automatically log-in based on user history"),
                trailing: Switch(
                  value: _rememberUser,
                  onChanged: onRememberUserChanged,
                ))
          ],
        ),
      ),
    );
  }
}

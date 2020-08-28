import 'package:flutter/material.dart';

class Day {
  final int nr;
  String task;
  Day(this.nr);
}

class Month {
  final String name;
  List<Day> days;

  Month(this.name, int dayNr) {
    days = List.generate(dayNr, (dayNr) => Day(dayNr + 1));
  }
}

final months = [
  Month("Gennaio", 31),
  Month("Febbraio", 28),
  Month("Marzo", 31),
  Month("Aprile", 30),
  Month("Maggio", 31),
  Month("Giugno", 30),
  Month("Luglio", 31),
  Month("Agosto", 31),
  Month("Settembre", 30),
  Month("Ottobre", 31),
  Month("Novembre", 30),
  Month("Dicembre", 31)
];

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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _noteController = TextEditingController();
  int _selectedMonthIndex = 0;

  void onNoteSubmit(Day day) {
    setState(() {
      day.task = _noteController.text.trim();
      _noteController.clear();
    });
    Navigator.of(context).pop();
  }

  void createTask(BuildContext context, Day day) {
    showBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Day ${day.nr}",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(months[_selectedMonthIndex].name),
                SizedBox(
                  height: 32,
                ),
                TextField(
                  controller: _noteController,
                  decoration: InputDecoration(border: InputBorder.none, hintText: "Write your notes"),
                ),
                SizedBox(
                  height: 32,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  onPressed: () {
                    onNoteSubmit(day);
                  },
                  color: Colors.blue,
                  child: Text(
                    "Submit note",
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ), // MaterialButton
              ], // <Widget> []
            ), // Column
          ); // Container
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calendario"),
          centerTitle: true,
        ),
        body: Builder(
            builder: (context) => GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  children: List.generate(months[_selectedMonthIndex].days.length, (index) {
                    return Card(
                        child: ListTile(
                      onTap: () {
                        createTask(context, months[_selectedMonthIndex].days[index]);
                      },
                      title: Text(months[_selectedMonthIndex].days[index].nr.toString()),
                      subtitle: Text(months[_selectedMonthIndex].days[index].task ?? "No task"),
                    ));
                  }),
                )),
        drawer: Container(
            width: 200,
            color: Colors.white,
            child: ListView.separated(
              itemCount: months.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedMonthIndex = index;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(padding: EdgeInsets.all(16), child: Text(months[index].name)));
              },
              separatorBuilder: (context, index) {
                return Container(
                  height: 3,
                  color: Colors.grey.shade200,
                );
              },
            )));
  }
}

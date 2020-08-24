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
  bool isBottomSheetOpen = false;

  void onNoteSubmit(Day day) {
    setState(() {
      day.task = _noteController.text.trim();

      // Impostiamo il BottomSheet come chiuso
      isBottomSheetOpen = false;
    });
    _noteController.clear();
    Navigator.of(context).pop();
  }

  void onSelectedMonthChange(int newMonthIndex) {
    setState(() {
      _selectedMonthIndex = newMonthIndex;
    });
    Navigator.of(context).pop();
  }

  void onDrawerOpen() {
    if (isBottomSheetOpen) {
      Navigator.of(context).pop();
    }
  }

  void createTask(BuildContext context, Day day) {
    // Impostiamo il BottomSheet come aperto
    setState(() {
      isBottomSheetOpen = true;
    });

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
          title: Text(months[_selectedMonthIndex].name),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: months[_selectedMonthIndex].days.length,
            itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                onTap: () {
                  createTask(context, months[_selectedMonthIndex].days[index]);
                },
                title: Text(months[_selectedMonthIndex].days[index].nr.toString()),
                subtitle: Text(months[_selectedMonthIndex].days[index].task ?? "No task"),
              ));
            }),
        drawer: Drawer(
          onSelectedMonthChange: onSelectedMonthChange,
          onOpen: onDrawerOpen,
        ));
  }
}

class Drawer extends StatefulWidget {
  Drawer({
    @required this.onSelectedMonthChange,
    this.onOpen,
    this.onClose,
  });

  final Function(int) onSelectedMonthChange;
  final Function onOpen;
  final Function onClose;

  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<Drawer> {
  @override
  void initState() {
    // Abbreviazione per chiamare onOpen solamente quando non è null
    widget.onOpen?.call();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // Abbreviazione per chiamare onClose solamente quando non è null
    widget.onClose?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        color: Colors.white,
        child: ListView.separated(
          itemCount: months.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () => widget.onSelectedMonthChange(index),
                child: Container(padding: EdgeInsets.all(20), child: Text(months[index].name)));
          },
          separatorBuilder: (context, index) {
            return Container(
              height: 1,
              color: Colors.grey.shade200,
            );
          },
        ));
  }
}

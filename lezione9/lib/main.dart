import 'package:flutter/material.dart';

class IntroPage {
  IntroPage({@required this.title, @required this.subtitle, @required this.color});

  String title;
  String subtitle;
  Color color;
}

final List<IntroPage> _introPage = [
  IntroPage(
      title: "The world",
      subtitle: "Lorem ipsum is simply dummy text of the printing and typesetting industry",
      color: Colors.blue),
  IntroPage(
      title: "Is Beautiful",
      subtitle: "Lorem ipsum is simply dummy text of the printing and typesetting industry",
      color: Colors.indigo),
  IntroPage(
      title: "You  Know?",
      subtitle: "Lorem ipsum is simply dummy text of the printing and typesetting industry",
      color: Colors.teal),
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
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  void onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  bool isLastPage() {
    return _currentPageIndex == _introPage.length - 1;
  }

  void nextPage() {
    if (!isLastPage()) {
      _pageController.animateToPage(_currentPageIndex + 1, duration: Duration(milliseconds: 300), curve: Curves.linear);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _introPage[_currentPageIndex].color,
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.transparent,
        title: Text("Welcome"),
        centerTitle: true,
        actions: <Widget>[
          isLastPage()
              ? IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.check_circle),
                )
              : IconButton(
                  onPressed: nextPage,
                  icon: Icon(Icons.arrow_forward),
                )
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: onPageChanged,
        itemCount: _introPage.length,
        itemBuilder: (context, index) {
          return IntroPageView(_introPage[index]);
        },
      ),
    );
  }
}

class IntroPageView extends StatelessWidget {
  IntroPageView(this.introPage);
  final IntroPage introPage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.all(32),
                child: Column(
                  children: <Widget>[
                    Text(introPage.title,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white)), // Text
                    SizedBox(height: 16), // Sized Box
                    Text(
                      introPage.subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ), // Text
                  ], // <Widget>[]
                ), // Coloumn
              ), // Container
            )), // SafeArea // Positionioed
      ], // <Widget>[]
    ); // Stack
  }
}

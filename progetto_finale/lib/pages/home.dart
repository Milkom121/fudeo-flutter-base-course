import 'package:flutter/material.dart';

import 'package:ansa/pages/last_hour.dart';
import 'package:ansa/pages/historic_news.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.dehaze),
          onPressed: () {},
        ),
        title: Image.asset("assets/logo.png"),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: <Widget>[
          LastHourPage(),
          HistoricNewsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        unselectedItemColor: Colors.black26,
        selectedItemColor: Colors.black,
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 200), curve: Curves.linear);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text("In tendenza"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hourglass_full),
            title: Text("Tutti"),
          ),
        ],
      ),
    );
  }
}
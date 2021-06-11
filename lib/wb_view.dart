import 'package:flutter/material.dart';
import 'dart:io';
import 'package:app/config/config.dart';
import 'dart:async';
import 'package:app/home.dart';
// import 'package:app/cathelete_news.dart';
// import 'package:app/chat_view.dart';
// import 'package:app/shop_view.dart';
// import 'package:app/zoom_view.dart';
import 'main.dart';

class InAppWebViewExampleScreen extends StatefulWidget {
  @override
  _InAppWebViewExampleScreenState createState() =>
      new _InAppWebViewExampleScreenState();
}

class _InAppWebViewExampleScreenState extends State<InAppWebViewExampleScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey webViewKey = GlobalKey();

  TabController _controller;
  int _selectedIndex = 0;

  List<Widget> list = [
    Tab(icon: Icon(Icons.card_travel)),
    Tab(icon: Icon(Icons.add_shopping_cart)),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: list.length, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  int _currentIndex = 0;
  PageController _pageController = PageController();
  DateTime currentBackPressTime;

  List<IconData> iconList = [
    Icons.home_outlined,
    Icons.video_collection_outlined,
    Icons.save,
    Icons.account_circle_outlined,
    Icons.accessibility_new_outlined,
  ];

  @override
  void dispose() {
    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(index,
        curve: Curves.easeIn, duration: Duration(milliseconds: 250));
  }

  Future<bool> _onBackPressed() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to exit'),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            // ignore: deprecated_member_use
            FlatButton(
              child: Text('Yes'),
              /*Navigator.of(context).pop(true)*/
              onPressed: () => exit(0),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 5,
        child: Scaffold(
          bottomNavigationBar: menu(),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              WebViewExample(),
              WebViewExample(),
              WebViewExample(),
              WebViewExample(),
              WebViewExample(),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      color: Color(0xFF3F5AA6),
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Colors.blue,
        tabs: [
          Tab(
            text: "Home",
            icon: Icon(Icons.home),
          ),
          Tab(
            text: "Chat",
            icon: Icon(Icons.chat_bubble_rounded),
          ),
          Tab(
            text: "Shop",
            icon: Icon(Icons.shopping_bag),
          ),
          Tab(
            text: "Insight",
            icon: Icon(Icons.fiber_new_rounded),
          ),
          Tab(
            text: "Zoom",
            icon: Icon(Icons.voice_chat_rounded),
          ),
        ],
      ),
    );
  }
}

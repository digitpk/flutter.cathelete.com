import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:app/config/config.dart';
import 'package:app/page/business/home.dart';
import 'package:app/page/business/cathelete_news.dart';
import 'package:app/page/business/chat.dart';
import 'package:app/page/business/shop.dart';
import 'package:app/page/business/zoom.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class BusinessAccessPoint extends StatefulWidget {
  @override
  _BusinessAccessPointState createState() => new _BusinessAccessPointState();
}

class _BusinessAccessPointState extends State<BusinessAccessPoint>
    with SingleTickerProviderStateMixin {
  final GlobalKey webViewKey = GlobalKey();

  TabController _controller;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ChatPage(),
    ShopPage(),
    CatheleteNewsPage(),
    ZoomPage(),
  ];

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300],
              hoverColor: Config().appColor,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Config().appColor,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.chat_bubble_outline_outlined,
                  text: 'Chat',
                ),
                GButton(
                  icon: LineIcons.shoppingBag,
                  text: 'Shop',
                ),
                GButton(
                  icon: LineIcons.newspaper,
                  text: 'Insight',
                ),
                GButton(
                  icon: Icons.voice_chat_outlined,
                  text: 'Zoom',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
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

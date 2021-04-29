import 'package:flutter/material.dart';

class Config {
  static const MaterialColor myColor = MaterialColor(
    _myColorValue,
    <int, Color>{
      50: Color(_myColorValue),
      100: Color(_myColorValue),
      200: Color(_myColorValue),
      300: Color(_myColorValue),
      350: Color(
          _myColorValue), // only for raised button while pressed in light theme
      400: Color(_myColorValue),
      500: Color(_myColorValue),
      600: Color(_myColorValue),
      700: Color(_myColorValue),
      800: Color(_myColorValue),
      850: Color(_myColorValue), // only for background color in dark theme
      900: Color(_myColorValue),
    },
  );
  static const int _myColorValue = 0xFF3F5AA6;

  final String appName = 'Cathelete Network';
  dynamic webView = {
    'manage_admin_cathelete_page': {
      'url': 'https://manage.cathelete.com/admin/'
    },
    'fitness_page': {'url': 'https://manage.cathelete.com/module/'},
    'cathelete_news': {
      'url': 'https://cathelete.com/',
    },
    'zoom_page': {
      'url': 'https://manage.cathelete.com/admin/zoom_meeting_manager/index'
    },
    'chat_page': {
      'url':
          'https://manage.cathelete.com/admin/prchat/Prchat_Controller/chat_full_view'
    },
    'shop_page': {'url': 'https://shop.cathelete.com/'}
  };

  final String epass = '9zVSKC@6ES7(S75k*`WF4{%&';

  final Color appColor = myColor;
  final Color appBarColor = Color(0xFFFFFFFF);
}

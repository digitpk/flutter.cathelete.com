import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:app/config/config.dart';
import 'package:xxtea/xxtea.dart';
import 'package:provider/provider.dart';

class AppLoginTypeBloc extends ChangeNotifier {
  AppLoginTypeBloc() {
    getAppLoginType();
  }

  String _loginType = 'guest';
  String get loginType => _loginType;

  Future setAppLoginType(loginType) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String encrypted_login_type =
        xxtea.encryptToString(loginType, Config().epass);
    await sp.setString('app_login_type', encrypted_login_type);
    _loginType = loginType;
    getAppLoginType();
    notifyListeners();
  }

  Future getAppLoginType() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    try {
      _loginType =
          xxtea.decryptToString(sp.getString('app_login_type'), Config().epass);
    } catch (e) {
      _loginType = '';
    }
    notifyListeners();
  }
}

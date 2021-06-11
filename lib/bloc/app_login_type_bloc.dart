import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:app/config/config.dart';
import 'package:xxtea/xxtea.dart';
import 'package:provider/provider.dart';

class AppLoginType extends ChangeNotifier {
  String _loginType = 'user';
  String get loginType => _loginType;

  Future setAppLoginType(context, loginType) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String encrypted_login_type =
        xxtea.encryptToString(loginType, Config().epass);
    await sp.setString('app_login_type', encrypted_login_type);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:app/config/config.dart';
import 'package:provider/provider.dart';
import 'package:app/bloc/app_login_type_bloc.dart';

class GuestAccessPoint extends StatefulWidget {
  @override
  _GuestAccessPointState createState() => new _GuestAccessPointState();
}

class _GuestAccessPointState extends State<GuestAccessPoint>
    with SingleTickerProviderStateMixin {
  final GlobalKey webViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setAppLoginType(String loginType) async {
    final AppLoginTypeBloc altb =
        Provider.of<AppLoginTypeBloc>(context, listen: false);
    altb.setAppLoginType(loginType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/dark_background.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: FractionalTranslation(
                  translation: Offset(0, -7.0),
                  child: Image.asset('assets/images/logo.png',
                      fit: BoxFit.cover, height: 20),
                ),
              ),
              Container(
                child: FractionalTranslation(
                  translation: Offset(0, -5.0),
                  child: Text(
                    'Welcome In ' + Config().appName,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15.0),
                // ignore: deprecated_member_use
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.black87,
                    primary: Colors.grey[300],
                    minimumSize: Size(88, 36),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                  ),
                  onPressed: () {
                    setAppLoginType('business');
                  },
                  child: Text('Login As Business'),
                ),
              ),
              Container(
                  child: Text(
                'OR',
                style: TextStyle(color: Colors.white),
              )),
              Container(
                margin: EdgeInsets.only(top: 15.0),
                // ignore: deprecated_member_use
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.black87,
                    primary: Colors.grey[300],
                    minimumSize: Size(88, 36),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                  ),
                  onPressed: () {
                    setAppLoginType('user');
                  },
                  child: Text('Login As User'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

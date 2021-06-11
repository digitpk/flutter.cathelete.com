import 'package:flutter/material.dart';
import 'package:app/bloc/app_login_type_bloc.dart';
import 'package:provider/provider.dart';
import 'package:app/config/config.dart';
import 'package:app/unit/AccessPoint/business_access_point.dart';
import 'package:app/unit/AccessPoint/user_access_point.dart';
import 'package:app/unit/AccessPoint/guest_access_point.dart';

class MainAccessPoint extends StatefulWidget {
  @override
  _MainAccessPointState createState() => new _MainAccessPointState();
}

class _MainAccessPointState extends State<MainAccessPoint>
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

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLoginTypeBloc>(
      builder: (context, AppLoginTypeBloc, child) => Scaffold(
        body: AppLoginTypeBloc.loginType == 'business'
            ? BusinessAccessPoint()
            : AppLoginTypeBloc.loginType == 'user'
                ? UserAccessPoint()
                : GuestAccessPoint(),
      ),
    );
  }
}

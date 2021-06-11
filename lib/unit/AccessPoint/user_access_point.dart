import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/bloc/app_login_type_bloc.dart';

class UserAccessPoint extends StatefulWidget {
  @override
  _UserAccessPointState createState() => new _UserAccessPointState();
}

class _UserAccessPointState extends State<UserAccessPoint>
    with SingleTickerProviderStateMixin {
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
              Text('Coming Soon',
                  style: TextStyle(fontSize: 18.0, color: Colors.white)),
              Container(
                margin: EdgeInsets.only(top: 20.0),
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
            ],
          ),
        ),
      ),
    );
  }
}

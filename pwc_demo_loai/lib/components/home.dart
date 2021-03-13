import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:pwc_demo_loai/api/api.dart';
import 'package:pwc_demo_loai/components/adminpage/adminpage.dart';
import 'package:pwc_demo_loai/components/body.dart';
import 'package:pwc_demo_loai/components/userpage/userpage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _body = Body();
  @override
  void initState() {
    super.initState();
    getSession();
  }

  Future<void> getSession() async {
    var email = await FlutterSession().get("email");
    var password = await FlutterSession().get("pass");
    if (password != null) {
      if (await login(email, password.toString(), true) == "0") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminPage()),
        );
      } else {
        setState(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UserPage()),
          );
        });
      }
    } else {
      setState(() {
        _body = Body();
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NewGradientAppBar(
          elevation: 30,
          centerTitle: true,
          gradient: LinearGradient(
              colors: [Colors.red[800], Colors.deepOrange, Colors.amber[800]]),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Suggestion",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              Icon(
                CupertinoIcons.cube_box,
                size: 35,
              )
            ],
          ),
        ),
        body: _body);
  }
}

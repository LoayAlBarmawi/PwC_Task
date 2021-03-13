import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pwc_demo_loai/api/api.dart';
import 'package:pwc_demo_loai/components/adminpage/adminpage.dart';
import 'package:pwc_demo_loai/components/userpage/userpage.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _emailcon = TextEditingController();
  TextEditingController _passcon = TextEditingController();
  bool _sl = false;
  @override
  Widget build(BuildContext context) {
    double width1 = MediaQuery.of(context).size.width * .7;
    return CupertinoScrollbar(
      thickness: 5,
      thicknessWhileDragging: 10,
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(maxWidth: 700),
          width: width1,
          child: Center(
            child: Form(
              child: Column(
                children: [
                  Text(
                    "Email",
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: MediaQuery.of(context).size.height * .03),
                  ),
                  TextFormField(
                    controller: _emailcon,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Password",
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: MediaQuery.of(context).size.height * .03),
                  ),
                  TextFormField(
                    controller: _passcon,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .7,
                    child: CheckboxListTile(
                        title: Text(
                          "Remember me:",
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize:
                                  MediaQuery.of(context).size.height * .03),
                        ),
                        value: _sl,
                        onChanged: (nv) {
                          setState(() {
                            _sl = nv;
                          });
                        }),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      var r = await login(_emailcon.text, _passcon.text, _sl);
                      if (r == "1") {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => UserPage()),
                        );
                      } else {
                        if (r == "0") {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminPage()),
                          );
                        } else {
                          _emailcon.clear();
                          _passcon.clear();
                          Fluttertoast.showToast(
                            webPosition: "center",
                            timeInSecForIosWeb: 4,
                            msg: "Wrong Credentials",
                            webBgColor:
                                "linear-gradient(to right,#DC143C	, #DC143C)",
                            webShowClose: true,
                          );
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(colors: [
                            Colors.red[800],
                            Colors.deepOrange,
                          ])),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.height * .03),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

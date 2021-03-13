import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pwc_demo_loai/api/api.dart';

class AddAdmin extends StatefulWidget {
  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  bool _validname = false;
  bool _validemail = false;
  bool _validnum = false;

  String _namehint;
  String _mailhint;
  String _numhint;

  TextEditingController _namecon = TextEditingController();
  TextEditingController _emailcon = TextEditingController();
  TextEditingController _addresscon = TextEditingController();
  TextEditingController _phonecon = TextEditingController();
  TextEditingController _passcon = TextEditingController();
  String result;
  bool _sl = false;
  CarouselController _conn = CarouselController();
  final _formKey1 = GlobalKey<FormState>();
  void validName(val) {
    if (val.isEmpty || val.length < 6) {
      setState(() {
        _validname = false;
        _namehint = "Invalid Input";
      });
      return null;
    }
    setState(() {
      _validname = true;
      _namehint = null;
    });
    return null;
  }

  void validNum(val) {
    if (!val.contains(RegExp(r"^[0][7][7-9][0-9]{7}"))) {
      setState(() {
        _validnum = false;
        _numhint = "Wrong Phone Number Format";
      });
      return null;
    }
    setState(() {
      _validnum = true;
      _numhint = null;
    });
    return null;
  }

  void validEmail(val) {
    if (!val.contains(RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
      setState(() {
        _validemail = false;
        _mailhint = "Invalid Input";
      });
      return null;
    }
    setState(() {
      _validemail = true;
      _mailhint = null;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.deepOrange, width: 2),
              borderRadius: BorderRadius.circular(15)),
          constraints: BoxConstraints(maxWidth: 900),
          width: MediaQuery.of(context).size.width * .7,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Form(
                key: _formKey1,
                child: CarouselSlider(
                  items: [
                    Column(children: [
                      Text(
                        "Full Name",
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: MediaQuery.of(context).size.height * .03),
                      ),
                      TextFormField(
                        decoration: InputDecoration(errorText: _namehint),
                        onChanged: (val) {
                          validName(val);
                        },
                        validator: (val) {
                          if (val.isEmpty || val.length <= 6) {
                            return "Invalid Input";
                          }
                          return null;
                        },
                        controller: _namecon,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Phone",
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: MediaQuery.of(context).size.height * .03),
                      ),
                      TextFormField(
                        decoration: InputDecoration(errorText: _numhint),
                        onChanged: (val) {
                          validNum(val);
                        },
                        validator: (val) {
                          if (!val.contains(RegExp(r"^[0][7][7-9][0-9]{7}"))) {
                            return "Wrong Phone Number Format";
                          }
                          return null;
                        },
                        controller: _phonecon,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Email",
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: MediaQuery.of(context).size.height * .03),
                      ),
                      TextFormField(
                        decoration: InputDecoration(errorText: _mailhint),
                        onChanged: (val) {
                          validEmail(val);
                        },
                        validator: (val) {
                          if (!val.contains(RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                            return "Enter Valid Email Address";
                          }
                          return null;
                        },
                        controller: _emailcon,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          validName(_namecon.text);
                          validEmail(_emailcon.text);
                          if (_validname && _validemail && _validnum) {
                            _conn.nextPage();
                          } else {}
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
                              "Next",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.height * .03),
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Column(
                      children: [
                        Text(
                          "Password",
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize:
                                  MediaQuery.of(context).size.height * .03),
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val.isEmpty ||
                                val.length < 8 ||
                                !val.contains(RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'))) {
                              return "Password Too Weak";
                            }
                            return null;
                          },
                          controller: _passcon,
                          obscureText: true,
                          maxLength: 16,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Confirm Password",
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize:
                                  MediaQuery.of(context).size.height * .03),
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val != _passcon.text) {
                              return "Passwords Do Not Match";
                            }
                            return null;
                          },
                          obscureText: true,
                          maxLength: 16,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Address",
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize:
                                  MediaQuery.of(context).size.height * .03),
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val.length < 6) {
                              return "Enter Correct Address";
                            }
                            return null;
                          },
                          controller: _addresscon,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .8,
                          child: CheckboxListTile(
                              title: Text(
                                "I accept the terms and conditions:",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            .02),
                              ),
                              value: _sl,
                              onChanged: (nv) {
                                setState(() {
                                  _sl = nv;
                                });
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          onPressed: () async {
                            if (_formKey1.currentState.validate() &&
                                _sl == true) {
                              result = await registerAdmin(
                                  _emailcon.text,
                                  _namecon.text,
                                  _passcon.text,
                                  _addresscon.text,
                                  _phonecon.text);
                              if (result == "true") {
                                _emailcon.clear();
                                _addresscon.clear();
                                _namecon.clear();
                                _passcon.clear();
                                _phonecon.clear();

                                Fluttertoast.showToast(
                                    msg: "Admin Created Successfully.",
                                    webBgColor:
                                        "linear-gradient(to right,#DC143C	, #ee7600)",
                                    webShowClose: true,
                                    timeInSecForIosWeb: 10);
                              } else {
                                if (result == "false") {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Something Went Wrong, please Try Again.",
                                      webBgColor:
                                          "linear-gradient(to right,#DC143C	, #ee7600)",
                                      webShowClose: true,
                                      timeInSecForIosWeb: 10);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: result,
                                      webBgColor:
                                          "linear-gradient(to right,#DC143C	, #ee7600)",
                                      webShowClose: true,
                                      timeInSecForIosWeb: 10);
                                }
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
                                "Register",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            .03),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              _conn.previousPage();
                            },
                            child: Text("Go Back",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            .02)))
                      ],
                    ),
                  ],
                  carouselController: _conn,
                  options: CarouselOptions(
                      scrollPhysics: NeverScrollableScrollPhysics(),
                      height: MediaQuery.of(context).size.height * .7,
                      viewportFraction: 1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

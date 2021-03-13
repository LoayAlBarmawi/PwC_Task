import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pwc_demo_loai/api/api.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ComplaintForm extends StatefulWidget {
  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  TextEditingController _titlecon = TextEditingController();
  TextEditingController _contentcon = TextEditingController();
  String result;
  double _sat = 1;
  String _titleval = "";
  String _conval = "";
  CarouselController _conn = CarouselController();
  final _formKey1 = GlobalKey<FormState>();
  titleVal(val) {
    if (val.isEmpty || val.length < 5) {
      setState(() {
        _titleval = "Title Too Short";
      });
      return;
    }
    setState(() {
      _titleval = null;
    });
    return;
  }

  void conVal(val) {
    if (val.isEmpty || val.length < 20) {
      setState(() {
        _conval = "Content Too Short";
      });
      return;
    }
    setState(() {
      _conval = null;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Form(
              key: _formKey1,
              child: CarouselSlider(
                items: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.red[600], Colors.deepOrange]),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "What's the issue?",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: max(
                                  80, MediaQuery.of(context).size.width * .1)),
                        ),
                        Text(
                          "Title:",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: max(
                                  20, MediaQuery.of(context).size.width * .05)),
                        ),
                        TextFormField(
                          onChanged: (val) {
                            titleVal(val);
                          },
                          decoration: InputDecoration(
                              errorText: _titleval,
                              errorStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: max(
                                      20,
                                      MediaQuery.of(context).size.width *
                                          .03))),
                          controller: _titlecon,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: max(
                                  20, MediaQuery.of(context).size.width * .05)),
                        ),
                        TextButton(
                          onPressed: () {
                            if (_titleval == null) {
                              _conn.nextPage();
                            }
                          },
                          child: Text(
                            "Next Page",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: max(
                                  20, MediaQuery.of(context).size.width * .05),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.deepOrange, Colors.amber]),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Can You Elaborate?",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: max(
                                  80, MediaQuery.of(context).size.width * .1)),
                        ),
                        Text(
                          "Description:",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: max(
                                  20, MediaQuery.of(context).size.width * .05)),
                        ),
                        TextFormField(
                          onChanged: (val) {
                            conVal(val);
                          },
                          decoration: InputDecoration(
                              errorText: _conval,
                              errorStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: max(
                                      20,
                                      MediaQuery.of(context).size.width *
                                          .03))),
                          controller: _contentcon,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: max(
                                  20, MediaQuery.of(context).size.width * .05)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () {
                                _conn.previousPage();
                              },
                              child: Text(
                                "Prev Page",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: max(20,
                                      MediaQuery.of(context).size.width * .05),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (_conval == null) {
                                  _conn.nextPage();
                                }
                              },
                              child: Text(
                                "Next Page",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: max(20,
                                      MediaQuery.of(context).size.width * .05),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.amber, Colors.deepOrange]),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Text(
                          "Rate Us!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: max(
                                  80, MediaQuery.of(context).size.width * .1)),
                        ),
                        Text(
                          "On a scale from 1 to 5, how satisfied are you?",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: max(
                                  20, MediaQuery.of(context).size.width * .05)),
                        ),
                        SfSlider(
                          activeColor: Colors.white,
                          inactiveColor: Colors.white,
                          labelPlacement: LabelPlacement.onTicks,
                          showDivisors: true,
                          showTicks: true,
                          interval: 1,
                          min: 1,
                          max: 5,
                          onChanged: (val) {
                            setState(() {
                              _sat = val;
                            });
                          },
                          value: _sat,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ":(",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: max(
                                        20,
                                        MediaQuery.of(context).size.width *
                                            .05)),
                              ),
                              Text(
                                ":D",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: max(
                                        20,
                                        MediaQuery.of(context).size.width *
                                            .05)),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () {
                                _conn.previousPage();
                              },
                              child: Text(
                                "Prev Page",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: max(20,
                                      MediaQuery.of(context).size.width * .05),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                var res = await addComplaint(_titlecon.text,
                                    _contentcon.text, _sat.toInt().toString());
                                if (res == "true") {
                                  _conn.nextPage();
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Something Went Wrong, please Try Again.",
                                      webBgColor:
                                          "linear-gradient(to right,#DC143C	, #DC143C)",
                                      webShowClose: true,
                                      timeInSecForIosWeb: 10);
                                }
                              },
                              child: Text(
                                "Submit!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: max(20,
                                      MediaQuery.of(context).size.width * .05),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.deepOrange, Colors.amber]),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Thank You!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: max(
                                  80, MediaQuery.of(context).size.width * .1)),
                        ),
                        Text(
                          "We'll get back to you ASAP!",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: max(
                                  20, MediaQuery.of(context).size.width * .05)),
                        ),
                      ],
                    ),
                  ),
                ],
                carouselController: _conn,
                options: CarouselOptions(
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    height: MediaQuery.of(context).size.height - 56,
                    viewportFraction: 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
